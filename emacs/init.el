;; Follow symlinks without prompting (the org file is a symlink)
(setq vc-follow-symlinks t)

(org-babel-load-file
 (expand-file-name "config.org" user-emacs-directory))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f2927d7d87e8207fa9a0a003c0f222d45c948845de162c885bf6ad2a255babfd" "e3c64e88fec56f86b49dcdc5a831e96782baf14b09397d4057156b17062a8848" "f4876796ef5ee9c82b125a096a590c9891cec31320569fc6ff602ff99ed73dca" default))
 '(package-selected-packages
   '(lean-mode markdown-mode anki-connect anki-editor doom-themes all-the-icons use-package-ensure which-key use-package org-bullets helm exec-path-from-shell)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-buffer-file ((t (:inherit default))))
 '(helm-ff-file-extension ((t (:inherit default))))
 '(helm-non-file-buffer ((t (:inherit font-lock-comment-face)))))
