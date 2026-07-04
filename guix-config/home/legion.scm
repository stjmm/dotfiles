(define-module (guix-config home legion)
               #:use-module (gnu home)
               #:use-module (guix-config home common)
               #:use-module (guix-config home desktop sway)
               #:use-module (guix-config home features audio)
               #:use-module (guix-config home features video)
               #:use-module (guix-config home features development)
               #:export (legion-home-environment))

(define-public legion-home-environment
               (home-environment
                 (packages
                   (append common-home-packages
                           sway-home-packages
                           audio-home-packages
                           video-home-packages
                           development-home-packages))
                 (services
                   (append common-home-services
                           sway-home-services
                           audio-home-services
                           video-home-services
                           development-home-services))))

legion-home-environment
