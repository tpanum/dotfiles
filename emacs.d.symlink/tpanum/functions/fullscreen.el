(defun toggle-fullscreen ()
"Toggle full screen"
(interactive)
(set-frame-parameter
nil 'fullscreen
(when (not (frame-parameter nil 'fullscreen)) 'fullboth)))
