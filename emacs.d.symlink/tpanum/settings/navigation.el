(ido-mode                      1)
(setq ido-everywhere           t)
(setq ido-enable-flex-matching t)

(global-set-key (kbd "M-x") 'smex)

(global-evil-leader-mode)

(evil-mode 1)

(evil-leader/set-leader "<SPC>")

(evil-leader/set-key
  "e" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer
  "pi" 'package-install
  "g" 'keyboard-quit
  "x" 'save-buffers-kill-terminal
  )
