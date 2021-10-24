;; Initial bootstrap
;; Follow symlinks without prompting (the org file is a symlink)
(setq vc-follow-symlinks t)

;; Get rid of all bars
(setq org-src-tab-acts-natively t)
(when window-system
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))

;; For some reason, my macOS has a problem verifying certs.
(when (string-equal system-type "darwin")
  (setq package-check-signature nil))

;; Install and load use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents t)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; Always auto-install packages:
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Start in fullscreen mode
(toggle-frame-fullscreen)

;; Load all other customization from the org file
(org-babel-load-file
 (expand-file-name "config.org" user-emacs-directory))
