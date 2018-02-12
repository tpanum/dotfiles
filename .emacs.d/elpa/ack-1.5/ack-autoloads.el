;;; ack-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "ack" "ack.el" (23134 24592 493530 107000))
;;; Generated autoloads from ack.el

(autoload 'ack "ack" "\
Run ack using COMMAND-ARGS and collect output in a buffer.
When called interactively, the value of DIRECTORY is provided by
`ack-default-directory-function'.

The following keys are available while reading from the
minibuffer:

\\{ack-minibuffer-local-map}

\(fn COMMAND-ARGS &optional DIRECTORY)" t nil)

;;;***

;;;### (autoloads nil "pcmpl-ack" "pcmpl-ack.el" (23134 24592 498530
;;;;;;  131000))
;;; Generated autoloads from pcmpl-ack.el

(autoload 'pcomplete/ack "pcmpl-ack" "\
Completion for the `ack' command.
Start an argument with '-' to complete short options and '--' for
long options.

\(fn)" nil nil)

(defalias 'pcomplete/ack-grep 'pcomplete/ack)

(autoload 'pcomplete/ag "pcmpl-ack" "\
Completion for the `ag' command.

\(fn)" nil nil)

;;;***

;;;### (autoloads nil nil ("ack-pkg.el") (23134 24592 507530 173000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; ack-autoloads.el ends here
