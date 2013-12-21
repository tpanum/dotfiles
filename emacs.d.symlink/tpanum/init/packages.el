;; Stolen from JEG2

;; Idea from Ryan Davis:
;; http://blog.zenspider.com/blog/2013/06/my-emacs-setup-packages.html

(require 'package)

(dolist (repo '(("elpa"      . "http://tromey.com/elpa/")
                ("marmalade" . "http://marmalade-repo.org/packages/")
                ("melpa"     . "http://melpa.milkbox.net/packages/")))
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
  (package-desc-vers (cdr (assoc package package-alist))))

(defun tpanum/package-delete-by-name (package)
  "Remove a package by name."
  (package-delete (symbol-name package)
                  (package-version-join (tpanum/package-version-for package))))

(defun tpanum/package-delete-unless-listed (packages)
  "Remove packages not explicitly declared."
  (dolist (package (mapcar 'car package-alist))
    (unless (memq package packages) (tpanum/package-delete-by-name package))))

(defun tpanum/package-install-and-remove-to-match-list (&rest packages)
  "Sync packages so the installed list matches the passed list."
  (package-initialize)
  (condition-case nil ;; added to handle no-network situations
      (mapc 'tpanum/package-install-unless-installed packages)
    (error (message "Couldn't install package. No network connection?")))
  (tpanum/package-delete-unless-listed packages))

(tpanum/package-install-and-remove-to-match-list
 'color-theme
 'color-theme-sanityinc-tomorrow
 'fill-column-indicator
 'smartparens
 'ace-jump-mode
 'paredit
 'popup
 'dash
 'auto-complete
 'erlang
 'flymake-cursor
 'ido-ubiquitious
 'hlinum
 'haml-mode
 'sass-mode
 'scss-mode
 'auctex
 )
