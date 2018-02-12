;;;###autoload
(defun tpanum/erc-connect ()
  "Prompts for a channel, then connects to IRC."
  (interactive)
  (erc :server    "irc.freenode.net"
       :port      6667
       :nick      "tpanum"
       :password  "8363lucky"
       :full-name "Thomas Kobber Panum"))
