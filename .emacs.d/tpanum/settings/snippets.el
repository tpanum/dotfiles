(setq yas-snippet-dirs
      (list (expand-file-name "tpanum/snippets" user-emacs-directory)
            ))

(yas-global-mode)

(setq yas-prompt-functions '(yas/ido-prompt))
