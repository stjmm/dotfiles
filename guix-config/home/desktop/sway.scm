(define-module (guix-config home desktop sway)
               #:use-module (gnu services)
               #:use-module (gnu home services)
               #:use-module (gnu home services shells)
               #:use-module (gnu packages wm)
               #:use-module (gnu packages freedesktop)
               #:use-module (gnu packages xdisorg)
               #:use-module (gnu packages terminals)
               #:use-module (gnu packages fonts)
               #:use-module (gnu packages image)
               #:use-module (guix gexp)
               #:export (sway-home-packages
                          sway-home-services))

(define sway-home-packages
  (list sway swaylock swayidle swaybg 
        waybar mako wl-clipboard grim slurp
        font-jetbrains-mono))

(define sway-home-services
  (list
   ;; Wayland/sway env vars — wrong under any other WM, hence
   ;; kept out of common.scm.
   (simple-service 'sway-env-vars-service
                   home-environment-variables-service-type
                   '(("XDG_CURRENT_DESKTOP" . "sway")
                     ("XDG_SESSION_TYPE" . "wayland")
                     ("MOZ_ENABLE_WAYLAND" . "1")
                     ("SDL_VIDEODRIVER" . "wayland")
                     ("QT_QPA_PLATFORM" . "wayland")
                     ("_JAVA_AWT_WM_NONREPARENTING" . "1")))

   ;; Extend the bash service defined in common.scm with sway's
   ;; autostart-on-tty1 logic, instead of putting WM-specific
   ;; behavior in common.scm itself.
   (simple-service 'sway-bash-autostart
                   home-bash-service-type
                   (home-bash-extension
                    (bash-profile
                     (list (plain-file "sway-autostart"
                       (string-append
                        "if [ -z \"$WAYLAND_DISPLAY\" ] && [ \"$XDG_VTNR\" = \"1\" ]; then\n"
                        "  exec sway\n"
                        "fi\n"))))))))
