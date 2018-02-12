(defun tpanum/load-settings ()
  "Loads all Lisp files in the settings subdirectory of the init directory."
  (dolist (file (directory-files (concat user-emacs-directory "tpanum/settings")
                                 nil
                                 "\\.el$"))
    (tpanum/load-init-file (concat "tpanum/settings/" file))))

(tpanum/load-settings)
