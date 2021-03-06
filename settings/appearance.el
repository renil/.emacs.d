(setq visible-bell t
      font-lock-maximum-decoration t
      color-theme-is-global t
      truncate-partial-width-windows nil)

;; Highlight current line
(global-hl-line-mode 1)

;; Set custom theme path
(setq custom-theme-directory (concat user-emacs-directory "themes"))
(dolist
    (path (directory-files custom-theme-directory t "\\w+"))
  (when (file-directory-p path)
    (add-to-list 'custom-theme-load-path path)))

(defun use-default-theme ()
  (interactive)
  (load-theme 'default-black)
  (when (boundp 'magnars/default-font)
    (set-face-attribute 'default nil :font magnars/default-font)))

;(use-default-theme)
(load-theme 'monokai)

;; Don't defer screen updates when performing operations
(setq redisplay-dont-pause t)

;; org-mode colors
(setq org-todo-keyword-faces
      '(
	("INPR" . (:foreground "yellow" :weight bold))
	("DONE" . (:foreground "green" :weight bold))
	("IMPEDED" . (:foreground "red" :weight bold))
	))

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

;; Change the frame name to the name of the buffer
;; No blinking cursor on when not using emacs in console
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (blink-cursor-mode -1))

(provide 'appearance)