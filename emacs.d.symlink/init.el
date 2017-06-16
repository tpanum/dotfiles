;; Tpanum's Emacs configuration


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defun tpanum/load-init-file (path &optional noerror)
  "This loads a file from inside the the .emacs.d directory"
  (let ((file (file-name-sans-extension
               (expand-file-name path user-emacs-directory))))
    (load file noerror)))

;; load configuration settings by type
(tpanum/load-init-file "tpanum/init/freshen.el")
(tpanum/load-init-file "tpanum/init/system.el")
(tpanum/load-init-file "tpanum/init/autoloads.el")
(tpanum/load-init-file "tpanum/init/packages.el")
(tpanum/load-init-file "tpanum/init/compile.el")
(tpanum/load-init-file "tpanum/init/autohooks.el")
(tpanum/load-init-file "tpanum/init/settings.el")

;; Launch todo
(find-file "~/todo.org")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("ed8cf6d52a2ba9ed7a29a8aac81d83c362a9b62f48b558932a77130163fe9972" default)))
 '(package-selected-packages
   (quote
    (gotham-theme dockerfile-mode neotree yasnippet yaml-mode vue-mode toml-mode tagedit smartparens rainbow-mode protobuf-mode paredit material-theme markdown-mode magit less-css-mode js2-mode go-mode gh flymake-cursor flycheck fill-column-indicator feature-mode evil-leader ein counsel company auctex aggressive-indent ack ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
