(define-module (guix-config systems desktop sway)
               #:use-module (gnu)
               #:use-module (gnu system)
               #:use-module (gnu services)
               #:export (sway-system-packages
                          sway-system-services
                          operating-system-with-sway))

(use-service-modules base desktop xorg)
(use-package-modules freedesktop wm xorg)

(define-public sway-system-packages
               (list
                 ;; XWayland support
                 xorg-server-xwayland

                 ;; Portal support for screen sharing, screenshots etc.
                 xdg-desktop-portal
                 xdg-desktop-portal-wlr))

(define-public sway-system-services
               (list
                 (service greetd-service-type
                          (greetd-configuration
                            (greeter-supplementary-groups (list "video" "input"))
                            (terminals
                              (list (greetd-terminal-configuration
                                      (terminal-vt "1")
                                      (terminal-switch #t))
                                    (greetd-terminal-configuration
                                      (terminal-vt "2"))
                                    (greetd-terminal-configuration
                                      (terminal-vt "3"))))))

                 ;; Register swaylock with PAM/privilege handling so it can authenticate
                 (service screen-locker-service-type
                          (screen-locker-configuration
                            (name "swaylock")
                            (program (file-append swaylock "/bin/swaylock"))
                            (using-pam? #t)
                            (using-setuid? #t)))

                 (service x11-socket-directory-service-type)))

(define-public (operating-system-with-sway os)
               "Return OS with Sway-specific system packages and services added."
               (operating-system
                 (inherit os)
                 (packages
                   (append (operating-system-packages os)
                           sway-system-packages))
                 (services
                   (append
                     (modify-services (operating-system-user-services os)
                                      ;; greetd replaces the default login/mingetty services.  Removing
                                      ;; mingetty also requires removing console-font services that depend on
                                      ;; the old TTY providers.
                                      (delete login-service-type)
                                      (delete mingetty-service-type)
                                      (delete console-font-service-type))
                     sway-system-services))))
