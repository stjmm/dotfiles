(define-module (guix-config home common)
               #:use-module (gnu services)
               #:use-module (gnu) #:use-module (gnu home services)
               #:use-module (gnu home services shells)
               #:use-module (gnu home services ssh)
               #:export (common-home-packages
                          common-home-services))

(use-package-modules admin compression file ncurses rust-apps tmux
                     version-control vim pdf task-management
                     package-management)

(define common-home-packages
  (list git
        vim
        neovim
        tmux
        ripgrep
        file
        zip
        unzip
        tree
        htop
        btop
        stow
        fastfetch
        ncurses
        sioyek
        timewarrior))

(define common-home-services
  (list
    (simple-service 'profile-env-vars-service
                    home-environment-variables-service-type
                    '(("LC_COLLATE" . "C")
                      ("EDITOR" . "nvim")
                      ("VISUAL" . "nvim")
                      ("PATH" . "$HOME/.local/bin:$PATH")))

    ;; This uses Guix defaults but sources your own bash config
    ;; in ~/.config/bash/bashrc
    (service home-bash-service-type
             (home-bash-configuration
               (guix-defaults? #t)
               (bashrc
                 (list
                   (plain-file
                     "custom-bashrc"
                     "
    if [[ -r \"$HOME/.config/bash/bashrc\" ]]; then
        source \"$HOME/.config/bash/bashrc\"
    fi
    ")))))

    (service home-ssh-agent-service-type)))
