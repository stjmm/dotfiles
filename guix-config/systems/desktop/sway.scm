(define-module (guix-config systems desktop sway)
               #:use-module (gnu)
               #:use-module (gnu services)
               #:use-module (gnu services xorg)
               #:use-module (gnu services desktop)
               #:use-module (gnu packages wm)
               #:use-module (gnu packages freedesktop)
               #:export (sway-system-packages
                          sway-system-services))

(define sway-system-packages
  (list xorg-server-xwayland
        xdg-desktop-portal
        xdg-desktop-portal-wlr))

(define sway-system-services
  (list
    (service greetd-service-type
             (greetd-configuration
               (greeter-supplementary-groups (list "video" "input"))
               (terminals
                 (list (greetd-terminal-configuration
                         (terminal-vt "1")
                         (terminal-switch #t))
                       (greetd-terminal-configuration (terminal-vt "2"))
                       (greetd-terminal-configuration (terminal-vt "3"))))))

    (service screen-locker-service-type
             (screen-locker-configuration
               (name "swaylock")
               (program (file-append swaylock "/bin/swaylock"))
               (using-pam? #t)
               (using-setuid? #t)))

    (service x11-socket-directory-service-type)))
