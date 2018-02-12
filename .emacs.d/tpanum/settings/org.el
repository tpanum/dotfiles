(general-define-key :keymaps 'org-mode-map
                    :states '(normal)
                    "C-c" 'org-latex-export-to-pdf
                    "RET" 'org-open-at-point)

(general-define-key :keymaps 'doc-view-mode-map
                     :states '(emacs)
                     "<escape>" 'kill-buffer-and-window)

(require 'org-ref)
(setq
 org-latex-logfiles-extensions (quote ("lof" "lot" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl"))
 org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f")
 org-ref-default-bibliography '("~/research/bibliography.bib")
 org-ref-pdf-directory "~/research/papers/"
 )

