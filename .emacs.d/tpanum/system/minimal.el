;; Idea from Ryan Davis:
;; http://blog.zenspider.com/blog/2013/06/my-emacs-setup-sanity.html

;; This file is also loaded very early in the Emacs boot sequence, so it's 
;; the right place to make changes that need to be in effect even during 
;; the boot sequence.

;; move backups into .emacs.d/backups
(setq backup-directory-alist
      (list (cons "." (expand-file-name "backups" user-emacs-directory))))

(setq initial-scratch-message nil)

;; remove load-path warning
(defun string-starts-with (string prefix)
  "Returns non-nil if string STRING starts with PREFIX, otherwise nil."
  (and (>= (length string) (length prefix))
       (string-equal (substring string 0 (length prefix)) prefix)))

(defadvice display-warning
    (around no-warn-.emacs.d-in-load-path (type message &rest unused) activate)
  "Ignore the warning about the `.emacs.d' directory being in `load-path'."
  (unless (and (eq type 'initialization)
               (string-starts-with message "Your `load-path' seems to contain\nyour `.emacs.d' directory"))
    ad-do-it))
