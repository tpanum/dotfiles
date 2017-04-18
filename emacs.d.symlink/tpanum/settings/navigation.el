(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(global-evil-leader-mode)

(evil-mode 1)
(ivy-mode 1)

(evil-leader/set-leader "<SPC>")

(evil-leader/set-key
  "aa" 'apropos
  "0" 'delete-window
  "1" 'delete-other-windows
  "2" 'split-window-below
  "3" 'split-window-right
  "b" 'ivy-switch-buffer
  "c" 'ace-jump-char-mode
  "e" 'find-file
  "g" 'keyboard-quit
  "hf" 'describe-function
  "hk" 'describe-key
  "hr" 'info-emacs-manual
  "hv" 'describe-variable
  "irc" 'tpanum/erc-connect
  "k" 'kill-buffer
  "l" 'ace-jump-line-mode
  "o" 'other-window
  "pi" 'package-install
  "s" 'eshell-here
  "w" 'ace-jump-word-mode
  "xc" 'save-buffers-kill-terminal
  "xe" 'eval-last-sexp
  )

;; togge shell using home button
(global-set-key (kbd "<home>") 'eshell-toggle)


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

(defmacro minibuffer-quit-and-run (&rest body)
  "Quit the minibuffer and run BODY afterwards."
  `(progn
     (run-at-time nil nil
                  (lambda ()
                    (put 'quit 'error-message "Quit")
                    ,@body))
     (minibuffer-keyboard-quit)))

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(define-key ivy-mode-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

;; ivy settings
(define-key ivy-minibuffer-map (kbd "M-j") 'ivy-next-line)
(define-key ivy-minibuffer-map (kbd "M-k") 'ivy-previous-line)
(define-key ivy-minibuffer-map (kbd "<RET>") 'ivy-alt-done)

(defun tpanum/ivy-rg-search ()
  (interactive)
  (minibuffer-quit-and-run
   (let ((selected-candidate (concat (file-name-as-directory ivy--directory) (ivy-state-current ivy-last))))
  (if (file-directory-p selected-candidate) (counsel-rg "" selected-candidate) (counsel-rg "" ivy--directory)))))


(define-key ivy-minibuffer-map (kbd "$") 'tpanum/ivy-rg-search)

;; size of ivy buffer
(setq ivy-height 30)
