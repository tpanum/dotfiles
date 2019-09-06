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
 '(package-selected-packages
   (quote
    (yasnippet yaml-mode which-key weechat web-mode use-package toc-org synosaurus smex smartparens slack rainbow-mode rainbow-delimiters protobuf-mode password-store parinfer ox-spectacle ox-reveal org-ref org-plus-contrib nlinum nix-mode moody markdown-mode magit langtool json-mode go-eldoc git-gutter-fringe general flyspell-correct-ivy flycheck-golangci-lint evil-surround evil-snipe evil-nerd-commenter evil-lion evil-indent-plus evil-escape evil-easymotion erc-image erc-hl-nicks doom-themes doom-modeline dockerfile-mode dashboard counsel-projectile company-go company-box circe-notifications auctex aggressive-indent ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
