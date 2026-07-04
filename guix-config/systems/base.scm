(define-module (guix-config systems base)
               #:use-module (gnu)
               #:use-module (gnu system)
               #:use-module (gnu system nss)
               #:use-module (nongnu packages linux)
               #:use-module (nongnu system linux-initrd)
               #:export (base-operating-system
                          guix-home-config))

(use-service-modules avahi base cups dbus desktop guix linux mcron
                     networking pm ssh)

(use-package-modules admin certs cups curl libusb linux package-management
                     version-control vim wget)

(define %main-user-name "franek")

(define-public base-operating-system
               (operating-system
                 (host-name "host")
                 (timezone "Europe/Warsaw")
                 (locale "en_US.utf8")

                 ;; Nonguix kernel/firmware.  Keep this in base if every machine is
                 ;; expected to need proprietary firmware for Wi-Fi, Bluetooth, GPU, etc.
                 (kernel linux)
                 (initrd microcode-initrd)
                 (firmware (list linux-firmware))

                 ;; Host configs only need to provide a /boot/efi filesystem.
                 (bootloader
                   (bootloader-configuration
                     (bootloader grub-efi-bootloader)
                     (targets '("/boot/efi"))))

                 ;; Shared filesystems.  Host configs should cons their root/EFI mounts
                 ;; onto this list instead of replacing it with %base-file-systems.
                 (file-systems
                   (cons* (file-system
                            (mount-point "/tmp")
                            (device "none")
                            (type "tmpfs")
                            (check? #f))
                          %base-file-systems))

                 (users
                   (cons (user-account
                           (name %main-user-name)
                           (group "users")
                           (home-directory (string-append "/home/" %main-user-name))
                           (supplementary-groups
                             '("wheel"   ; sudo/admin actions through polkit/sudo
                               "netdev"  ; NetworkManager-controlled devices
                               "audio"
                               "video"
                               "kvm"
                               "tty"
                               "input"
                               "lp")))   ; printing/scanning and some Bluetooth workflows
                         %base-user-accounts))

                 (packages
                   (cons* git
                          curl
                          wget
                          htop
                          tree
                          stow
                          brightnessctl
                          vim
                          neovim
                          %base-packages))

                 ;; WM-agnostic workstation services.  Sway, XMonad, GNOME, etc. should
                 ;; layer their own display/session service on top
                 (services
                   (append
                     %base-services
                     (list
                       ;; Seat/session
                       (service elogind-service-type)

                       ;; Polkit 
                       polkit-wheel-service
                       (service polkit-service-type)
                       (service dbus-root-service-type)

                       ;; Networking
                       (service network-manager-service-type)
                       (service wpa-supplicant-service-type)
                       (service modem-manager-service-type)
                       (service usb-modeswitch-service-type)
                       (service bluetooth-service-type
                                (bluetooth-configuration
                                  (auto-enable? #t)))

                       ;; Common desktop hardware integration.
                       (service avahi-service-type)        ; mDNS, .local discovery
                       (service udisks-service-type)       ; user mounting of removable disks
                       (service upower-service-type)       ; battery/power reporting
                       (service cups-pk-helper-service-type)
                       (service geoclue-service-type)      ; location provider for apps
                       fontconfig-file-system-service      ; system font cache

                       ;; Power management
                       (service tlp-service-type
                                (tlp-configuration
                                  (cpu-boost-on-ac? #t)
                                  (cpu-boost-on-bat? #f)
                                  (wifi-pwr-on-bat? #t)
                                  (cpu-energy-perf-policy-on-ac "balance_performance")
                                  (cpu-energy-perf-policy-on-bat "balance_power")))

                       ;; Printing/scanning.
                       (service sane-service-type)
                       (service cups-service-type
                                (cups-configuration
                                  (web-interface? #t)
                                  (extensions (list cups-filters))))

                       (service ntp-service-type)
                       (service openssh-service-type)

                       ;; Device rules for user access to phones/MTP and brightness controls.
                       (simple-service 'mtp-udev-rules
                                       udev-service-type
                                       (list libmtp))
                       (udev-rules-service 'brightnessctl-udev-rules brightnessctl)

                       ;; Weekly GC: remove generations older than one month
                       (simple-service 'system-cron-jobs
                                       mcron-service-type
                                       (list #~(job "5 0 * * 0"
                                                    "guix gc -d 1m -F 10G"))))))

                 ;; Resolve .local hostnames via mDNS.
                 (name-service-switch %mdns-host-lookup-nss)))

(define-public (guix-home-config home-environment)
               "Provision HOME-ENVIRONMENT for the main user during guix system reconfigure."
               (service guix-home-service-type
                        `((,%main-user-name ,home-environment))))
