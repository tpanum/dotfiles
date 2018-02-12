;; Stolen from JEG2

;; Idea from Ryan Davis:
;; http://blog.zenspider.com/blog/2013/06/my-emacs-setup-osx.html

;; load OS specific settings
(tpanum/load-init-file (concat "tpanum/system/" (replace-regexp-in-string "/" "-" (symbol-name  system-type))) t)

;; load system specific settings
;; fx. osx (remember to set proper system name in System Preferences > Sharing > Computer Name)
(tpanum/load-init-file (concat "tpanum/system/" 
                             (car (split-string (system-name) "\\."))) t)

;; load minimal early system settings
(tpanum/load-init-file "tpanum/system/minimal.el")

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)
