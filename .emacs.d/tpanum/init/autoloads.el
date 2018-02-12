;; Stolen from JEG2

;; Idea from Ryan Davis:
;; http://blog.zenspider.com/blog/2013/06/my-emacs-setup.html

(require 'find-lisp)

(setq tpanum-autoload-file (concat user-emacs-directory "tpanum/" "loaddefs.el"))

(defun tpanum/autoload-directories (directories)
  "Regenerate the autoload definitions file if necessary and load it."
  (let ((autoload-file tpanum-autoload-file))
    (if (or (not (file-exists-p autoload-file))
            (catch 'newer
              (dolist (directory directories)
                (dolist (file (find-lisp-find-files directory "\\.el$"))
                  (if (file-newer-than-file-p file autoload-file)
                      (throw 'newer file))))))
        (let ((generated-autoload-file autoload-file)
              (subdirectories (apply
                               'nconc
                               (mapcar
                                (lambda (directory)
                                  (find-lisp-find-files-internal
                                   directory
                                   'find-lisp-file-predicate-is-directory
                                   'find-lisp-default-directory-predicate))
                                directories))))
          (apply 'update-directory-autoloads (append directories
                                                     subdirectories))))))

(defun tpanum/prepare-autoloads ()
  "Sets up and triggers autoload file."
  (tpanum/autoload-directories
   (mapcar (lambda (directory) (concat user-emacs-directory directory "/"))
           '("tpanum/functions" "tpanum/commands")))
  (add-to-list 'load-path (concat user-emacs-directory "tpanum/") t)
  (load tpanum-autoload-file))

(tpanum/prepare-autoloads)
