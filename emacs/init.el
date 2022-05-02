;; Initial bootstrap
;; Start in fullscreen mode
(message (concat "Starting: " (emacs-uptime)))
(toggle-frame-fullscreen)

;; Get rid of all bars
;; Note: this hinders discoverability! Not a problem for me, because
;; counsel-M-x gives discoverability with fuzzy-finding and
;; tmm-menubar still lets me use the menubar when needed. But this is
;; worth considering.
(when (or window-system (daemonp))
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))

;; Set up custom opener command
(defun za/open (what)
  "Use ~/.scripts/open to open a file"
  (shell-command (concat "~/.scripts/open " what)))

;; For some reason, my macOS has a problem verifying certs.
(when (string-equal system-type "darwin")
  (setq package-check-signature nil))

;; Also some problems connecting to package repos on Mac & a specific version
;; https://emacs.stackexchange.com/questions/68288/error-retrieving-https-elpa-gnu-org-packages-archive-contents
(when (and (equal emacs-version "27.2")
           (eql system-type 'darwin))
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

;; Set up packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(setq za/manually-installed-package-dir (concat user-emacs-directory "lisp/"))
(make-directory za/manually-installed-package-dir t)
(add-to-list 'load-path za/manually-installed-package-dir)

;; Install and load use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; Always auto-install packages:
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Follow symlinks without prompting (the org file is a symlink)
(setq vc-follow-symlinks t)

;; Some config should not be public, so it's in a separate file:
(load-file (file-truename (concat user-emacs-directory "secret.el")))

;; Load all other customization from the org file, only compile if necessary
(let* ((.org (file-truename (concat user-emacs-directory "config.org"))) ; the .org file will be in VC
       (.el (concat user-emacs-directory "config.el")) ; config.el is generated, so won't be in VC
       (.org-modification-time (file-attribute-modification-time (file-attributes .org)))
       (.el-modification-time (file-attribute-modification-time (file-attributes .el)))
       (config-unchanged-p (and (file-exists-p .el) (time-less-p .org-modification-time .el-modification-time))))

  (require 'org-macs)
  (unless config-unchanged-p
    (require 'ob-tangle)
    (org-babel-tangle-file .org .el "emacs-lisp"))
  (load-file .el))
