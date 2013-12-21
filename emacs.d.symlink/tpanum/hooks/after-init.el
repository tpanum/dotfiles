;; keybindings

;; Allows for for scandinavian keybindings
(defun fc-kbd (str)
(read-kbd-macro str))

(define-key global-map (fc-kbd "C-ø") 'ace-jump-mode)
