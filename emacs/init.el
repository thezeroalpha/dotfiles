;; Follow symlinks without prompting (the org file is a symlink)
(setq vc-follow-symlinks t)

;; Get rid of all bars
(setq org-src-tab-acts-natively t)
(when window-system
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))

;; Start in fullscreen mode
(toggle-frame-fullscreen)

;; Load all other customization from the org file
(org-babel-load-file
 (expand-file-name "config.org" user-emacs-directory))
