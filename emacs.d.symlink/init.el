;; Tpanum's Emacs configuration

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("573e46dadf8c2623256a164831cfe9e42d5c700baed1f8ecd1de0675072e23c2" "fc2782b33667eb932e4ffe9dac475f898bf7c656f8ba60e2276704fabb7fa63b" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
