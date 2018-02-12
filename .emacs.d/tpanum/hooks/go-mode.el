(smartparens-mode)
(flycheck-mode)

(define-key evil-normal-state-local-map (kbd "<tab>") 'godef-jump)
(add-hook 'before-save-hook #'gofmt-before-save)
