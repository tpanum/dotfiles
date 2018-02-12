;; small hack to make emacs behave like linux for inserting utf8 chars
(defun add-space-as-minibuffer-complete ()
  (local-set-key (kbd "<SPC>") 'ivy-alt-done))

(defun tpanum/insert-char ()
  (interactive)
  (add-hook 'minibuffer-setup-hook 'add-space-as-minibuffer-complete)
  (add-hook 'minibuffer-exit-hook (lambda ()
                                    (remove-hook 'minibuffer-setup-hook 'add-space-as-minibuffer-complete)))
  (call-interactively 'insert-char))

(global-set-key (kbd "C-S-u") 'tpanum/insert-char)
