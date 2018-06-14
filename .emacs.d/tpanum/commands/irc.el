;;;###autoload
(defun tpanum/erc-connect ()
  "Prompts for a channel, then connects to IRC."
  (interactive)
  (erc-tls :server "znc.panum.dk"
       :port      5000
       :nick      "tpanum"
       :password "tpanum/freenode:!000lakai"
       :full-name "Thomas Kobber Panum"))
