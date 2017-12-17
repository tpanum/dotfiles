(setq
 ;; Use ivy
 ;; mu4e-completing-read-function 'ivy-completing-read

 ;; General settings
 mu4e-maildir "~/.mail"
 mu4e-update-interval 60 ;; seconds

 ;; Behavior
 mu4e-compose-dont-reply-to-self t)

;; (define-key mu4e-headers-mode-map (kbd "<SPC>") nil)
(setq mu4e-headers-fields
      '( (:human-date       . 12)
         (:from-or-to . 22)
         (:subject    . nil)))

(setq mu4e-update-interval 5)
(setq mu4e-attachment-dir "/tmp/")

;; show email adresses
(setq mu4e-view-show-addresses t)

(setq mu4e-contexts
 `( ,(make-mu4e-context
     :name "AAU"
     :match-func (lambda (msg) (when msg
       (string-prefix-p "/Exchange" (mu4e-message-field msg :maildir))))
     :vars '(
       (mu4e-trash-folder . "/Exchange/Deleted Items")
       (mu4e-refile-folder . exchange-mu4e-refile-folder)
       ))
    ))

(general-emacs-define-key mu4e-headers-mode-map
 "j" 'next-line
 "k" 'previous-line
 )

(general-emacs-define-key mu4e-view-mode-map
 "RET" 'kill-buffer-and-window
)
