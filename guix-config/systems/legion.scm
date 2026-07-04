(define-module (guix-config systems legion)
               #:use-module (gnu)
               #:use-module (gnu system)
               #:use-module (guix-config systems base)
               #:use-module (guix-config systems desktop sway)
               #:use-module (guix-config home legion))

(define legion-base-operating-system
  (operating-system
    (inherit base-operating-system)
    (host-name "legion")

    ;; Host-specific storage belongs here, not in base.scm.
    (swap-devices
      (list (swap-space
              (target (uuid "0973e257-0737-4416-81dc-f924ce6e21dd")))))

    (file-systems
      (cons* (file-system
               (device (uuid "c05138f5-132c-46d3-867c-cc8d98f63e42"))
               (mount-point "/")
               (type "ext4"))
             (file-system
               (device (uuid "B622-48F8" 'fat))
               (mount-point "/boot/efi")
               (type "vfat"))
             %base-file-systems))

    ;; Guix Home is attached at the system level so one system reconfigure
    ;; updates both the OS and the user environment.
    (services
      (append (operating-system-user-services base-operating-system)
              (list (guix-home-config legion-home-environment))))))

;; Apply the Sway wrapper. Swap this for another WM wrapper later.
(operating-system-with-sway legion-base-operating-system)
