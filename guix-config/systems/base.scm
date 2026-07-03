;; the role of this module is to provide
;; desktop enviornment agnostic base configuration
(define-module (guix-config systems base)
               #:use-module (gnu)
               #:use-module (gnu system)
               #:use-module (gnu system nss)
               #:use-module (gnu system setuid)
               #:use-module (gnu system privilege)
	       #:use-module (gnu packages
               #:use-module (nongnu packages linux)
               #:use-module (nongnu system linux-initrd)
               #:export (base-operating-system))

(use-service-modules guix admin sysctl pm linux networking dns ssh
                     dbus avahi cups desktop xorg audio mcron)

(use-package-modules shells bash vim certs file-systems nfs linux libusb
                     networking cups freedesktop fonts audio video gnome
                     version-control package-management curl)

(define-public base-operating-system
               (operating-system
                 (host-name "changeme-please")
                 (timezone "Europe/Warsaw")
                 (locale "en_US.utf8")

                 ;; Use non-free linux
                 (kernel linux)
                 (initrd microcode-initrd)
                 (firmware (list linux-firmware))

                 ;; Use the uefi variant of grub with the efi system
                 ;; Partition mounted on /boot/efi
                 (bootloader (bootloader-configuration
                               (bootloader grub-efi-bootloader)
                               (targets '("/boot/efi"))))

                 ;; This file-system entry is meant to be overridden
                 (file-systems (cons*
                                 (file-system
                                   (mount-point "/tmp")
                                   (device "none")
                                   (type "tmpfs")
                                   (check? #f))
                                 %base-file-systems))

                 ;; Main user on every derived system
                 (users (cons (user-account
                                (name "franek")
                                (group "users")
                                (home-directory "/home/franek")
                                (supplementary-groups '("wheel"
                                                        "netdev"
                                                        "audio"
                                                        "video"
                                                        "kvm"
                                                        "tty"
                                                        "input"
                                                        "lp")))
                              %base-user-accounts))

                 ;; basic system packages
                 (packages (cons* git
                                  curl
                                  wget
                                  htop
                                  tree
                                  vim neovim
                                  %base-packages))

                 ;; Basic system-agnostic services
                 (services 
                   (append
                     (modify-services %base-services
                                      (delete login-service-type)
                                      (delete mingetty-service-type)
                                      (delete console-font-service-type))
                     (list
                       ;; Seat management - works identically across
                       ;; Wayland or Xorg
                       (service elogind-service-type)

                       polkit-wheel-service
                       (service polkit-service-type)
                       (service dbus-root-service-type)

                       ;; Networking
                       (service network-manager-service-type)
                       (service wpa-supplicant-service-type)
                       (service modem-manager-service-type)
                       (service bluetooth-service-type
                                (bluetooth-configuration (auto-enable? #t)))
                       (service usb-modeswitch-service-type)

                       ;; General services
                       (service avahi-service-type)
                       (service udisks-service-type)
                       (service upower-service-type)
                       (service cups-pk-helper-service-type)
                       (service geoclue-service-type)
                       fontconfig-file-system-service

                       ;; Power Management
                       (service tlp-service-type
                                (tlp-configuration
                                  (cpu-boost-on-ac? #t)
                                  (cpu-boost-on-bat? #f)
                                  (wifi-pwr-on-bat? #t)
                                  (cpu-energy-perf-policy-on-ac "balance_performance")
                                  (cpu-energy-perf-policy-on-bat "balance_power")))

                       ;; Printing/Scanning
                       (service sane-service-type)
                       (service cups-service-type
                                (cups-configuration
                                  (web-interface? #t)
                                  (extensions (list cups-filters))))

                       (service ntp-service-type)

                       (simple-service 'mtp-udev-rules udev-service-type (list libmtp))
                       (udev-rules-service 'brightnessctl-udev-rules brightnessctl)

                       (service openssh-service-type)

			       
                       ;; Garbage collection
                       (simple-service 'system-cron-jobs
                                       mcron-service-type
                                       (list #~(job "5 0 * * 0" "guix gc -d 2m -F 10G"))))))

                 (name-service-switch %mdns-host-lookup-nss)))

(define-public (guix-home-config home-environment)
  "Wrap HOME-ENVIRONMENT as a guix-home-service-type service for franek,
so `guix system reconfigure' provisions Home too."
  (service guix-home-service-type
           `(("franek" ,home-environment))))
