(define-module (guix-config home features video)
               #:use-module (gnu)
               #:export (video-home-packages
                          video-home-services))

(use-package-modules video)

(define video-home-packages
  (list ffmpeg
        mpv
	vlc
        v4l-utils))

(define video-home-services
  '())
