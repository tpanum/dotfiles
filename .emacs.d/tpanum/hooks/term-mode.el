;;; Switch from prev to next term buffer
(add-to-list 'term-bind-key-alist '("M-p" . multi-term-prev))
(add-to-list 'term-bind-key-alist '("M-n" . multi-term-next))

;;; Fix Yanking
(define-key term-raw-map (kbd "C-y") 'term-paste)
