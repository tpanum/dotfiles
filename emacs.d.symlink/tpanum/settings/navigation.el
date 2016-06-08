(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(global-evil-leader-mode)

(evil-mode 1)
(ivy-mode 1)

(evil-leader/set-leader "<SPC>")

(evil-leader/set-key
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

;; size of ivy buffer
(setq ivy-height 30)

;; (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
;; (define-key helm-map (kbd "M-k") 'helm-previous-line)
;; (define-key helm-map (kbd "M-j") 'helm-next-line)
;; (define-key helm-map (kbd "<backspace>") 'tpanum/helm-ido-delete)
;; (define-key helm-map (kbd "<RET>") 'tpanum/helm-ido-confirm)
;; (define-key helm-map (kbd "<tab>") 'helm-maybe-exit-minibuffer)
;; (define-key helm-map (kbd ":") 'tpanum/helm-do-ag)



;; (require 'helm)
;; (require 'helm-config)

;; (defun tpanum/helm-ido-delete ()
;;   "Go up directory if pattern is empty"
;;   (interactive)
;;   (if (file-directory-p helm-pattern)
;;       (helm-find-files-up-one-level 1)
;;     (delete-backward-char 1)))

;; (defun tpanum/helm-ido-confirm ()
;;   "Confirm and open file, else if directory navigate to it"
;;   (interactive)
;;   (let ((selection (car (helm-marked-candidates))))
;;     (if (file-directory-p (if (stringp selection) (selection) (buffer-name selection)))
;; 	(helm-execute-persistent-action)
;;       (helm-maybe-exit-minibuffer)
;;       ))
;;   )

;; (defun tpanum/helm-ido-confirm ()
;;   "Confirm and open file, else if directory navigate to it"
;;   (interactive)
;;   (message (car helm-marked-candidates))
;;   )


;; (defun tpanum/helm-do-ag ()
;;   "Starts searching selected folder with ag"
;;   (interactive)
;;   (if (file-directory-p (car (helm-marked-candidates)))
;;       (let ((helm-ag-command-option "--ignore *.test -i -t") )
;;         ;; run after exit the current minibuffer operation
;;         (setq helm-last-selected-directory (concat (car (helm-marked-candidates)) "/"))
;;         (run-with-timer
;;          0 nil (lambda () (call-interactively (helm-do-ag helm-last-selected-directory))))
;;         (minibuffer-keyboard-quit)
;;         )))

;; (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
;; (define-key helm-map (kbd "M-k") 'helm-previous-line)
;; (define-key helm-map (kbd "M-j") 'helm-next-line)
;; (define-key helm-map (kbd "<backspace>") 'tpanum/helm-ido-delete)
;; (define-key helm-map (kbd "<RET>") 'tpanum/helm-ido-confirm)
;; (define-key helm-map (kbd "<tab>") 'helm-maybe-exit-minibuffer)
;; (define-key helm-map (kbd ":") 'tpanum/helm-do-ag)

;; (setq helm-split-window-in-side-p           t
;;       helm-buffers-fuzzy-matching           t
;;       helm-ff-file-name-history-use-recentf t)
