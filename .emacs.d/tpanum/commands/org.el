;;;###autoload
(defun tpanum/org-new-heading-below ()
  "Creates a new heading below the current one."
  (interactive)
  (unless (eolp)
    (end-of-line))
  (org-insert-heading-respect-content t))

;;;###autoload
(defun tpanum/org-new-heading-above ()
  "Creates a new heading above the current one."
  (interactive)
  (unless (bolp)
    (beginning-of-line))
  (org-insert-heading-respect-content t))


;;;###autoload
(defun tpanum/org-agenda ()
  "Opens org agenda with personal directory"
  (interactive)
  (setq org-agenda-files (directory-files "~/org" t "^[a-zA-Z0-9_-.]+\\.org"))
  (org-agenda-list))

;;;###autoload
(defun tpanum/todo-work ()
  "Opens work todo"
  (interactive)
  (find-file "~/org/work.org"))


;;;###autoload
(defun tpanum/todo-research ()
  "Opens research todo"
  (interactive)
  (find-file "~/org/research.org"))

;;;###autoload
(defun tpanum/todo-personal ()
  "Opens personal todo"
  (interactive)
  (find-file "~/org/personal.org"))



