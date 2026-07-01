(define-module (based-guix systems base)
               #:use-module (gnu)
               #:use-module (nongnu packages linux)
               #:use-module (nongnu system linux-initrd)
               #:export (base-operating-system)

(define-public base-operating-system
               (operating-system
                 (host-name "base-os")
                 (timezone "Europe/Warsaw")
                 (locale "en_US.utf8")

                 ;; Use non-free Linux
                 (kernel linux)
                 (initrd microcode-linux)
                 (firmware (list linux-firmware))

                 ;; Use the UEFI variant of GRUB with the EFI System
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
                                (supplementary-groups '("wheel"
                                                        "netdev"
                                                        "audio"
                                                        "video"
                                                        "kvm"
                                                        "tty"
                                                        "input"
                                                        "lp")))
                              %base-user-accounts))

                 (packages )

                 )
               )
