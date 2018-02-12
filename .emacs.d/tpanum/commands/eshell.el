;;;###autoload
(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-width) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-horizontally)
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)
    (concat "*eshell: " name "*")))

;;;###autoload
(defun eshell/x()
  "Exits current eshell"
  (interactive)
  (insert "exit")
  (eshell-send-input)
  (delete-window))

;;;###autoload
(defun kill-buffer-and-its-windows (buffer)
  "Kill BUFFER and delete its windows.  Default is `current-buffer'.
BUFFER may be either a buffer or its name (a string)."
  (interactive (list (read-buffer "Kill buffer: " (current-buffer) 'existing)))
  (setq buffer  (get-buffer buffer))
  (if (buffer-live-p buffer)            ; Kill live buffer only.
      (let ((wins  (get-buffer-window-list buffer nil t))) ; On all frames.
        (when (and (buffer-modified-p buffer)
                   (fboundp '1on1-flash-ding-minibuffer-frame))
          (1on1-flash-ding-minibuffer-frame t)) ; Defined in `oneonone.el'.
        (when (kill-buffer buffer)      ; Only delete windows if buffer killed.
          (dolist (win  wins)           ; (User might keep buffer if modified.)
            (when (window-live-p win)
              ;; Ignore error, in particular,
              ;; "Attempt to delete the sole visible or iconified frame".
              (condition-case nil (delete-window win) (error nil))))))
    (when (interactive-p)
      (error "Cannot kill buffer.  Not a live buffer: `%s'" buffer))))

;;;###autoload
(defun eshell-toggle()
  "Toggles an eshell window"
  (interactive)
  (if (boundp 'eshell-open) 
      (progn (kill-buffer-and-its-windows eshell-open) (makunbound 'eshell-open))
    (setq eshell-open (eshell-here))))

(defun eshell-insert ()
  (interactive)
  "Inserts correctly"
  (evil-goto-line) (evil-append-line 1)
  )
