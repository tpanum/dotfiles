(require 'flymake)
(defun flymake-erlang-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name temp-file
		(file-name-directory buffer-file-name))))
    (list "~/.emacs.d/tpanum/functions/flymake/erlang" (list local-file))))

(add-to-list 'flymake-allowed-file-name-masks '("\\.erl\\'" flymake-erlang-init))

(flymake-mode 1)
