(require 'cl-macs)
(require 'sql)

;;;###autoload
(defun tpanum/rails-console ()
  "Invoke inf-ruby with Rails environment loaded."
  (interactive)
  (let ((config (tpanum/find-in-path "config/environment.rb")))
    (if config
        (let ((binstub (concat (file-name-directory
                                (substring (file-name-directory config) 0 -1))
                               "bin/rails")))
          (if (file-exists-p binstub)
              (run-ruby (concat binstub " console") "rails")
            (run-ruby "bundle exec rails console" "rails"))))))

;;;###autoload
(defun tpanum/rails-dbconsole ()
  "Open a SQL shell using the settings from config/database.yml."
  (interactive)
  (let ((config (tpanum/find-in-path "config/database.yml")))
    (if config
        (let* ((env     (tpanum/read-rails-database-config config))
               (adapter (car env))
               (db      (cond ((string-match "\\`mysql"   adapter)
                               "mysql")
                              ((string-match "\\`sqlite"  adapter)
                               "sqlite")
                              ((string=      "postgresql" adapter)
                               "postgres"))))
          (let ((sql-fun      (intern (concat "sql-" db)))
                (sql-database (cadr   env))
                (sql-user     (or (caddr  env) user-login-name))
                (sql-password (cadddr env)))
            (cl-letf (((symbol-function 'sql-get-login)  ; silence confirmation
                       #'(lambda (&rest what) t)))
              (funcall sql-fun)))))))
