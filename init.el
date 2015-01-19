;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No startup message and echo area message, please
(setq initial-scratch-message "")
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;; Set path to dependencies
(setq site-lisp-dir
(expand-file-name "site-lisp" user-emacs-directory))
(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path settings-dir)
(add-to-list 'load-path site-lisp-dir)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Set up appearance early
(require 'appearance)

;; Add external projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; Setup packages
(require 'setup-package)

;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   '(magit
     paredit
     move-text
     gist
     htmlize
     visual-regexp
     markdown-mode
     company
     fill-column-indicator
     flycheck
     flycheck-pos-tip
     flx
     flx-ido
     ido-ubiquitous
     dired-details
     css-eldoc
     yasnippet
     smartparens
     ido-vertical-mode
     ido-at-point
     simple-httpd
     guide-key
     nodejs-repl
     restclient
     highlight-escape-sequences
     whitespace-cleanup-mode
     elisp-slime-nav
     git-commit-mode
     gitconfig-mode
     dockerfile-mode
     gitignore-mode
     clojure-mode
     prodigy
     cider
     powershell
     omnisharp
     )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

(require 'sane-defaults)
(require 'ido)

;; Setup Extensions
(eval-after-load 'ido '(require 'setup-ido))
; (eval-after-load 'org '(require 'setup-org))
; (eval-after-load 'dired '(require 'setup-dired))
(eval-after-load 'magit '(require 'setup-magit))
; (eval-after-load 'grep '(require 'setup-rgrep))
; (eval-after-load 'shell '(require 'setup-shell))
; (require 'setup-hippie)
; (require 'setup-yasnippet)
; (require 'setup-perspective)
; (require 'setup-ffip)
; (require 'setup-html-mode)
; (require 'setup-paredit)

(require 'prodigy)
(global-set-key (kbd "C-x M-m") 'prodigy)

;; Font lock dash.el
;(eval-after-load "dash" '(dash-enable-font-lock))

;; Default setup of smartparens
(require 'smartparens-config)
(setq sp-autoescape-string-quote nil)
    (--each '(css-mode-hook
              restclient-mode-hook
              js-mode-hook
              java-mode
              ruby-mode
              markdown-mode
              groovy-mode)
    (add-hook it 'turn-on-smartparens-mode))


;; Language specific setup files
; (eval-after-load 'js2-mode '(require 'setup-js2-mode))
; (eval-after-load 'ruby-mode '(require 'setup-ruby-mode))
; (eval-after-load 'clojure-mode '(require 'setup-clojure-mode))
; (eval-after-load 'markdown-mode '(require 'setup-markdown-mode))
(eval-after-load 'csharp-mode '(require 'setup-omnisharp-mode))

;; Map files to modes
(require 'mode-mappings)

;; setup Key bindings
(require 'key-bindings)
