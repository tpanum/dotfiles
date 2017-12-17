;; Stolen from jeg2

;; Idea from Ryan Davis:
;; http://blog.zenspider.com/blog/2013/06/my-emacs-setup-packages.html

(require 'package)

(dolist (repo '(("elpa"      . "http://tromey.com/elpa/")
                ("marmalade" . "http://marmalade-repo.org/packages/")
                ("melpa"     . "http://melpa.org/packages/")))
  (add-to-list 'package-archives repo))

(defun tpanum/package-refresh-and-install (name)
  "Ensure we have a fresh package list, then install."
  (package-refresh-contents)
  (package-install name))

(defun tpanum/package-install-unless-installed (name)
  "Install a package by name unless it is already installed."
  (or (package-installed-p name) (tpanum/package-refresh-and-install name)))

(defun tpanum/package-version-for (package)
  "Get the version of a loaded package."
  (package-desc-version (car (cdr (assoc package package-alist)))))

(defun tpanum/package-delete-by-name (package)
  "Remove a package by name."
  (package-delete (car (cdr (assoc package package-alist)))))

(defun tpanum/package-delete-unless-listed (packages)
  "Remove packages not explicitly declared."
  (let ((packages-and-dependencies (tpanum/packages-requirements packages)))
    (dolist (package (mapcar 'car package-alist))
      (unless (memq package packages-and-dependencies)
        (tpanum/package-delete-by-name package)))))

(defun tpanum/packages-requirements (packages)
  "List of dependencies for packages."
  (delete-dups (apply 'append (mapcar 'tpanum/package-requirements packages))))

(defun tpanum/package-requirements (package)
  "List of recursive dependencies for a package."
  (let ((package-info (car (cdr (assoc package package-alist)))))
     (cond ((null package-info) (list package))
           (t
            (tpanum/flatten
             (cons package
                   (mapcar 'tpanum/package-requirements
                           (mapcar 'car (package-desc-reqs package-info)))))))))

(defun tpanum/package-install-and-remove-to-match-list (&rest packages)
  "Sync packages so the installed list matches the passed list."
  (package-initialize)
  (condition-case nil ;; added to handle no-network situations
      (mapc 'tpanum/package-install-unless-installed packages)
    (error (message "Couldn't install package. No network connection?")))
  (tpanum/package-delete-unless-listed packages))

(tpanum/package-install-and-remove-to-match-list
 'ace-jump-mode
 'ack
 'aggressive-indent
 'auctex
 'company
 'counsel
 'dockerfile-mode
 'dracula-theme
 'evil
 'evil-nerd-commenter
 'feature-mode
 'fill-column-indicator
 'flycheck
 'flymake-cursor
 'general
 'gh
 'go-mode
 'js2-mode
 'less-css-mode
 'magit
 'markdown-mode
 'material-theme
 'mu4e-alert
 'nix-mode
 'paredit
 'protobuf-mode
 'rainbow-mode
 'smartparens
 'swiper
 'tagedit
 'toml-mode
 'vue-mode
 'yaml-mode
 'yasnippet
 )

(defvar user-vendor-directory (file-name-sans-extension
               (expand-file-name "vendor" user-emacs-directory)))

(defun tpanum/load-local-package (package)
  "This loads a vender package"
  (let ((path (file-name-sans-extension
               (expand-file-name package user-vendor-directory))))
    (add-to-list 'load-path path)))
