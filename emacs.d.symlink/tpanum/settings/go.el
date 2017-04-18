;; requires goimports installed (go get golang.org/x/tools/cmd/goimports)
(if (executable-find "goimports") (setq gofmt-command "goimports"))
