(custom-set-faces `(mode-line ((t (:height 110 :box (:line-width 4 :color ,(face-background 'mode-line)))))))
(custom-set-faces `(mode-line-inactive ((t (:height 110 :box (:line-width 4 :color ,(face-background 'mode-line-inactive)))))))

(defface egoge-display-time
   '((((type x w32 mac))
      (:foreground "#fff" :inherit bold))
     (((type tty))
      (:foreground "blue")))
   "Face used to display the time in the mode line.")

(setq display-time-string-forms
       '((propertize (concat " " 24-hours ":" minutes " ")
                     'face 'egoge-display-time)))

(display-time-mode 1)

;; write a function to do the spacing
(defun simple-mode-line-render (left right)
  "Return a string of `window-width' length containing LEFT, and RIGHT
 aligned respectively."
  (let* ((available-width (- (window-width) (length left) -10)))
    (format (format " %%s %%%ds " available-width) left right)))


;; use the function in conjunction with :eval and format-mode-line in your mode-line-format
(setq-default mode-line-format
     (list
      '((:eval (simple-mode-line-render
                ;; left
                (concat
                 (if (buffer-modified-p) "  [+] " "  ")
                 (format-mode-line "%b")
                 (format-mode-line " (%m)")
                 )
                ;; right
                (format-mode-line ""))))
     'global-mode-string))
