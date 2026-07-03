(define-module (guix-config home legion)
               #:use-module (gnu home)
               #:use-module (guix-config home common)
               #:use-module (guix-config home desktop sway)
               #:export (legion-home-environment))

(define-public legion-home-environment
  (home-environment
   (packages (append common-home-packages sway-home-packages))
   (services (append common-home-services sway-home-services))))

legion-home-environment
