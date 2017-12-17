;; add mu4e to load path
(eval-and-compile (let ((mu4epath
                          (concat
                           (file-name-directory
                            (file-truename
                             (executable-find "mu")))
                           "../share/emacs/site-lisp/mu4e")))
                     (when (and
                            (string-prefix-p "/nix/store/" mu4epath)
                            (file-directory-p mu4epath))
                       (message "Adding %s to load-path" (file-truename mu4epath))
                       (add-to-list 'load-path (file-truename mu4epath)))))

(require 'mu4e)
