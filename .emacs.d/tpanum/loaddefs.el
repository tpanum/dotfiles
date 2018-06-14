;;; loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "../../.dotfiles/.emacs.d/tpanum/commands/irc"
;;;;;;  "commands/irc.el" "f8bd6e95b08d56e185e5f83e512bd1d5")
;;; Generated autoloads from commands/irc.el

(autoload 'tpanum/erc-connect "../../.dotfiles/.emacs.d/tpanum/commands/irc" "\
Prompts for a channel, then connects to IRC.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "../../.dotfiles/.emacs.d/tpanum/commands/lines"
;;;;;;  "commands/lines.el" "d160c24538216a7b71f416151f939b6a")
;;; Generated autoloads from commands/lines.el

(autoload 'tpanum/newline-below "../../.dotfiles/.emacs.d/tpanum/commands/lines" "\
Insert a new line below the current line and indent it.

\(fn SKIP-EOL)" t nil)

(autoload 'tpanum/newline-above "../../.dotfiles/.emacs.d/tpanum/commands/lines" "\
Insert a new line above the current line and indent it.

\(fn)" t nil)

(autoload 'tpanum/newline-between "../../.dotfiles/.emacs.d/tpanum/commands/lines" "\
Splits content before and after the point to insert new content between.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "../../.dotfiles/.emacs.d/tpanum/commands/markdown"
;;;;;;  "commands/markdown.el" "916b4f802373665171ea94491fcbaebf")
;;; Generated autoloads from commands/markdown.el

(autoload 'tpanum/markdown-yank-as-pre "../../.dotfiles/.emacs.d/tpanum/commands/markdown" "\
Yank in some text as preformatted.

\(fn)" t nil)

(autoload 'tpanum/markdown-preview "../../.dotfiles/.emacs.d/tpanum/commands/markdown" "\
Preview the current buffer in Marked.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "../../.dotfiles/.emacs.d/tpanum/commands/org"
;;;;;;  "commands/org.el" "7f9aa1404c881421314b72533b5e86a6")
;;; Generated autoloads from commands/org.el

(autoload 'tpanum/org-new-heading-below "../../.dotfiles/.emacs.d/tpanum/commands/org" "\
Creates a new heading below the current one.

\(fn)" t nil)

(autoload 'tpanum/org-new-heading-above "../../.dotfiles/.emacs.d/tpanum/commands/org" "\
Creates a new heading above the current one.

\(fn)" t nil)

(autoload 'tpanum/org-agenda "../../.dotfiles/.emacs.d/tpanum/commands/org" "\
Opens org agenda with personal directory

\(fn)" t nil)

(autoload 'tpanum/todo-work "../../.dotfiles/.emacs.d/tpanum/commands/org" "\
Opens work todo

\(fn)" t nil)

(autoload 'tpanum/todo-research "../../.dotfiles/.emacs.d/tpanum/commands/org" "\
Opens research todo

\(fn)" t nil)

(autoload 'tpanum/todo-personal "../../.dotfiles/.emacs.d/tpanum/commands/org" "\
Opens personal todo

\(fn)" t nil)

;;;***

;;;### (autoloads nil "../../.dotfiles/.emacs.d/tpanum/commands/rails"
;;;;;;  "commands/rails.el" "a9dce490750163d7b621930528b840dc")
;;; Generated autoloads from commands/rails.el

(autoload 'tpanum/rails-console "../../.dotfiles/.emacs.d/tpanum/commands/rails" "\
Invoke inf-ruby with Rails environment loaded.

\(fn)" t nil)

(autoload 'tpanum/rails-dbconsole "../../.dotfiles/.emacs.d/tpanum/commands/rails" "\
Open a SQL shell using the settings from config/database.yml.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "../../.dotfiles/.emacs.d/tpanum/commands/ruby"
;;;;;;  "commands/ruby.el" "66c4e25043fff6773386daf93d119cb1")
;;; Generated autoloads from commands/ruby.el

(autoload 'tpanum/toggle-ruby-test "../../.dotfiles/.emacs.d/tpanum/commands/ruby" "\
Toggler between positive and negative assertions.

\(fn)" t nil)

(autoload 'tpanum/toggle-ruby-block-type "../../.dotfiles/.emacs.d/tpanum/commands/ruby" "\
Toggle between brace and do/end block types.

\(fn)" t nil)

(autoload 'tpanum/toggle-ruby-regex-type "../../.dotfiles/.emacs.d/tpanum/commands/ruby" "\
Toggle between standard and choose-your-own-quotes regex types.

\(fn)" t nil)

(autoload 'tpanum/toggle-ruby-string-and-symbol "../../.dotfiles/.emacs.d/tpanum/commands/ruby" "\
Toggle between strings and symbols.

\(fn)" t nil)

(autoload 'tpanum/toggle-ruby-hash-type "../../.dotfiles/.emacs.d/tpanum/commands/ruby" "\
Toggle between symbol key hash types.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "../../.dotfiles/.emacs.d/tpanum/commands/shell"
;;;;;;  "commands/shell.el" "4f5987a0405e4815906c1cbc315b7dcd")
;;; Generated autoloads from commands/shell.el

(autoload 'tpanum/open-shell-in-ansi-term "../../.dotfiles/.emacs.d/tpanum/commands/shell" "\
Opens a new shell inside an ansi-terminal.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "../../.dotfiles/.emacs.d/tpanum/commands/spelling"
;;;;;;  "commands/spelling.el" "31edfa8121e0d2354bc1eb7ad0a6fd94")
;;; Generated autoloads from commands/spelling.el

(autoload 'tpanum/toggle-program-spelling "../../.dotfiles/.emacs.d/tpanum/commands/spelling" "\
Toggle the programmer's spelling mode on and off.

\(fn)" t nil)

(autoload 'tpanum/toggle-spelling "../../.dotfiles/.emacs.d/tpanum/commands/spelling" "\
Toggle the spelling mode on and off.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "../../.dotfiles/.emacs.d/tpanum/commands/strings"
;;;;;;  "commands/strings.el" "57bd77b3a35b55b59706f0c01d6aa816")
;;; Generated autoloads from commands/strings.el

(autoload 'tpanum/toggle-string-type "../../.dotfiles/.emacs.d/tpanum/commands/strings" "\
Toggle between double, single, and choose-your-own-quotes string types.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "../../.dotfiles/.emacs.d/tpanum/commands/whitespace"
;;;;;;  "commands/whitespace.el" "0ca599a4fcd060dfdfbd51c3d1998c83")
;;; Generated autoloads from commands/whitespace.el

(autoload 'tpanum/trim-backwards "../../.dotfiles/.emacs.d/tpanum/commands/whitespace" "\
Removes all whitespace behind the point.

\(fn)" t nil)

(autoload 'tpanum/trim-forwards "../../.dotfiles/.emacs.d/tpanum/commands/whitespace" "\
Removes all whitespace in front of the point.

\(fn)" t nil)

(autoload 'tpanum/trim-backwards-and-forwards "../../.dotfiles/.emacs.d/tpanum/commands/whitespace" "\
Removes all whitespace behind and in front of the point.

\(fn)" t nil)

(autoload 'tpanum/fix-all-whitespace "../../.dotfiles/.emacs.d/tpanum/commands/whitespace" "\
Replace tabs and cleans up junk whitespace.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "../../.dotfiles/.emacs.d/tpanum/commands/wrap"
;;;;;;  "commands/wrap.el" "99d660c51e1c6dd31f4461766bff1b5f")
;;; Generated autoloads from commands/wrap.el

(autoload 'tpanum/toggle-wrap "../../.dotfiles/.emacs.d/tpanum/commands/wrap" "\
Toggle the wrap guide and soft wrapping on and off.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "../../.dotfiles/.emacs.d/tpanum/functions/files"
;;;;;;  "functions/files.el" "efa216a18442bc41642e9a06873d8852")
;;; Generated autoloads from functions/files.el

(autoload 'tpanum/read-file-to-string "../../.dotfiles/.emacs.d/tpanum/functions/files" "\
Reads the contents of path into a string.

\(fn PATH)" nil nil)

(autoload 'tpanum/find-subpath-in-path "../../.dotfiles/.emacs.d/tpanum/functions/files" "\
Walks up the passed path hunting for subpath at each level.

\(fn SUBPATH PATH)" nil nil)

(autoload 'tpanum/find-in-path "../../.dotfiles/.emacs.d/tpanum/functions/files" "\
Walks up the current path hunting for subpath at each level.

\(fn SUBPATH)" nil nil)

;;;***

;;;### (autoloads nil "../../.dotfiles/.emacs.d/tpanum/functions/jekyll"
;;;;;;  "functions/jekyll.el" "e105114b5f462da30b9c51c413fd7a23")
;;; Generated autoloads from functions/jekyll.el

(autoload 'tpanum/create-jekyll-post "../../.dotfiles/.emacs.d/tpanum/functions/jekyll" "\
Creates a new buffer and file for a blog post

\(fn TITLE)" t nil)

;;;***

;;;### (autoloads nil "../../.dotfiles/.emacs.d/tpanum/functions/lists"
;;;;;;  "functions/lists.el" "5fcb4cb062b70793f05902071fbef703")
;;; Generated autoloads from functions/lists.el

(autoload 'tpanum/flatten "../../.dotfiles/.emacs.d/tpanum/functions/lists" "\
Flatten a list.

\(fn X)" nil nil)

;;;***

;;;### (autoloads nil "../../.dotfiles/.emacs.d/tpanum/functions/pbcopy"
;;;;;;  "functions/pbcopy.el" "817b62f4488ced1dde3d2bfa2785e6d4")
;;; Generated autoloads from functions/pbcopy.el

(autoload 'turn-on-pbcopy "../../.dotfiles/.emacs.d/tpanum/functions/pbcopy" "\


\(fn)" t nil)

(autoload 'turn-off-pbcopy "../../.dotfiles/.emacs.d/tpanum/functions/pbcopy" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil "../../.dotfiles/.emacs.d/tpanum/functions/rails"
;;;;;;  "functions/rails.el" "ed85cadde59c3d3b02265b26d40b806f")
;;; Generated autoloads from functions/rails.el

(autoload 'jeg2/read-rails-database-config "../../.dotfiles/.emacs.d/tpanum/functions/rails" "\
Loads the database config as:  adapter database username [password].

\(fn PATH)" nil nil)

;;;***

;;;### (autoloads nil "../../.dotfiles/.emacs.d/tpanum/functions/regexen"
;;;;;;  "functions/regexen.el" "94149a793c65069ca52bdc13ad42809b")
;;; Generated autoloads from functions/regexen.el

(autoload 'jeg2/regex-replace "../../.dotfiles/.emacs.d/tpanum/functions/regexen" "\
Replace a regular expression in the passed string, if it occurs.

\(fn STR REGEX REPLACEMENT &optional FIXEDCASE LITERAL)" nil nil)

(autoload 'jeg2/regex-replace-all "../../.dotfiles/.emacs.d/tpanum/functions/regexen" "\
Replace a regular expression everywhere it occurs in the passed string.

\(fn STR REGEX REPLACEMENT &optional FIXEDCASE LITERAL)" nil nil)

;;;***

;;;### (autoloads nil "../../.dotfiles/.emacs.d/tpanum/functions/strings"
;;;;;;  "functions/strings.el" "afb910a35648a14017cd0ba9d9ae6031")
;;; Generated autoloads from functions/strings.el

(autoload 'jeg2/string-trim "../../.dotfiles/.emacs.d/tpanum/functions/strings" "\
Trim whitespace from both ends of the passed string.

\(fn STR)" nil nil)

(autoload 'jeg2/camelize "../../.dotfiles/.emacs.d/tpanum/functions/strings" "\
Forces a string into CamelCase.

\(fn STR)" nil nil)

;;;***

;;;### (autoloads nil "commands/irc" "../../../.emacs.d/tpanum/commands/irc.el"
;;;;;;  "f8bd6e95b08d56e185e5f83e512bd1d5")
;;; Generated autoloads from ../../../.emacs.d/tpanum/commands/irc.el

(autoload 'tpanum/erc-connect "commands/irc" "\
Prompts for a channel, then connects to IRC.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/lines" "../../../.emacs.d/tpanum/commands/lines.el"
;;;;;;  "d160c24538216a7b71f416151f939b6a")
;;; Generated autoloads from ../../../.emacs.d/tpanum/commands/lines.el

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

;;;### (autoloads nil "commands/markdown" "../../../.emacs.d/tpanum/commands/markdown.el"
;;;;;;  "916b4f802373665171ea94491fcbaebf")
;;; Generated autoloads from ../../../.emacs.d/tpanum/commands/markdown.el

(autoload 'tpanum/markdown-yank-as-pre "commands/markdown" "\
Yank in some text as preformatted.

\(fn)" t nil)

(autoload 'tpanum/markdown-preview "commands/markdown" "\
Preview the current buffer in Marked.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/org" "../../../.emacs.d/tpanum/commands/org.el"
;;;;;;  "7f9aa1404c881421314b72533b5e86a6")
;;; Generated autoloads from ../../../.emacs.d/tpanum/commands/org.el

(autoload 'tpanum/org-new-heading-below "commands/org" "\
Creates a new heading below the current one.

\(fn)" t nil)

(autoload 'tpanum/org-new-heading-above "commands/org" "\
Creates a new heading above the current one.

\(fn)" t nil)

(autoload 'tpanum/org-agenda "commands/org" "\
Opens org agenda with personal directory

\(fn)" t nil)

(autoload 'tpanum/todo-work "commands/org" "\
Opens work todo

\(fn)" t nil)

(autoload 'tpanum/todo-research "commands/org" "\
Opens research todo

\(fn)" t nil)

(autoload 'tpanum/todo-personal "commands/org" "\
Opens personal todo

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/rails" "../../../.emacs.d/tpanum/commands/rails.el"
;;;;;;  "a9dce490750163d7b621930528b840dc")
;;; Generated autoloads from ../../../.emacs.d/tpanum/commands/rails.el

(autoload 'tpanum/rails-console "commands/rails" "\
Invoke inf-ruby with Rails environment loaded.

\(fn)" t nil)

(autoload 'tpanum/rails-dbconsole "commands/rails" "\
Open a SQL shell using the settings from config/database.yml.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/ruby" "../../../.emacs.d/tpanum/commands/ruby.el"
;;;;;;  "66c4e25043fff6773386daf93d119cb1")
;;; Generated autoloads from ../../../.emacs.d/tpanum/commands/ruby.el

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

;;;### (autoloads nil "commands/shell" "../../../.emacs.d/tpanum/commands/shell.el"
;;;;;;  "4f5987a0405e4815906c1cbc315b7dcd")
;;; Generated autoloads from ../../../.emacs.d/tpanum/commands/shell.el

(autoload 'tpanum/open-shell-in-ansi-term "commands/shell" "\
Opens a new shell inside an ansi-terminal.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/spelling" "../../../.emacs.d/tpanum/commands/spelling.el"
;;;;;;  "31edfa8121e0d2354bc1eb7ad0a6fd94")
;;; Generated autoloads from ../../../.emacs.d/tpanum/commands/spelling.el

(autoload 'tpanum/toggle-program-spelling "commands/spelling" "\
Toggle the programmer's spelling mode on and off.

\(fn)" t nil)

(autoload 'tpanum/toggle-spelling "commands/spelling" "\
Toggle the spelling mode on and off.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/strings" "../../../.emacs.d/tpanum/commands/strings.el"
;;;;;;  "57bd77b3a35b55b59706f0c01d6aa816")
;;; Generated autoloads from ../../../.emacs.d/tpanum/commands/strings.el

(autoload 'tpanum/toggle-string-type "commands/strings" "\
Toggle between double, single, and choose-your-own-quotes string types.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "commands/whitespace" "../../../.emacs.d/tpanum/commands/whitespace.el"
;;;;;;  "0ca599a4fcd060dfdfbd51c3d1998c83")
;;; Generated autoloads from ../../../.emacs.d/tpanum/commands/whitespace.el

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

;;;### (autoloads nil "commands/wrap" "../../../.emacs.d/tpanum/commands/wrap.el"
;;;;;;  "99d660c51e1c6dd31f4461766bff1b5f")
;;; Generated autoloads from ../../../.emacs.d/tpanum/commands/wrap.el

(autoload 'tpanum/toggle-wrap "commands/wrap" "\
Toggle the wrap guide and soft wrapping on and off.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "functions/erc-nick-notify" "../../../.emacs.d/tpanum/functions/erc-nick-notify.el"
;;;;;;  "8b64ea8af054948263c7e297dee56a42")
;;; Generated autoloads from ../../../.emacs.d/tpanum/functions/erc-nick-notify.el

(defvar erc-nick-notify-mode nil "\
Non-nil if Erc-Nick-Notify mode is enabled.
See the `erc-nick-notify-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `erc-nick-notify-mode'.")

(custom-autoload 'erc-nick-notify-mode "functions/erc-nick-notify" nil)

(autoload 'erc-nick-notify-mode "functions/erc-nick-notify" "\
Minor mode that calls `erc-nick-notify-cmd' when your nick gets
mentioned in an erc channel.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "functions/files" "../../../.emacs.d/tpanum/functions/files.el"
;;;;;;  "efa216a18442bc41642e9a06873d8852")
;;; Generated autoloads from ../../../.emacs.d/tpanum/functions/files.el

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

;;;### (autoloads nil "functions/jekyll" "../../../.emacs.d/tpanum/functions/jekyll.el"
;;;;;;  "e105114b5f462da30b9c51c413fd7a23")
;;; Generated autoloads from ../../../.emacs.d/tpanum/functions/jekyll.el

(autoload 'tpanum/create-jekyll-post "functions/jekyll" "\
Creates a new buffer and file for a blog post

\(fn TITLE)" t nil)

;;;***

;;;### (autoloads nil "functions/lists" "../../../.emacs.d/tpanum/functions/lists.el"
;;;;;;  "5fcb4cb062b70793f05902071fbef703")
;;; Generated autoloads from ../../../.emacs.d/tpanum/functions/lists.el

(autoload 'tpanum/flatten "functions/lists" "\
Flatten a list.

\(fn X)" nil nil)

;;;***

;;;### (autoloads nil "functions/pbcopy" "../../../.emacs.d/tpanum/functions/pbcopy.el"
;;;;;;  "817b62f4488ced1dde3d2bfa2785e6d4")
;;; Generated autoloads from ../../../.emacs.d/tpanum/functions/pbcopy.el

(autoload 'turn-on-pbcopy "functions/pbcopy" "\


\(fn)" t nil)

(autoload 'turn-off-pbcopy "functions/pbcopy" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil "functions/rails" "../../../.emacs.d/tpanum/functions/rails.el"
;;;;;;  "ed85cadde59c3d3b02265b26d40b806f")
;;; Generated autoloads from ../../../.emacs.d/tpanum/functions/rails.el

(autoload 'jeg2/read-rails-database-config "functions/rails" "\
Loads the database config as:  adapter database username [password].

\(fn PATH)" nil nil)

;;;***

;;;### (autoloads nil "functions/regexen" "../../../.emacs.d/tpanum/functions/regexen.el"
;;;;;;  "94149a793c65069ca52bdc13ad42809b")
;;; Generated autoloads from ../../../.emacs.d/tpanum/functions/regexen.el

(autoload 'jeg2/regex-replace "functions/regexen" "\
Replace a regular expression in the passed string, if it occurs.

\(fn STR REGEX REPLACEMENT &optional FIXEDCASE LITERAL)" nil nil)

(autoload 'jeg2/regex-replace-all "functions/regexen" "\
Replace a regular expression everywhere it occurs in the passed string.

\(fn STR REGEX REPLACEMENT &optional FIXEDCASE LITERAL)" nil nil)

;;;***

;;;### (autoloads nil "functions/strings" "../../../.emacs.d/tpanum/functions/strings.el"
;;;;;;  "afb910a35648a14017cd0ba9d9ae6031")
;;; Generated autoloads from ../../../.emacs.d/tpanum/functions/strings.el

(autoload 'jeg2/string-trim "functions/strings" "\
Trim whitespace from both ends of the passed string.

\(fn STR)" nil nil)

(autoload 'jeg2/camelize "functions/strings" "\
Forces a string into CamelCase.

\(fn STR)" nil nil)

;;;***

;;;### (autoloads nil nil ("../../../.emacs.d/tpanum/commands/alignment.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/comments.el" "../../../.emacs.d/tpanum/commands/erb.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/eshell.el" "../../../.emacs.d/tpanum/commands/html.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/irc.el" "../../../.emacs.d/tpanum/commands/lines.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/lines.el" "../../../.emacs.d/tpanum/commands/lines.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/lines.el" "../../../.emacs.d/tpanum/commands/lines.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/mail.el" "../../../.emacs.d/tpanum/commands/markdown.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/markdown.el" "../../../.emacs.d/tpanum/commands/markdown.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/markdown.el" "../../../.emacs.d/tpanum/commands/markdown.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/org.el" "../../../.emacs.d/tpanum/commands/rails.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/rails.el" "../../../.emacs.d/tpanum/commands/rails.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/rails.el" "../../../.emacs.d/tpanum/commands/rails.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/ruby.el" "../../../.emacs.d/tpanum/commands/ruby.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/ruby.el" "../../../.emacs.d/tpanum/commands/ruby.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/ruby.el" "../../../.emacs.d/tpanum/commands/shell.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/shell.el" "../../../.emacs.d/tpanum/commands/shell.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/shell.el" "../../../.emacs.d/tpanum/commands/shell.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/spelling.el" "../../../.emacs.d/tpanum/commands/spelling.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/spelling.el" "../../../.emacs.d/tpanum/commands/spelling.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/spelling.el" "../../../.emacs.d/tpanum/commands/strings.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/strings.el" "../../../.emacs.d/tpanum/commands/strings.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/strings.el" "../../../.emacs.d/tpanum/commands/strings.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/whitespace.el" "../../../.emacs.d/tpanum/commands/whitespace.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/whitespace.el" "../../../.emacs.d/tpanum/commands/whitespace.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/whitespace.el" "../../../.emacs.d/tpanum/commands/wrap.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/wrap.el" "../../../.emacs.d/tpanum/commands/wrap.el"
;;;;;;  "../../../.emacs.d/tpanum/commands/wrap.el" "../../../.emacs.d/tpanum/commands/wrap.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/erc-nick-notify.el" "../../../.emacs.d/tpanum/functions/erc-nick-notify.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/erc-nick-notify.el" "../../../.emacs.d/tpanum/functions/erc-nick-notify.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/files.el" "../../../.emacs.d/tpanum/functions/files.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/files.el" "../../../.emacs.d/tpanum/functions/files.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/files.el" "../../../.emacs.d/tpanum/functions/fullscreen.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/jekyll.el" "../../../.emacs.d/tpanum/functions/jekyll.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/jekyll.el" "../../../.emacs.d/tpanum/functions/jekyll.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/jekyll.el" "../../../.emacs.d/tpanum/functions/lists.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/lists.el" "../../../.emacs.d/tpanum/functions/lists.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/lists.el" "../../../.emacs.d/tpanum/functions/lists.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/org-gantt.el" "../../../.emacs.d/tpanum/functions/pbcopy.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/pbcopy.el" "../../../.emacs.d/tpanum/functions/pbcopy.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/pbcopy.el" "../../../.emacs.d/tpanum/functions/pbcopy.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/rails.el" "../../../.emacs.d/tpanum/functions/rails.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/rails.el" "../../../.emacs.d/tpanum/functions/rails.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/rails.el" "../../../.emacs.d/tpanum/functions/regexen.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/regexen.el" "../../../.emacs.d/tpanum/functions/regexen.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/regexen.el" "../../../.emacs.d/tpanum/functions/regexen.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/strings.el" "../../../.emacs.d/tpanum/functions/strings.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/strings.el" "../../../.emacs.d/tpanum/functions/strings.el"
;;;;;;  "../../../.emacs.d/tpanum/functions/strings.el" "commands/irc.el"
;;;;;;  "commands/lines.el" "commands/lines.el" "commands/lines.el"
;;;;;;  "commands/lines.el" "commands/lines.el" "commands/markdown.el"
;;;;;;  "commands/markdown.el" "commands/markdown.el" "commands/markdown.el"
;;;;;;  "commands/markdown.el" "commands/org.el" "commands/rails.el"
;;;;;;  "commands/rails.el" "commands/rails.el" "commands/rails.el"
;;;;;;  "commands/rails.el" "commands/ruby.el" "commands/ruby.el"
;;;;;;  "commands/ruby.el" "commands/ruby.el" "commands/ruby.el"
;;;;;;  "commands/shell.el" "commands/shell.el" "commands/shell.el"
;;;;;;  "commands/shell.el" "commands/shell.el" "commands/spelling.el"
;;;;;;  "commands/spelling.el" "commands/spelling.el" "commands/spelling.el"
;;;;;;  "commands/spelling.el" "commands/strings.el" "commands/strings.el"
;;;;;;  "commands/strings.el" "commands/strings.el" "commands/strings.el"
;;;;;;  "commands/whitespace.el" "commands/whitespace.el" "commands/whitespace.el"
;;;;;;  "commands/whitespace.el" "commands/whitespace.el" "commands/wrap.el"
;;;;;;  "commands/wrap.el" "commands/wrap.el" "commands/wrap.el"
;;;;;;  "commands/wrap.el" "functions/files.el" "functions/files.el"
;;;;;;  "functions/files.el" "functions/files.el" "functions/files.el"
;;;;;;  "functions/jekyll.el" "functions/jekyll.el" "functions/jekyll.el"
;;;;;;  "functions/jekyll.el" "functions/jekyll.el" "functions/lists.el"
;;;;;;  "functions/lists.el" "functions/lists.el" "functions/lists.el"
;;;;;;  "functions/lists.el" "functions/pbcopy.el" "functions/pbcopy.el"
;;;;;;  "functions/pbcopy.el" "functions/pbcopy.el" "functions/pbcopy.el"
;;;;;;  "functions/rails.el" "functions/rails.el" "functions/rails.el"
;;;;;;  "functions/rails.el" "functions/rails.el" "functions/regexen.el"
;;;;;;  "functions/regexen.el" "functions/regexen.el" "functions/regexen.el"
;;;;;;  "functions/regexen.el" "functions/strings.el" "functions/strings.el"
;;;;;;  "functions/strings.el" "functions/strings.el" "functions/strings.el")
;;;;;;  (23310 22896 378372 142000))

;;;***

(provide 'loaddefs)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; loaddefs.el ends here
