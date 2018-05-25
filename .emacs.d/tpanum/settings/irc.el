(setq
 erc-server-reconnect-attempts t
 erc-server-auto-reconnect t
 erc-fill-static-center 18
 erc-fill-function 'erc-fill-static
 erc-hide-list '("JOIN" "PART" "QUIT")
 erc-input-line-position -1
 erc-prompt  (lambda () (concat (buffer-name) " > "))
 )

(eval-after-load 'erc '(erc-nick-notify-mode t))
(eval-after-load 'erc '(erc-scrolltobottom-mode t))

