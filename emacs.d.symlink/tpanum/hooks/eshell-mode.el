;; enable autocompletion
(company-mode)
(setq-local company-backends '((company-capf)))

;; custom styling for these types of buffers
(defface eshell-face '((t :background "black")) "")
(face-remap-add-relative 'default 'eshell-face)

;; navigate command history
(local-set-key (kbd "M-k") 'eshell-previous-input)
(local-set-key (kbd "M-j") 'eshell-next-input)

(setenv "GOPATH" "/Users/panum/work/gocode")

(setenv "DOCKER_HOST" "tcp://192.168.59.103:2376")
(setenv "DOCKER_CERT_PATH" "/Users/panum/.boot2docker/certs/boot2docker-vm")
(setenv "DOCKER_TLS_VERIFY" "1")

;; source $(brew --prefix nvm)/nvm.sh

(setenv "NVM_DIR" "/Users/panum/.nvm")

(define-key evil-normal-state-local-map "A" 'eshell-insert)
