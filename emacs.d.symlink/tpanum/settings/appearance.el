;; change default font
(set-face-attribute 'default nil :family "Fira Code" :height 130)
(set-face-attribute 'mode-line nil :height 135)

;; additional line spacing
(add-text-properties (point-min) (point-max)
                     '(line-spacing 0.25 line-height 1.25))

;; hide the menu bar
(menu-bar-mode 0)

;; disable the splash screen
(setq inhibit-splash-screen t)

;; smyx theme with cusomizations
(load-theme 'material  t)

;; scrollbar
(toggle-scroll-bar -1)

;; remove toolbar
(tool-bar-mode -1)

;; remove menu bar
(menu-bar-mode -1)

;; http://bzg.fr/emacs-strip-tease.html

;; Prevent the cursor from blinking
(blink-cursor-mode 0)
;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; Don't let Emacs hurt your ears
(setq visible-bell t)
(setq inhibit-startup-echo-area-message "panum")

;; This is bound to f11 in Emacs 24.4
(toggle-frame-fullscreen)

;; fix background color of mode-line
;;(set-face-background 'mode-line "#4F4F4F")
