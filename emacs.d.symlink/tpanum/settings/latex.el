(setq TeX-save-query nil) ;; autosave before compiling
(setq TeX-PDF-mode t) ;; compile to pdf

(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook (lambda()
                             (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
                             (setq TeX-command-default "XeLaTeX")
                             (setq TeX-save-query nil)
                             (setq TeX-show-compilation nil)
                             ))
