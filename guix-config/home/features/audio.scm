(define-module (guix-config home features audio)
               #:use-module (gnu services)
               #:use-module (gnu)
               #:use-module (gnu home services sound)
               #:export (audio-home-packages
                          audio-home-services))

(use-package-modules linux music pulseaudio)

(define audio-home-packages
  (list alsa-utils
        pavucontrol
        pamixer
        playerctl))

(define audio-home-services
  (list
    ;; Upstream Guix Home service
    (service home-pipewire-service-type)))
