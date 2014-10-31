(ido-mode                      1)
(setq ido-everywhere           t)
(setq ido-enable-flex-matching t)
(ido-vertical-mode 1)

(global-set-key (kbd "M-x") 'smex)
(global-evil-leader-mode)

(evil-mode 1)

(evil-leader/set-leader "<SPC>")

(evil-leader/set-key
  "c" 'ace-jump-char-mode
  "l" 'ace-jump-line-mode
  "w" 'ace-jump-word-mode
  "e" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer
  "pi" 'package-install
  "g" 'keyboard-quit
  "xc" 'save-buffers-kill-terminal
  "1" 'delete-other-windows
  "o" 'other-window
  "irc" 'tpanum/erc-connect
  )

(toggle-uniquify-buffer-names)

;; esc quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)
