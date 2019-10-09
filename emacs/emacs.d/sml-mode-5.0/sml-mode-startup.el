;;; sml-mode-startup.el --- automatically extracted autoloads
;;; Code:
(add-to-list 'load-path
             (or (file-name-directory load-file-name) (car load-path)))

;;;### (autoloads (sml-yacc-mode sml-lex-mode sml-cm-mode sml-mode)
;;;;;;  "sml-mode" "sml-mode.el" (20358 8148))
;;; Generated autoloads from sml-mode.el

(add-to-list 'auto-mode-alist '("\\.s\\(ml\\|ig\\)\\'" . sml-mode))

(autoload 'sml-mode "sml-mode" "\
\\<sml-mode-map>Major mode for editing ML code.
This mode runs `sml-mode-hook' just before exiting.
\\{sml-mode-map}

\(fn)" t nil)

(add-to-list 'completion-ignored-extensions ".cm/")

(add-to-list 'auto-mode-alist '("\\.cm\\'" . sml-cm-mode))

(autoload 'sml-cm-mode "sml-mode" "\
Major mode for SML/NJ's Compilation Manager configuration files.

\(fn)" t nil)

(autoload 'sml-lex-mode "sml-mode" "\
Major Mode for editing ML-Lex files.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.grm\\'" . sml-yacc-mode))

(autoload 'sml-yacc-mode "sml-mode" "\
Major Mode for editing ML-Yacc files.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "sml-mode" '("font-lock-type-def-face" "font-lock-module-def-face" "font-lock-interface-def-face")))

;;;***

;;;### (autoloads nil "sml-oldindent" "sml-oldindent.el" (20358 8148))
;;; Generated autoloads from sml-oldindent.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "sml-oldindent" '("sml-")))

;;;***

;;;### (autoloads nil "sml-proc" "sml-proc.el" (20358 8148))
;;; Generated autoloads from sml-proc.el

(autoload 'run-sml "sml-proc" nil t)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "sml-proc" '("sml-" "inferior-sml-" "font-lock-" "run-sml" "switch-to-sml")))

;;;***

