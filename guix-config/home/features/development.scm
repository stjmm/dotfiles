(define-module (guix-config home features development)
               #:use-module (gnu services)
               #:use-module (gnu)
               #:use-module (gnu home services shells)
               #:use-module (guix gexp)
               #:export (development-home-packages
                          development-home-services))

(use-package-modules assembly autotools base build-tools cmake
                     gdb guile llvm pkg-config python-xyz valgrind
                     virtualization chez commencement flex shellutils
                     tree-sitter linux valgrind mtools rust golang
                     embedded)

(define development-home-packages
  (list gcc-toolchain
        clang-toolchain

        ;;Build tools
        gnu-make
        cmake
        ninja
        meson
        pkgconf
        bear
        
        ;; Autotools
        autoconf
        automake
        libtool

        ;; Debugging
        gdb
        valgrind
        strace

        ;; OS dev
        qemu
        nasm
        mtools

        ;; Embedded
        (make-arm-none-eabi-toolchain-12.3.rel1)
        (make-gdb-arm-none-eabi)
        openocd

        ;; Other langs
        rust
        rust-analyzer
        go

        ;; Guix
        guile-3.0

	    ;; Editor tooling
        tree-sitter

        direnv
        tree-sitter-cli
	))

(define development-home-services
  (list
    (simple-service 'direnv-bash-hook
                    home-bash-service-type
                    (home-bash-extension
                      (bashrc
                        (list (plain-file "direnv-bash-hook"
                                          "eval \"$(direnv hook bash)\"\n")))))))
