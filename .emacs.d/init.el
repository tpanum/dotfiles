;;; Package --- Summary

;;; Commentary:
;; Emacs init file responsible for either loading a pre-compiled configuration file
;; or tangling and loading a literate org configuration file.

;;; Code:

;; Don't attempt to find/apply special file handlers to files loaded during startup.
(let ((file-name-handler-alist nil))
  ;; If config is pre-compiled, then load that
  (if (file-exists-p (expand-file-name "emacs.elc" user-emacs-directory))
      (load-file (expand-file-name "emacs.elc" user-emacs-directory))
    ;; Otherwise use org-babel to tangle and load the configuration
    (require 'org)
    (org-babel-load-file (expand-file-name "emacs.org" user-emacs-directory))))

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#2b303b" "#BF616A" "#A3BE8C" "#ECBE7B" "#8FA1B3" "#c678dd" "#46D9FF" "#c0c5ce"])
 '(custom-safe-themes
   (quote
    ("2d1fe7c9007a5b76cea4395b0fc664d0c1cfd34bb4f1860300347cdad67fb2f9" "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "732b807b0543855541743429c9979ebfb363e27ec91e82f463c91e68c772f6e3" "cdb3e7a8864cede434b168c9a060bf853eeb5b3f9f758310d2a2e23be41a24ae" "728eda145ad16686d4bbb8e50d540563573592013b10c3e2defc493f390f7d83" "f951343d4bbe5a90dba0f058de8317ca58a6822faa65d8463b0e751a07ec887c" "b462d00de785490a0b6861807a360f5c1e05b48a159a99786145de7e3cce3afe" "f589e634c9ff738341823a5a58fc200341b440611aaa8e0189df85b44533692b" "f30aded97e67a487d30f38a1ac48eddb49fdb06ac01ebeaff39439997cbdd869" "d6f04b6c269500d8a38f3fabadc1caa3c8fdf46e7e63ee15605af75a09d5441e" default)))
 '(dashboard-items (quote ((agenda . 10))) t)
 '(erc-autojoin-timing (quote ident))
 '(erc-fill-function (quote erc-fill-static))
 '(erc-fill-static-center 14)
 '(erc-hide-list (quote ("JOIN" "PART" "QUIT")))
 '(erc-lurker-hide-list (quote ("JOIN" "PART" "QUIT")))
 '(erc-lurker-threshold-time 43200)
 '(erc-notifications-icon "~/.icons/hashtag-solid.svg")
 '(erc-prompt "   >")
 '(erc-prompt-for-nickserv-password nil)
 '(erc-server-reconnect-attempts 20)
 '(erc-server-reconnect-timeout 5)
 '(erc-track-exclude-types
   (quote
    ("JOIN" "MODE" "NICK" "PART" "QUIT" "324" "329" "332" "333" "353" "477")))
 '(fci-rule-color "#65737E")
 '(hl-sexp-background-color "#1c1f26")
 '(initial-buffer-choice
   (lambda nil
     (setq initial-buffer-choice nil)
     (get-buffer "*dashboard*")))
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#D08770"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#A3BE8C"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#4f5b66"))
 '(objed-cursor-color "#BF616A")
 '(package-selected-packages
   (quote
    (dired ob yaml-mode worf with-simulated-input which-key weechat web-mode vue-mode use-package toc-org synosaurus smex smartparens slack rainbow-mode rainbow-delimiters python-black protobuf-mode password-store parinfer ox-spectacle ox-hugo org-ref org-re-reveal org-plus-contrib ob-ipython nlinum nix-mode moody magit lsp-ui langtool kaolin-themes json-mode go-eldoc git-gutter-fringe general flyspell-correct-ivy flycheck-golangci-lint evil-surround evil-snipe evil-nerd-commenter evil-lion evil-indent-plus evil-escape evil-easymotion erc-image erc-hl-nicks doom-themes doom-modeline dockerfile-mode dashboard counsel company-lsp company-go company-box company-auctex circe-notifications cdlatex auctex-latexmk aggressive-indent ace-window)))
 '(vc-annotate-background "#2b303b")
 '(vc-annotate-color-map
   (list
    (cons 20 "#A3BE8C")
    (cons 40 "#bbbe86")
    (cons 60 "#d3be80")
    (cons 80 "#ECBE7B")
    (cons 100 "#e2ab77")
    (cons 120 "#d99973")
    (cons 140 "#D08770")
    (cons 160 "#cc8294")
    (cons 180 "#c97db8")
    (cons 200 "#c678dd")
    (cons 220 "#c370b6")
    (cons 240 "#c16890")
    (cons 260 "#BF616A")
    (cons 280 "#a35f69")
    (cons 300 "#875e68")
    (cons 320 "#6b5c67")
    (cons 340 "#65737E")
    (cons 360 "#65737E")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
