;; (setq-default notmuch-command (executable-find "notmuch"))
;Setup Names and Directories
(setq user-mail-address "tkp@es.aau.dk"
      user-full-name "Thomas Kobber Panum")

; stores postponed messages to the specified directory
(setq message-directory "~/.mail/aau/Drafts") ;

;set sent mail directory
(setq notmuch-fcc-dirs "\"aau/Sent Items/\" -unread -inbox +sent")

;Settings for main screen
(setq notmuch-hello-hide-tags (quote ("killed")))

;Setup User-Agent header
(setq mail-user-agent 'message-user-agent)

(setq message-kill-buffer-on-exit t) ; kill buffer after sending mail)
(setq mail-specify-envelope-from t) ; Settings to work with msmtp

(setq send-mail-function (quote sendmail-send-it))
(setq sendmail-program (executable-find "msmtp")
  mail-specify-envelope-from t
  ;; needed for debians message.el cf. README.Debian.gz
  message-sendmail-f-is-evil nil
  mail-envelope-from 'header
  message-sendmail-envelope-from 'header)

(setq message-sendmail-extra-arguments nil)

;; show newest first
(setq notmuch-search-oldest-first nil)

(defun tpanum/notmuch-inbox ()
  (interactive)
  (notmuch-tree "tag:inbox"))

(general-define-key :keymaps 'notmuch-tree-mode-map
                    :states '(normal)
                    "j" 'next-line
                    "k" 'previous-line
                    "RET" 'notmuch-tree-show-message-out
                    )

(general-define-key :keymaps 'notmuch-show-mode-map
                    :states '(normal)
                    "j" 'next-line
                    "k" 'previous-line
                    )



;; (general-emacs-define-key mu4e-view-mode-map
;;  "RET" 'kill-buffer-and-window
;; )
