;;;###autoload
(defun tpanum/erc-connect ()
  "Prompts for a channel, then connects to IRC."
  (interactive)
  (erc :server    "irc.freenode.net"
       :port      6667
       :nick      "tpanum"
       :password  "8363lucky"
       :full-name "Thomas Kobber Panum"))

;;; Automatically scroll to bottom
(defcustom erc-input-line-position nil
  "Specify where to position the input line when using `erc-scroll-to-bottom'.
This should be an integer specifying the line of the buffer on which
the input line should stay.  A value of \"-1\" would keep the input
line positioned on the last line in the buffer.  This is passed as an
argument to `recenter'."
  :group 'erc-display
  :type '(choice integer (const nil)))

(define-erc-module scrolltobottom nil
  "This mode causes the prompt to stay at the end of the window."
  ((add-hook 'erc-mode-hook 'erc-add-scroll-to-bottom)
   (dolist (buffer (erc-buffer-list))
     (with-current-buffer buffer
       (erc-add-scroll-to-bottom))))
  ((remove-hook 'erc-mode-hook 'erc-add-scroll-to-bottom)
   (dolist (buffer (erc-buffer-list))
     (with-current-buffer buffer
(remove-hook 'post-command-hook 'erc-scroll-to-bottom t)))))

(defun erc-add-scroll-to-bottom ()
  "A hook function for `erc-mode-hook' to recenter output at bottom of window.
If you find that ERC hangs when using this function, try customizing
the value of `erc-input-line-position'.
This works whenever scrolling happens, so it's added to
`window-scroll-functions' rather than `erc-insert-post-hook'."
  (add-hook 'post-command-hook 'erc-scroll-to-bottom nil t))

(defun erc-scroll-to-bottom ()
  "Recenter WINDOW so that `point' is on the last line.
This is added to `window-scroll-functions' by `erc-add-scroll-to-bottom'.
You can control which line is recentered to by customizing the
variable `erc-input-line-position'."
      ;; Temporarily bind resize-mini-windows to nil so that users who have it
      ;; set to a non-nil value will not suffer from premature minibuffer
      ;; shrinkage due to the below recenter call.  I have no idea why this
      ;; works, but it solves the problem, and has no negative side effects.
      ;; (Fran Litterio, 2003/01/07)
  (let ((resize-mini-windows nil))
    (save-restriction
      (widen)
      (when (and erc-insert-marker
		 ;; we're editing a line. Scroll.
		 (> (point) erc-insert-marker))
	(save-excursion
	  (goto-char (point-max))
(recenter (or erc-input-line-position -1)))))))
