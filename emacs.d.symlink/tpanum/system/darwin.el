;; Fix S-<up> in xterm.  Why: 
;; http://lists.gnu.org/archive/html/help-gnu-emacs/2011-05/msg00211.html
(if (equal "xterm" (tty-type))
    (define-key input-decode-map "\e[1;2A" [S-up]))
(defadvice terminal-init-xterm (after select-shift-up activate)
  (define-key input-decode-map "\e[1;2A" [S-up]))

;; Integrate with Mac OS X's pasteboard.  Inspried by:
;; https://gist.github.com/the-kenny/267162
(defvar tpanum-pbpaste-executable (executable-find "pbpaste")
  "The pbpaste executable")

(defvar tpanum-pbcopy-executable (executable-find "pbcopy")
  "The pbcopy executable")

(defun tpanum/pbpaste ()
  (shell-command-to-string tpanum-pbpaste-executable))

(defun tpanum/pbcopy (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" tpanum-pbcopy-executable)))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function   'tpanum/pbcopy)
(setq interprogram-paste-function 'tpanum/pbpaste)

;; cmd as meta, and make option actually work
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

;; remove bell sound when scrolling
(setq ring-bell-function #'ignore)

;; allow for unicode keybindings
(prefer-coding-system 'utf-8-unix)
