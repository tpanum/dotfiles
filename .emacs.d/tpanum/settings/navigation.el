(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(ivy-mode 1)
(evil-mode 1)

;; nerd commenter
(evilnc-default-hotkeys)

(general-evil-setup t)
(general-define-key
 :states '(normal visual emacs)
 :prefix "SPC"
 "aa" 'apropos

 "w" 'other-window
 "Wod" 'delete-other-windows
 "Wsv" 'split-window-below
 "Wsh" 'split-window-right

 "q" 'kill-this-buffer
 "Q" 'quit-window
 "f" 'find-file

 "hf" 'describe-function
 "hk" 'describe-key
 "hm" 'describe-mode
 "hr" 'info-emacs-manual
 "hv" 'describe-variable

 "irc" 'tpanum/erc-connect

 "gs" 'magit-status

 "b" 'ivy-switch-buffer
 "Bk" 'kill-buffer
 "Btk" 'kill-this-buffer

 "mo" 'tpanum/notmuch-inbox

 "pi" 'package-install
 "xc" 'save-buffers-kill-terminal
 "xe" 'eval-last-sexp
 )

(setq which-key-idle-delay 0.4)
(which-key-mode)

;; togge shell using home button
(global-set-key (kbd "<home>") 'eshell-toggle)

;; Change duplicate buffer names from name<2> to dir/name
(setq uniquify-buffer-name-style 'forward)

(global-set-key (kbd "S-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-<up>") 'shrink-window)
(global-set-key (kbd "S-<down>") 'enlarge-window)
(global-set-key (kbd "M-=") 'text-scale-increase)
(global-set-key (kbd "M--") 'text-scale-decrease)

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

(define-key ivy-mode-map [escape] 'minibuffer-keyboard-quit)

;; ivy settings
(define-key ivy-minibuffer-map (kbd "s-j") 'ivy-next-line)
(define-key ivy-minibuffer-map (kbd "s-k") 'ivy-previous-line)
(define-key ivy-minibuffer-map (kbd "<RET>") 'ivy-alt-done)

(defmacro minibuffer-quit-and-run (&rest body)
  "Quit the minibuffer and run BODY afterwards."
  `(progn
     (run-at-time nil nil
                  (lambda ()
                    (put 'quit 'error-message "Quit")
                    ,@body))
     (minibuffer-keyboard-quit)))

(defun tpanum/ivy-rg-search ()
  (interactive)
  (minibuffer-quit-and-run
   (let ((selected-candidate (concat (file-name-as-directory ivy--directory) (ivy-state-current ivy-last))))
     (if (file-directory-p selected-candidate) (counsel-rg "" selected-candidate) (counsel-rg "" ivy--directory)))))


(define-key ivy-minibuffer-map (kbd "C-s") 'tpanum/ivy-rg-search)

;; size of ivy buffer
(setq ivy-height 30)
