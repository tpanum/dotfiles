;;;###autoload
(defun tpanum/create-jekyll-post
  (title)
  "Creates a new buffer and file for a blog post"
  (interactive "sTitle of blog post: ")
  (let
      ((filename
        (concat
         (format-time-string "%Y-%m-%d-")
         (replace-regexp-in-string " " "-"
                                   (downcase
                                    (replace-regexp-in-string "[^0-9a-zA-Z ]" "" title))))))
    (switch-to-buffer
     (generate-new-buffer filename))
    (insert
     (concat
      (mapconcat 'identity
                 '("---" "layout: post")
                 "\n")
      "\n" "title: '" title "'\n" "date: '"
      (format-time-string "%Y-%m-%d %H:%M:%S %z")
      "'\n" "---\n"))
    (if
        (boundp 'blog-home)
        (write-file
         (concat blog-home "/_posts/" filename ".markdown")))))
