(define-module (guix-config home common)
               #:use-module (gnu home)
               #:use-module (gnu services)
               #:use-module (gnu home services)
               #:use-module (gnu home services shells)
               #:use-module (gnu home services ssh)
               #:use-module (gnu home services gnupg)
               #:use-module (gnu packages)
               #:use-module (gnu packages version-control)
               #:use-module (gnu packages vim)
               #:use-module (gnu packages tmux)
               #:use-module (gnu packages rust-apps)
               #:use-module (gnu packages file)
               #:use-module (gnu packages compression)
               #:use-module (gnu packages admin)
               #:use-module (gnu packages ncurses)
               #:use-module (gnu packages gnuzilla)
               #:use-module (gnu packages terminals)
               #:export (common-home-packages
                          common-home-services))

(define common-home-packages
  (list git
        vim
        tmux
        ripgrep
        file
        zip
        unzip
        tree
        fastfetch
        ncurses

        icecat

        alacritty))

(define common-home-services
  (list
    (simple-service 'profile-env-vars-service
                    home-environment-variables-service-type
                    '(("LC_COLLATE" . "C")
                     ("EDITOR" . "vim")
                     ("VISUAL" . "vim")
                     ("XDG_CONFIG_HOME" . "$HOME/.config")
                     ("XDG_DATA_HOME" . "$HOME/.local/share")
                     ("XDG_CACHE_HOME" . "$HOME/.cache")
                     ("PATH" . "$HOME/.local/bin:$PATH")))

    (service home-bash-service-type
             (home-bash-configuration
               (guix-defaults? #t)))

    (service home-ssh-agent-service-type)))
