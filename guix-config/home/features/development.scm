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
		     tree-sitter)

(define development-home-packages
  (list gcc-toolchain
        gnu-make
        pkgconf
        cmake
        bear
        autoconf

        clang-toolchain
        gdb
        valgrind

        qemu
        nasm

        guile-3.0

	;; Language server stuff
	tree-sitter
	))

(define development-home-services
  (list
    (simple-service 'direnv-bash-hook
                    home-bash-service-type
                    (home-bash-extension
                      (bashrc
                        (list (plain-file "direnv-bash-hook"
                                          "eval \"$(direnv hook bash)\"\n")))))))
