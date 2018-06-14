(setq
 erc-server-reconnect-attempts t
 ;; erc-server-auto-reconnect nil
 erc-fill-static-center 18
 erc-fill-function 'erc-fill-static
 erc-hide-list '("JOIN" "PART" "QUIT")
 erc-input-line-position -1
 erc-prompt  (lambda () (concat (buffer-name) " > "))
 )

;; replace erc's built in notify function
(defun erc-notifications-notify (nick msg)
  (dbus-ignore-errors
    (setq erc-notifications-last-notification
          (notifications-notify :bus erc-notifications-bus
                                :title (xml-escape-string (concat " " nick))
                                :body (xml-escape-string msg)
                                :replaces-id erc-notifications-last-notification
                                :timeout 0
                                :app-icon erc-notifications-icon))))

(eval-after-load 'erc '(erc-notifications-mode t))

