(general-define-key :keymaps 'org-mode-map
                     :states '(normal)
                     "RET" 'org-open-at-point)

(general-define-key :keymaps 'doc-view-mode-map
                     :states '(emacs)
                     "<escape>" 'kill-buffer-and-window)
