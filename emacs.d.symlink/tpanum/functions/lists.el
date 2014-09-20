;;;###autoload
(defun tpanum/flatten (x)
  "Flatten a list."
  (cond ((null x) nil)
        ((listp x) (append (tpanum/flatten (car x)) (tpanum/flatten (cdr x))))
        (t (list x))))
