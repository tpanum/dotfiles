;;; loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "commands/alignment" "commands/alignment.el"
;;;;;;  (23074 62854 134652 914000))
;;; Generated autoloads from commands/alignment.el

(autoload 'tpanum/align= "commands/alignment" "\
Aligns equal signs in the region or buffer.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/comments" "commands/comments.el"
;;;;;;  (23074 62854 134652 914000))
;;; Generated autoloads from commands/comments.el

(autoload 'tpanum/insert-header-comment "commands/comments" "\
Inserts a header wrapped in the appropriate comment characters.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/erb" "commands/erb.el" (23074 62854
;;;;;;  135652 919000))
;;; Generated autoloads from commands/erb.el

(autoload 'tpanum/erb-insert-or-toggle-erb-tag "commands/erb" "\
Insert an ERb tag if the point isn't currently in one, or toggle the type.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/eshell" "commands/eshell.el" (23074
;;;;;;  62854 135652 919000))
;;; Generated autoloads from commands/eshell.el

(autoload 'eshell-here "commands/eshell" "\
Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier.

\(fn)" t nil)

(autoload 'eshell/x "commands/eshell" "\
Exits current eshell

\(fn)" t nil)

(autoload 'kill-buffer-and-its-windows "commands/eshell" "\
Kill BUFFER and delete its windows.  Default is `current-buffer'.
BUFFER may be either a buffer or its name (a string).

\(fn BUFFER)" t nil)

(autoload 'eshell-toggle "commands/eshell" "\
Toggles an eshell window

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/html" "commands/html.el" (23074 62854
;;;;;;  135652 919000))
;;; Generated autoloads from commands/html.el

(autoload 'tpanum/html-insert-open-and-close-tag "commands/html" "\
Generates an open and close HTML snippet using the current word.

\(fn)" t nil)

(autoload 'tpanum/htmlify-buffer "commands/html" "\
Converts the entire buffer in syntax highlighted HTML.

\(fn)" t nil)

(autoload 'tpanum/htmlify-buffer-light "commands/html" "\
Converts the entire buffer in syntax highlighted HTML using a light theme.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/irc" "commands/irc.el" (23075 2760
;;;;;;  859454 383000))
;;; Generated autoloads from commands/irc.el

(autoload 'tpanum/erc-connect "commands/irc" "\
Prompts for a channel, then connects to IRC.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/lines" "commands/lines.el" (23074
;;;;;;  62854 135652 919000))
;;; Generated autoloads from commands/lines.el

(autoload 'tpanum/newline-below "commands/lines" "\
Insert a new line below the current line and indent it.

\(fn SKIP-EOL)" t nil)

(autoload 'tpanum/newline-above "commands/lines" "\
Insert a new line above the current line and indent it.

\(fn)" t nil)

(autoload 'tpanum/newline-between "commands/lines" "\
Splits content before and after the point to insert new content between.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/markdown" "commands/markdown.el"
;;;;;;  (23074 62854 135652 919000))
;;; Generated autoloads from commands/markdown.el

(autoload 'tpanum/markdown-yank-as-pre "commands/markdown" "\
Yank in some text as preformatted.

\(fn)" t nil)

(autoload 'tpanum/markdown-preview "commands/markdown" "\
Preview the current buffer in Marked.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/org" "commands/org.el" (23074 62854
;;;;;;  135652 919000))
;;; Generated autoloads from commands/org.el

(autoload 'tpanum/org-new-heading-below "commands/org" "\
Creates a new heading below the current one.

\(fn)" t nil)

(autoload 'tpanum/org-new-heading-above "commands/org" "\
Creates a new heading above the current one.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/rails" "commands/rails.el" (23074
;;;;;;  62854 135652 919000))
;;; Generated autoloads from commands/rails.el

(autoload 'tpanum/rails-console "commands/rails" "\
Invoke inf-ruby with Rails environment loaded.

\(fn)" t nil)

(autoload 'tpanum/rails-dbconsole "commands/rails" "\
Open a SQL shell using the settings from config/database.yml.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/ruby" "commands/ruby.el" (23074 62854
;;;;;;  135652 919000))
;;; Generated autoloads from commands/ruby.el

(autoload 'tpanum/toggle-ruby-test "commands/ruby" "\
Toggler between positive and negative assertions.

\(fn)" t nil)

(autoload 'tpanum/toggle-ruby-block-type "commands/ruby" "\
Toggle between brace and do/end block types.

\(fn)" t nil)

(autoload 'tpanum/toggle-ruby-regex-type "commands/ruby" "\
Toggle between standard and choose-your-own-quotes regex types.

\(fn)" t nil)

(autoload 'tpanum/toggle-ruby-string-and-symbol "commands/ruby" "\
Toggle between strings and symbols.

\(fn)" t nil)

(autoload 'tpanum/toggle-ruby-hash-type "commands/ruby" "\
Toggle between symbol key hash types.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/shell" "commands/shell.el" (23074
;;;;;;  62854 135652 919000))
;;; Generated autoloads from commands/shell.el

(autoload 'tpanum/open-shell-in-ansi-term "commands/shell" "\
Opens a new shell inside an ansi-terminal.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/spelling" "commands/spelling.el"
;;;;;;  (23074 62854 135652 919000))
;;; Generated autoloads from commands/spelling.el

(autoload 'tpanum/toggle-program-spelling "commands/spelling" "\
Toggle the programmer's spelling mode on and off.

\(fn)" t nil)

(autoload 'tpanum/toggle-spelling "commands/spelling" "\
Toggle the spelling mode on and off.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/strings" "commands/strings.el" (23074
;;;;;;  62854 135652 919000))
;;; Generated autoloads from commands/strings.el

(autoload 'tpanum/toggle-string-type "commands/strings" "\
Toggle between double, single, and choose-your-own-quotes string types.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/whitespace" "commands/whitespace.el"
;;;;;;  (23074 62854 135652 919000))
;;; Generated autoloads from commands/whitespace.el

(autoload 'tpanum/trim-backwards "commands/whitespace" "\
Removes all whitespace behind the point.

\(fn)" t nil)

(autoload 'tpanum/trim-forwards "commands/whitespace" "\
Removes all whitespace in front of the point.

\(fn)" t nil)

(autoload 'tpanum/trim-backwards-and-forwards "commands/whitespace" "\
Removes all whitespace behind and in front of the point.

\(fn)" t nil)

(autoload 'tpanum/fix-all-whitespace "commands/whitespace" "\
Replace tabs and cleans up junk whitespace.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/wrap" "commands/wrap.el" (23074 62854
;;;;;;  136652 925000))
;;; Generated autoloads from commands/wrap.el

(autoload 'tpanum/toggle-wrap "commands/wrap" "\
Toggle the wrap guide and soft wrapping on and off.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "functions/files" "functions/files.el" (23074
;;;;;;  62854 136652 925000))
;;; Generated autoloads from functions/files.el

(autoload 'tpanum/read-file-to-string "functions/files" "\
Reads the contents of path into a string.

\(fn PATH)" nil nil)

(autoload 'tpanum/find-subpath-in-path "functions/files" "\
Walks up the passed path hunting for subpath at each level.

\(fn SUBPATH PATH)" nil nil)

(autoload 'tpanum/find-in-path "functions/files" "\
Walks up the current path hunting for subpath at each level.

\(fn SUBPATH)" nil nil)

;;;***

;;;### (autoloads nil "functions/jekyll" "functions/jekyll.el" (23074
;;;;;;  62854 136652 925000))
;;; Generated autoloads from functions/jekyll.el

(autoload 'tpanum/create-jekyll-post "functions/jekyll" "\
Creates a new buffer and file for a blog post

\(fn TITLE)" t nil)

;;;***

;;;### (autoloads nil "functions/lists" "functions/lists.el" (23074
;;;;;;  62854 136652 925000))
;;; Generated autoloads from functions/lists.el

(autoload 'tpanum/flatten "functions/lists" "\
Flatten a list.

\(fn X)" nil nil)

;;;***

;;;### (autoloads nil "functions/pbcopy" "functions/pbcopy.el" (23074
;;;;;;  62854 136652 925000))
;;; Generated autoloads from functions/pbcopy.el

(autoload 'turn-on-pbcopy "functions/pbcopy" "\


\(fn)" t nil)

(autoload 'turn-off-pbcopy "functions/pbcopy" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil "functions/rails" "functions/rails.el" (23074
;;;;;;  62854 136652 925000))
;;; Generated autoloads from functions/rails.el

(autoload 'jeg2/read-rails-database-config "functions/rails" "\
Loads the database config as:  adapter database username [password].

\(fn PATH)" nil nil)

;;;***

;;;### (autoloads nil "functions/regexen" "functions/regexen.el"
;;;;;;  (23074 62854 136652 925000))
;;; Generated autoloads from functions/regexen.el

(autoload 'jeg2/regex-replace "functions/regexen" "\
Replace a regular expression in the passed string, if it occurs.

\(fn STR REGEX REPLACEMENT &optional FIXEDCASE LITERAL)" nil nil)

(autoload 'jeg2/regex-replace-all "functions/regexen" "\
Replace a regular expression everywhere it occurs in the passed string.

\(fn STR REGEX REPLACEMENT &optional FIXEDCASE LITERAL)" nil nil)

;;;***

;;;### (autoloads nil "functions/strings" "functions/strings.el"
;;;;;;  (23074 62854 136652 925000))
;;; Generated autoloads from functions/strings.el

(autoload 'jeg2/string-trim "functions/strings" "\
Trim whitespace from both ends of the passed string.

\(fn STR)" nil nil)

(autoload 'jeg2/camelize "functions/strings" "\
Forces a string into CamelCase.

\(fn STR)" nil nil)

;;;***

;;;### (autoloads nil nil ("commands/mail.el" "functions/fullscreen.el"
;;;;;;  "functions/org-gantt.el") (23152 30044 617119 986000))

;;;***

(provide 'loaddefs)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; loaddefs.el ends here
