(general-define-key :keymaps 'org-mode-map
                    :states '(normal)
                    "C-c C-c" 'org-latex-export-to-pdf
                    "t" 'org-todo
                    "s" 'org-schedule
                    "RET" 'org-open-at-point)

(general-define-key :keymaps 'doc-view-mode-map
                     :states '(emacs)
                     "<escape>" 'kill-buffer-and-window)

(setq org-log-done t)

(require 'org-ref)

(setq
 org-latex-logfiles-extensions (quote ("lof" "lot" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl"))
 org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f")
 org-ref-default-bibliography '("~/research/bibliography.bib")
 org-ref-pdf-directory "~/research/papers/"
 org-ref-bibliography-notes "~/research/papers/papers.org"
 bibtex-completion-bibliography '("~/research/bibliography.bib")
 bibtex-completion-library-path "~/research/papers"
 bibtex-completion-notes-path "~/research/papers/papers.org"
 org-ref-completion-library 'org-ref-ivy-cite)


(general-define-key :keymaps 'bibtex-completion-notes-mode-map
                    :states '(normal)
                    "q" 'bibtex-completion-exit-notes-buffer)


(setq bibtex-completion-notes-template-one-file "
* ${title} (${year}) [${author-or-editor}]
  :PROPERTIES:
  :Custom_ID: ${=key=}
  :END:

")
