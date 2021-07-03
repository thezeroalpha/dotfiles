;; Follow symlinks without prompting (the org file is a symlink)
(setq vc-follow-symlinks t)

(org-babel-load-file
 (expand-file-name "config.org" user-emacs-directory))
