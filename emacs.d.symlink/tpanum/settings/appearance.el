;; hide the menu bar
(menu-bar-mode 0)

;; disable the splash screen
(setq inhibit-splash-screen t)

;; load theme
(setq calendar-location-name "Aalborg, Denmark")
(setq calendar-latitude 57.02)
(setq calendar-longitude -9.54)

(load-theme 'flatland t)

;; remove scrollbar
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
