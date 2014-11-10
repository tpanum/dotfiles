(ido-mode                      1)
(setq ido-enable-flex-matching t)
(ido-vertical-mode 1)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(global-evil-leader-mode)

(evil-mode 1)

(evil-leader/set-leader "<SPC>")

(evil-leader/set-key
  "0" 'delete-window
  "1" 'delete-other-windows
  "2" 'split-window-below
  "3" 'split-window-right
  "b" 'switch-to-buffer
  "c" 'ace-jump-char-mode
  "e" 'find-file
  "g" 'keyboard-quit
  "irc" 'tpanum/erc-connect
  "k" 'kill-buffer
  "l" 'ace-jump-line-mode
  "o" 'other-window
  "pi" 'package-install
  "w" 'ace-jump-word-mode
  "xc" 'save-buffers-kill-terminal
  "xe" 'eval-last-sexp
  )

;; Change duplicate buffer names from name<2> to dir/name
(setq uniquify-buffer-name-style 'forward)

(global-set-key (kbd "S-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-<up>") 'shrink-window)
(global-set-key (kbd "S-<down>") 'enlarge-window)

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
