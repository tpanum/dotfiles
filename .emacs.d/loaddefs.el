;;; loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "tpanum/commands/alignment" "tpanum/commands/alignment.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/commands/alignment.el

(autoload 'tpanum/align= "tpanum/commands/alignment" "\
Aligns equal signs in the region or buffer.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "tpanum/commands/comments" "tpanum/commands/comments.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/commands/comments.el

(autoload 'tpanum/insert-header-comment "tpanum/commands/comments" "\
Inserts a header wrapped in the appropriate comment characters.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "tpanum/commands/erb" "tpanum/commands/erb.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/commands/erb.el

(autoload 'tpanum/erb-insert-or-toggle-erb-tag "tpanum/commands/erb" "\
Insert an ERb tag if the point isn't currently in one, or toggle the type.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "tpanum/commands/eshell" "tpanum/commands/eshell.el"
;;;;;;  (22057 19500 0 0))
;;; Generated autoloads from tpanum/commands/eshell.el

(autoload 'eshell-here "tpanum/commands/eshell" "\
Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier.

\(fn)" t nil)

(autoload 'eshell/x "tpanum/commands/eshell" "\
Exits current eshell

\(fn)" t nil)

(autoload 'kill-buffer-and-its-windows "tpanum/commands/eshell" "\
Kill BUFFER and delete its windows.  Default is `current-buffer'.
BUFFER may be either a buffer or its name (a string).

\(fn BUFFER)" t nil)

(autoload 'eshell-toggle "tpanum/commands/eshell" "\
Toggles an eshell window

\(fn)" t nil)

;;;***

;;;### (autoloads nil "tpanum/commands/html" "tpanum/commands/html.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/commands/html.el

(autoload 'tpanum/html-insert-open-and-close-tag "tpanum/commands/html" "\
Generates an open and close HTML snippet using the current word.

\(fn)" t nil)

(autoload 'tpanum/htmlify-buffer "tpanum/commands/html" "\
Converts the entire buffer in syntax highlighted HTML.

\(fn)" t nil)

(autoload 'tpanum/htmlify-buffer-light "tpanum/commands/html" "\
Converts the entire buffer in syntax highlighted HTML using a light theme.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "tpanum/commands/irc" "tpanum/commands/irc.el"
;;;;;;  (21600 45680 0 0))
;;; Generated autoloads from tpanum/commands/irc.el

(autoload 'tpanum/erc-connect "tpanum/commands/irc" "\
Prompts for a channel, then connects to IRC.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "tpanum/commands/lines" "tpanum/commands/lines.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/commands/lines.el

(autoload 'tpanum/newline-below "tpanum/commands/lines" "\
Insert a new line below the current line and indent it.

\(fn SKIP-EOL)" t nil)

(autoload 'tpanum/newline-above "tpanum/commands/lines" "\
Insert a new line above the current line and indent it.

\(fn)" t nil)

(autoload 'tpanum/newline-between "tpanum/commands/lines" "\
Splits content before and after the point to insert new content between.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "tpanum/commands/markdown" "tpanum/commands/markdown.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/commands/markdown.el

(autoload 'tpanum/markdown-yank-as-pre "tpanum/commands/markdown" "\
Yank in some text as preformatted.

\(fn)" t nil)

(autoload 'tpanum/markdown-preview "tpanum/commands/markdown" "\
Preview the current buffer in Marked.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "tpanum/commands/org" "tpanum/commands/org.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/commands/org.el

(autoload 'tpanum/org-new-heading-below "tpanum/commands/org" "\
Creates a new heading below the current one.

\(fn)" t nil)

(autoload 'tpanum/org-new-heading-above "tpanum/commands/org" "\
Creates a new heading above the current one.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "tpanum/commands/rails" "tpanum/commands/rails.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/commands/rails.el

(autoload 'tpanum/rails-console "tpanum/commands/rails" "\
Invoke inf-ruby with Rails environment loaded.

\(fn)" t nil)

(autoload 'tpanum/rails-dbconsole "tpanum/commands/rails" "\
Open a SQL shell using the settings from config/database.yml.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "tpanum/commands/ruby" "tpanum/commands/ruby.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/commands/ruby.el

(autoload 'tpanum/toggle-ruby-test "tpanum/commands/ruby" "\
Toggler between positive and negative assertions.

\(fn)" t nil)

(autoload 'tpanum/toggle-ruby-block-type "tpanum/commands/ruby" "\
Toggle between brace and do/end block types.

\(fn)" t nil)

(autoload 'tpanum/toggle-ruby-regex-type "tpanum/commands/ruby" "\
Toggle between standard and choose-your-own-quotes regex types.

\(fn)" t nil)

(autoload 'tpanum/toggle-ruby-string-and-symbol "tpanum/commands/ruby" "\
Toggle between strings and symbols.

\(fn)" t nil)

(autoload 'tpanum/toggle-ruby-hash-type "tpanum/commands/ruby" "\
Toggle between symbol key hash types.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "tpanum/commands/shell" "tpanum/commands/shell.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/commands/shell.el

(autoload 'tpanum/open-shell-in-ansi-term "tpanum/commands/shell" "\
Opens a new shell inside an ansi-terminal.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "tpanum/commands/spelling" "tpanum/commands/spelling.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/commands/spelling.el

(autoload 'tpanum/toggle-program-spelling "tpanum/commands/spelling" "\
Toggle the programmer's spelling mode on and off.

\(fn)" t nil)

(autoload 'tpanum/toggle-spelling "tpanum/commands/spelling" "\
Toggle the spelling mode on and off.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "tpanum/commands/strings" "tpanum/commands/strings.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/commands/strings.el

(autoload 'tpanum/toggle-string-type "tpanum/commands/strings" "\
Toggle between double, single, and choose-your-own-quotes string types.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "tpanum/commands/whitespace" "tpanum/commands/whitespace.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/commands/whitespace.el

(autoload 'tpanum/trim-backwards "tpanum/commands/whitespace" "\
Removes all whitespace behind the point.

\(fn)" t nil)

(autoload 'tpanum/trim-forwards "tpanum/commands/whitespace" "\
Removes all whitespace in front of the point.

\(fn)" t nil)

(autoload 'tpanum/trim-backwards-and-forwards "tpanum/commands/whitespace" "\
Removes all whitespace behind and in front of the point.

\(fn)" t nil)

(autoload 'tpanum/fix-all-whitespace "tpanum/commands/whitespace" "\
Replace tabs and cleans up junk whitespace.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "tpanum/commands/wrap" "tpanum/commands/wrap.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/commands/wrap.el

(autoload 'tpanum/toggle-wrap "tpanum/commands/wrap" "\
Toggle the wrap guide and soft wrapping on and off.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "tpanum/functions/files" "tpanum/functions/files.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/functions/files.el

(autoload 'tpanum/read-file-to-string "tpanum/functions/files" "\
Reads the contents of path into a string.

\(fn PATH)" nil nil)

(autoload 'tpanum/find-subpath-in-path "tpanum/functions/files" "\
Walks up the passed path hunting for subpath at each level.

\(fn SUBPATH PATH)" nil nil)

(autoload 'tpanum/find-in-path "tpanum/functions/files" "\
Walks up the current path hunting for subpath at each level.

\(fn SUBPATH)" nil nil)

;;;***

;;;### (autoloads nil "tpanum/functions/jekyll" "tpanum/functions/jekyll.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/functions/jekyll.el

(autoload 'tpanum/create-jekyll-post "tpanum/functions/jekyll" "\
Creates a new buffer and file for a blog post

\(fn TITLE)" t nil)

;;;***

;;;### (autoloads nil "tpanum/functions/lists" "tpanum/functions/lists.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/functions/lists.el

(autoload 'tpanum/flatten "tpanum/functions/lists" "\
Flatten a list.

\(fn X)" nil nil)

;;;***

;;;### (autoloads nil "tpanum/functions/pbcopy" "tpanum/functions/pbcopy.el"
;;;;;;  (21994 65008 0 0))
;;; Generated autoloads from tpanum/functions/pbcopy.el

(autoload 'turn-on-pbcopy "tpanum/functions/pbcopy" "\


\(fn)" t nil)

(autoload 'turn-off-pbcopy "tpanum/functions/pbcopy" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil "tpanum/functions/rails" "tpanum/functions/rails.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/functions/rails.el

(autoload 'jeg2/read-rails-database-config "tpanum/functions/rails" "\
Loads the database config as:  adapter database username [password].

\(fn PATH)" nil nil)

;;;***

;;;### (autoloads nil "tpanum/functions/regexen" "tpanum/functions/regexen.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/functions/regexen.el

(autoload 'jeg2/regex-replace "tpanum/functions/regexen" "\
Replace a regular expression in the passed string, if it occurs.

\(fn STR REGEX REPLACEMENT &optional FIXEDCASE LITERAL)" nil nil)

(autoload 'jeg2/regex-replace-all "tpanum/functions/regexen" "\
Replace a regular expression everywhere it occurs in the passed string.

\(fn STR REGEX REPLACEMENT &optional FIXEDCASE LITERAL)" nil nil)

;;;***

;;;### (autoloads nil "tpanum/functions/strings" "tpanum/functions/strings.el"
;;;;;;  (21600 45640 0 0))
;;; Generated autoloads from tpanum/functions/strings.el

(autoload 'jeg2/string-trim "tpanum/functions/strings" "\
Trim whitespace from both ends of the passed string.

\(fn STR)" nil nil)

(autoload 'jeg2/camelize "tpanum/functions/strings" "\
Forces a string into CamelCase.

\(fn STR)" nil nil)

;;;***

;;;### (autoloads nil nil ("tpanum/functions/fullscreen.el") (22058
;;;;;;  859 713296 0))

;;;***

(provide 'loaddefs)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; loaddefs.el ends here
