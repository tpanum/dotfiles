;; tpanum's Emacs configuration

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
