;; change default font
;; (set-face-attribute 'default nil :family "Source Code Pro" :height 130)
(set-frame-font "Hack-12")

;; hide the menu bar
(menu-bar-mode 0)

;; disable the splash screen
(setq inhibit-splash-screen t)

;; prefered theme of the month
(load-theme 'spacemacs-dark)
(setq evil-visual-state-cursor 'hbar
      evil-insert-state-cursor 'bar
      evil-emacs-state-cursor 'hbar)

;; scrollbar
(toggle-scroll-bar -1)

;; remove toolbar
(tool-bar-mode -1)

;; remove menu bar
(menu-bar-mode -1)

;; save window state
(desktop-save-mode 1)

;; Prevent the cursor from blinking
(blink-cursor-mode 0)
;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; Don't let Emacs hurt your ears
(setq visible-bell t)
(setq inhibit-startup-echo-area-message "panum")
