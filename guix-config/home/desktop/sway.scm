(define-module (guix-config home desktop sway)
               #:use-module (gnu services)
               #:use-module (gnu)
               #:use-module (gnu home services)
               #:use-module (gnu home services desktop)
               #:use-module (gnu home services shells)
               #:use-module (guix gexp)
               #:export (sway-home-packages
                          sway-home-services))

(use-package-modules fonts freedesktop gnuzilla image qt
                     terminals wm xdisorg)

(define sway-home-packages
  (list sway
        swaylock
        swayidle
        swaybg
        waybar
        mako
        wofi
        wl-clipboard
        cliphist
        grim
        grimshot
        slurp
        alacritty
        icecat
        qtwayland
        font-jetbrains-mono))

(define sway-home-services
  (list
    ;; User D-Bus
    (service home-dbus-service-type)

    ;; Wayland/Sway env
    (simple-service 'sway-env-vars-service
                    home-environment-variables-service-type
                    '(("XDG_CURRENT_DESKTOP" . "sway")
                      ("XDG_SESSION_DESKTOP" . "sway")
                      ("XDG_SESSION_TYPE" . "wayland")
                      ("MOZ_ENABLE_WAYLAND" . "1")
                      ("SDL_VIDEODRIVER" . "wayland")
                      ("QT_QPA_PLATFORM" . "wayland")
                      ("_JAVA_AWT_WM_NONREPARENTING" . "1")))

    ;; Auto-start Sway only on tty1 after login
    (simple-service 'sway-bash-autostart
                    home-bash-service-type
                    (home-bash-extension
                      (bash-profile
                        (list (plain-file "sway-autostart"
                                          "if [ -z \"$WAYLAND_DISPLAY\" ] && [ \"$XDG_VTNR\" = \"1\" ]; then\n  exec sway\nfi\n")))))))
