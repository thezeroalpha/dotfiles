;;; sml-mode.el --- Major mode for editing (Standard) ML

;; Copyright (C) 1999,2000,2004,2007,2010-2012  Stefan Monnier
;; Copyright (C) 1994-1997  Matthew J. Morley
;; Copyright (C) 1989       Lars Bo Nielsen

;; Author: Lars Bo Nielsen
;;      Olin Shivers
;;	Fritz Knabe (?)
;;	Steven Gilmore (?)
;;	Matthew Morley <mjm@scs.leeds.ac.uk> (aka <matthew@verisity.com>)
;;	Matthias Blume <blume@cs.princeton.edu> (aka <blume@kurims.kyoto-u.ac.jp>)
;;      (Stefan Monnier) <monnier@iro.umontreal.ca>
;; Maintainer: (Stefan Monnier) <monnier@iro.umontreal.ca>
;; Keywords: SML

;; This file is not part of GNU Emacs, but it is distributed under the
;; same conditions.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING. If not, write to the
;; Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;;; HISTORY

;; Still under construction: History obscure, needs a biographer as
;; well as a M-x doctor. Change Log on request.

;; Hacked by Olin Shivers for comint from Lars Bo Nielsen's sml.el.

;; Hacked by Matthew Morley to incorporate Fritz Knabe's hilite and
;; font-lock patterns, some of Steven Gilmore's (reduced) easy-menus,
;; and numerous bugs and bug-fixes.

;;; DESCRIPTION

;; See accompanying info file: sml-mode.info

;;; FOR YOUR .EMACS FILE

;; If sml-mode.el lives in some non-standard directory, you must tell
;; emacs where to get it. This may or may not be necessary:

;; (add-to-list 'load-path "~jones/lib/emacs/")

;; Then to access the commands autoload sml-mode with that command:

;; (load "sml-mode-startup")

;; sml-mode-hook is run whenever a new sml-mode buffer is created.

;; Finally, there are inferior-sml-{mode,load}-hooks -- see comments
;; in sml-proc.el. For much more information consult the mode's *info*
;; tree.

;;; Code:

(eval-when-compile (require 'cl))
(require 'smie nil 'noerror)

(condition-case nil (require 'skeleton) (error nil))

(defgroup sml ()
  "Editing SML code."
  :group 'languages)

;;; VARIABLES CONTROLLING INDENTATION

(defcustom sml-indent-level 4
  "Indentation of blocks in ML (see also `sml-indent-rule')."
  :type '(integer))

(defcustom sml-indent-args sml-indent-level
  "Indentation of args placed on a separate line."
  :type '(integer))

;; (defvar sml-indent-align-args t
;;   "*Whether the arguments should be aligned.")

;; (defvar sml-case-indent nil
;;   "*How to indent case-of expressions.
;;     If t:   case expr                     If nil:   case expr of
;;               of exp1 => ...                            exp1 => ...
;;                | exp2 => ...                          | exp2 => ...

;; The first seems to be the standard in SML/NJ, but the second
;; seems nicer...")

(defcustom sml-electric-semi-mode nil
  "If non-nil, `\;' will self insert, reindent the line, and do a newline.
If nil, just insert a `\;'.  (To insert while t, do: \\[quoted-insert] \;)."
  :type 'boolean)
(when (fboundp 'electric-layout-mode)
  (make-obsolete-variable 'sml-electric-semi-mode
                          'electric-layout-mode "Emacs-24"))

(defcustom sml-rightalign-and t
  "If non-nil, right-align `and' with its leader.
If nil:					If t:
	datatype a = A				datatype a = A
	and b = B				     and b = B"
  :type 'boolean)

;;; OTHER GENERIC MODE VARIABLES

(defvar sml-mode-info "sml-mode"
  "*Where to find Info file for `sml-mode'.
The default assumes the info file \"sml-mode.info\" is on Emacs' info
directory path.  If it is not, either put the file on the standard path
or set the variable `sml-mode-info' to the exact location of this file

  (setq sml-mode-info \"/usr/me/lib/info/sml-mode\")

in your .emacs file. You can always set it interactively with the
set-variable command.")

(defvar sml-mode-hook nil
  "*Run upon entering `sml-mode'.
This is a good place to put your preferred key bindings.")

;;; CODE FOR SML-MODE

(defun sml-mode-info ()
  "Command to access the TeXinfo documentation for `sml-mode'.
See doc for the variable `sml-mode-info'."
  (interactive)
  (require 'info)
  (condition-case nil
      (info sml-mode-info)
    (error (progn
             (describe-variable 'sml-mode-info)
             (message "Can't find it... set this variable first!")))))


;;; Autoload functions -- no-doc is another idea cribbed from AucTeX!

(let ((sml-no-doc
       "This function is part of sml-proc, and has not yet been loaded.
Full documentation will be available after autoloading the function."))

  (autoload 'sml-compile	"sml-proc"   sml-no-doc t)
  (autoload 'sml-load-file	"sml-proc"   sml-no-doc t)
  (autoload 'switch-to-sml	"sml-proc"   sml-no-doc t)
  (autoload 'sml-send-region	"sml-proc"   sml-no-doc t)
  (autoload 'sml-send-buffer	"sml-proc"   sml-no-doc t))

;; font-lock setup

(defvar sml-outline-regexp
  ;; `st' and `si' are to match structure and signature.
  "\\|s[ti]\\|[ \t]*\\(let[ \t]+\\)?\\(fun\\|and\\)\\>"
  "Regexp matching a major heading.
This actually can't work without extending `outline-minor-mode' with the
notion of \"the end of an outline\".")

;;
;; Internal defines
;;

(defvar sml-mode-map
  (let ((map (make-sparse-keymap)))
    ;; Smarter cursor movement.
    ;; (define-key map [remap forward-sexp] 'sml-user-forward-sexp)
    ;; (define-key map [remap backward-sexp] 'sml-user-backward-sexp)
    ;; Text-formatting commands:
    (define-key map "\C-c\C-m" 'sml-insert-form)
    (define-key map "\C-c\C-i" 'sml-mode-info)
    (define-key map "\M-|" 'sml-electric-pipe)
    (define-key map "\M-\ " 'sml-electric-space)
    (define-key map "\;" 'sml-electric-semi)
    (define-key map [backtab] 'sml-back-to-outer-indent)
    ;; Process commands added to sml-mode-map -- these should autoload.
    (define-key map "\C-c\C-l" 'sml-load-file)
    (define-key map "\C-c\C-c" 'sml-compile)
    (define-key map "\C-c\C-s" 'switch-to-sml)
    (define-key map "\C-c\C-r" 'sml-send-region)
    (define-key map "\C-c\C-b" 'sml-send-buffer)
    map)
  "The keymap used in `sml-mode'.")

(defconst sml-builtin-nested-comments-flag
  (ignore-errors
    (not (equal (let ((st (make-syntax-table)))
		  (modify-syntax-entry ?\* ". 23n" st) st)
		(let ((st (make-syntax-table)))
		  (modify-syntax-entry ?\* ". 23" st) st))))
  "Non-nil means this Emacs understands the `n' in syntax entries.")

(defvar sml-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?\* (if sml-builtin-nested-comments-flag
                                 ". 23n" ". 23") st)
    (modify-syntax-entry ?\( "()1" st)
    (modify-syntax-entry ?\) ")(4" st)
    (mapc (lambda (c) (modify-syntax-entry c "_" st)) "._'")
    (mapc (lambda (c) (modify-syntax-entry c "." st)) ",;")
    ;; `!' is not really a prefix-char, oh well!
    (mapc (lambda (c) (modify-syntax-entry c "'"  st)) "~#!")
    (mapc (lambda (c) (modify-syntax-entry c "."  st)) "%&$+-/:<=>?@`^|")
    st)
  "The syntax table used in `sml-mode'.")


(easy-menu-define sml-mode-menu sml-mode-map "Menu used in `sml-mode'."
  '("SML"
    ("Process"
     ["Start default ML compiler" run-sml		t]
     ["-" nil nil]
     ["run CM.make"		sml-compile	t]
     ["load ML source file"	sml-load-file	t]
     ["switch to ML buffer"	switch-to-sml	t]
     ["--" nil nil]
     ["send buffer contents"	sml-send-buffer	t]
     ["send region"		sml-send-region	t]
     ["send paragraph"		sml-send-function t]
     ["goto next error"		next-error	(featurep 'sml-proc)]
     ["---" nil nil]
     ;; ["Standard ML of New Jersey" sml-smlnj	(fboundp 'sml-smlnj)]
     ;; ["Poly/ML"			sml-poly-ml	(fboundp 'sml-poly-ml)]
     ;; ["Moscow ML"		sml-mosml	(fboundp 'sml-mosml)]
     ["Help for Inferior ML"	(describe-function 'inferior-sml-mode)
      :active (featurep 'sml-proc)])
    ["electric pipe"     sml-electric-pipe t]
    ["insert SML form"   sml-insert-form t]
    ("Forms" :filter sml-forms-menu)
    ("Format/Mode Variables"
     ["indent region"             indent-region t]
     ["outdent"                   sml-back-to-outer-indent t]
     ;; ["-" nil nil]
     ;; ["set indent-level"          sml-indent-level t]
     ;; ["set pipe-indent"           sml-pipe-indent t]
     ;; ["--" nil nil]
     ;; ["toggle type-of-indent"     sml-type-of-indent t]
     ;; ["toggle nested-if-indent"   sml-nested-if-indent t]
     ;; ["toggle electric-semi-mode" sml-electric-semi-mode t]
     )
    ["-----" nil nil]
    ["SML mode help (brief)"       describe-mode t]
    ["SML mode *info*"             sml-mode-info t]
    ["Remove overlay"    (sml-error-overlay 'undo)
     :visible (or (and (boundp 'sml-error-overlay)
                       sml-error-overlay)
                  (not (fboundp 'compilation-fake-loc)))
     :active (and (boundp 'sml-error-overlay)
                  (overlayp sml-error-overlay)
                  (overlay-start sml-error-overlay))
     ]))

;; Make's sure they appear in the menu bar when sml-mode-map is active.
;; On the hook for XEmacs only -- see easy-menu-add in auc-menu.el.
;; (defun sml-mode-menu-bar ()
;;   "Make sure menus appear in the menu bar as well as under mouse 3."
;;   (and (eq major-mode 'sml-mode)
;;        (easy-menu-add sml-mode-menu sml-mode-map)))
;; (add-hook 'sml-mode-hook 'sml-mode-menu-bar)

;;
;; regexps
;;

(defun sml-syms-re (syms)
  (concat "\\<" (regexp-opt syms t) "\\>"))

;;

(defconst sml-module-head-syms
  '("signature" "structure" "functor" "abstraction"))


(defconst sml-=-starter-syms
  (list* "|" "val" "fun" "and" "datatype" "type" "abstype" "eqtype"
	 sml-module-head-syms)
  "Symbols that can be followed by a `='.")
(defconst sml-=-starter-re
  (concat "\\S.|\\S.\\|" (sml-syms-re (cdr sml-=-starter-syms)))
  "Symbols that can be followed by a `='.")

(defconst sml-non-nested-of-starter-re
  (sml-syms-re '("datatype" "abstype" "exception"))
  "Symbols that can introduce an `of' that shouldn't behave like a paren.")

(defconst sml-starters-syms
  (append sml-module-head-syms
	  '("abstype" "datatype" "exception" "fun"
	    "local" "infix" "infixr" "sharing" "nonfix"
	    "open" "type" "val" "and"
	    "withtype" "with"))
  "The starters of new expressions.")

(defconst sml-pipeheads
   '("|" "of" "fun" "fn" "and" "handle" "datatype" "abstype")
   "A `|' corresponds to one of these.")

(defconst sml-keywords-regexp
  (sml-syms-re '("abstraction" "abstype" "and" "andalso" "as" "before" "case"
                 "datatype" "else" "end" "eqtype" "exception" "do" "fn"
                 "fun" "functor" "handle" "if" "in" "include" "infix"
                 "infixr" "let" "local" "nonfix" "of" "op" "open" "orelse"
                 "overload" "raise" "rec" "sharing" "sig" "signature"
                 "struct" "structure" "then" "type" "val" "where" "while"
                 "with" "withtype" "o"))
  "A regexp that matches any and all keywords of SML.")

(defconst sml-tyvarseq-re
  "\\(\\('+\\(\\sw\\|\\s_\\)+\\|(\\([,']\\|\\sw\\|\\s_\\|\\s-\\)+)\\)\\s-+\\)?")

;;; Font-lock settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defcustom sml-font-lock-symbols nil
  "Display \\ and -> and such using symbols in fonts.
This may sound like a neat trick, but be extra careful: it changes the
alignment and can thus lead to nasty surprises w.r.t layout.
If t, try to use whichever font is available.  Otherwise you can
set it to a particular font of your preference among `japanese-jisx0208'
and `unicode'."
  :type '(choice (const nil)
	         (const t)
	         (const unicode)
	         (const japanese-jisx0208)))

(defconst sml-font-lock-symbols-alist
  (append
   ;; The symbols can come from a JIS0208 font.
   (and (fboundp 'make-char) (charsetp 'japanese-jisx0208)
	(memq sml-font-lock-symbols '(t japanese-jisx0208))
	(list (cons "fn" (make-char 'japanese-jisx0208 38 75))
	      (cons "andalso" (make-char 'japanese-jisx0208 34 74))
	      (cons "orelse" (make-char 'japanese-jisx0208 34 75))
	      ;; (cons "as" (make-char 'japanese-jisx0208 34 97))
	      (cons "not" (make-char 'japanese-jisx0208 34 76))
	      (cons "div" (make-char 'japanese-jisx0208 33 96))
	      ;; (cons "*" (make-char 'japanese-jisx0208 33 95))
	      (cons "->" (make-char 'japanese-jisx0208 34 42))
	      (cons "=>" (make-char 'japanese-jisx0208 34 77))
	      (cons "<-" (make-char 'japanese-jisx0208 34 43))
	      (cons "<>" (make-char 'japanese-jisx0208 33 98))
	      (cons ">=" (make-char 'japanese-jisx0208 33 102))
	      (cons "<=" (make-char 'japanese-jisx0208 33 101))
	      (cons "..." (make-char 'japanese-jisx0208 33 68))
	      ;; Some greek letters for type parameters.
	      (cons "'a" (make-char 'japanese-jisx0208 38 65))
	      (cons "'b" (make-char 'japanese-jisx0208 38 66))
	      (cons "'c" (make-char 'japanese-jisx0208 38 67))
	      (cons "'d" (make-char 'japanese-jisx0208 38 68))
	      ))
   ;; Or a unicode font.
   (and (fboundp 'decode-char)
	(memq sml-font-lock-symbols '(t unicode))
	(list (cons "fn" (decode-char 'ucs 955))
	      (cons "andalso" (decode-char 'ucs 8896))
	      (cons "orelse" (decode-char 'ucs 8897))
	      ;; (cons "as" (decode-char 'ucs 8801))
	      (cons "not" (decode-char 'ucs 172))
	      (cons "div" (decode-char 'ucs 247))
	      (cons "*" (decode-char 'ucs 215))
	      (cons "o"  (decode-char 'ucs 9675))
	      (cons "->" (decode-char 'ucs 8594))
	      (cons "=>" (decode-char 'ucs 8658))
	      (cons "<-" (decode-char 'ucs 8592))
	      (cons "<>" (decode-char 'ucs 8800))
	      (cons ">=" (decode-char 'ucs 8805))
	      (cons "<=" (decode-char 'ucs 8804))
	      (cons "..." (decode-char 'ucs 8943))
	      ;; (cons "::" (decode-char 'ucs 8759))
	      ;; Some greek letters for type parameters.
	      (cons "'a" (decode-char 'ucs 945))
	      (cons "'b" (decode-char 'ucs 946))
	      (cons "'c" (decode-char 'ucs 947))
	      (cons "'d" (decode-char 'ucs 948))
	      ))))

(defun sml-font-lock-compose-symbol (alist)
  "Compose a sequence of ascii chars into a symbol.
Regexp match data 0 points to the chars."
  ;; Check that the chars should really be composed into a symbol.
  (let* ((start (match-beginning 0))
	 (end (match-end 0))
	 (syntaxes (if (eq (char-syntax (char-after start)) ?w)
		       '(?w) '(?. ?\\))))
    (if (or (memq (char-syntax (or (char-before start) ?\ )) syntaxes)
	    (memq (char-syntax (or (char-after end) ?\ )) syntaxes)
	    (memq (get-text-property start 'face)
		  '(font-lock-doc-face font-lock-string-face
		    font-lock-comment-face)))
	;; No composition for you.  Let's actually remove any composition
	;; we may have added earlier and which is now incorrect.
	(remove-text-properties start end '(composition))
      ;; That's a symbol alright, so add the composition.
      (compose-region start end (cdr (assoc (match-string 0) alist)))))
  ;; Return nil because we're not adding any face property.
  nil)

(defun sml-font-lock-symbols-keywords ()
  (when (fboundp 'compose-region)
    (let ((alist nil))
      (dolist (x sml-font-lock-symbols-alist)
	(when (and (if (fboundp 'char-displayable-p)
		       (char-displayable-p (cdr x))
		     t)
		   (not (assoc (car x) alist)))	;Not yet in alist.
	  (push x alist)))
      (when alist
	`((,(regexp-opt (mapcar 'car alist) t)
	   (0 (sml-font-lock-compose-symbol ',alist))))))))

;; The font lock regular expressions.

(defconst sml-font-lock-keywords
  `(;;(sml-font-comments-and-strings)
    (,(concat "\\<\\(fun\\|and\\)\\s-+" sml-tyvarseq-re "\\(\\sw+\\)\\s-+[^ \t\n=]")
     (1 font-lock-keyword-face)
     (6 font-lock-function-name-face))
    (,(concat "\\<\\(\\(data\\|abs\\|with\\|eq\\)?type\\)\\s-+" sml-tyvarseq-re "\\(\\sw+\\)")
     (1 font-lock-keyword-face)
     (7 font-lock-type-def-face))
    ("\\<\\(val\\)\\s-+\\(\\sw+\\>\\s-*\\)?\\(\\sw+\\)\\s-*[=:]"
     (1 font-lock-keyword-face)
     ;;(6 font-lock-variable-def-face nil t)
     (3 font-lock-variable-name-face))
    ("\\<\\(structure\\|functor\\|abstraction\\)\\s-+\\(\\sw+\\)"
     (1 font-lock-keyword-face)
     (2 font-lock-module-def-face))
    ("\\<\\(signature\\)\\s-+\\(\\sw+\\)"
     (1 font-lock-keyword-face)
     (2 font-lock-interface-def-face))
    
    (,sml-keywords-regexp . font-lock-keyword-face)
    ,@(sml-font-lock-symbols-keywords))
  "Regexps matching standard SML keywords.")

(defface font-lock-type-def-face
  '((t (:bold t)))
  "Font Lock mode face used to highlight type definitions."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-type-def-face 'font-lock-type-def-face
  "Face name to use for type definitions.")

(defface font-lock-module-def-face
  '((t (:bold t)))
  "Font Lock mode face used to highlight module definitions."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-module-def-face 'font-lock-module-def-face
  "Face name to use for module definitions.")

(defface font-lock-interface-def-face
  '((t (:bold t)))
  "Font Lock mode face used to highlight interface definitions."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-interface-def-face 'font-lock-interface-def-face
  "Face name to use for interface definitions.")

;;
;; Code to handle nested comments and unusual string escape sequences
;;

(defvar sml-syntax-prop-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?\\ "." st)
    (modify-syntax-entry ?* "." st)
    st)
  "Syntax table for text-properties")

;; For Emacsen that have no built-in support for nested comments
(defun sml-get-depth-st ()
  (save-excursion
    (let* ((disp (if (eq (char-before) ?\)) (progn (backward-char) -1) nil))
	   (_ (backward-char))
	   (disp (if (eq (char-before) ?\() (progn (backward-char) 0) disp))
	   (pt (point)))
      (when disp
	(let* ((depth
		(save-match-data
		  (if (re-search-backward "\\*)\\|(\\*" nil t)
		      (+ (or (get-char-property (point) 'comment-depth) 0)
			 (case (char-after) (?\( 1) (?* 0))
			 disp)
		    0)))
	       (depth (if (> depth 0) depth)))
	  (put-text-property pt (1+ pt) 'comment-depth depth)
	  (when depth sml-syntax-prop-table))))))

(defconst sml-font-lock-syntactic-keywords
  `(("^\\s-*\\(\\\\\\)" (1 ',sml-syntax-prop-table))
    ,@(unless sml-builtin-nested-comments-flag
	'(("(?\\(\\*\\))?" (1 (sml-get-depth-st)))))))

(defconst sml-font-lock-defaults
  '(sml-font-lock-keywords nil nil ((?_ . "w") (?' . "w")) nil
    (font-lock-syntactic-keywords . sml-font-lock-syntactic-keywords)))


;;; Indentation with SMIE

(defvar sml-use-smie t)

(defconst sml-smie-grammar
  (when (fboundp 'smie-prec2->grammar)
    ;; We have several problem areas where SML's syntax can't be handled by an
    ;; operator precedence grammar:
    ;;
    ;; "= A before B" is "= A) before B" if this is the
    ;;   `boolean-=' but it is "= (A before B)" if it's the `definitional-='.
    ;;   We can work around the problem by tweaking the lexer to return two
    ;;   different tokens for the two different kinds of `='.
    ;; "of A | B" in a "case" we want "of (A | B, but in a `datatype'
    ;;   we want "of A) | B".
    ;; "= A | B" can be "= A ) | B" if the = is from a "fun" definition,
    ;;   but it is "= (A | B" if it is a `datatype' definition (of course, if
    ;;   the previous token introducing the = is `and', deciding whether
    ;;   it's a datatype or a function requires looking even further back).
    ;; "functor foo (...) where type a = b = ..." the first `=' looks very much
    ;;   like a `definitional-=' even tho it's just an equality constraint.
    ;;   Currently I don't even try to handle `where' at all.
    (smie-prec2->grammar
     (smie-merge-prec2s
      (smie-bnf->prec2
       '((exp ("if" exp "then" exp "else" exp)
              ("case" exp "of" branches)
              ("let" decls "in" cmds "end")
              ("struct" decls "end")
              ("sig" decls "end")
              (sexp)
              (sexp "handle" branches)
              ("fn" sexp "=>" exp))
         ;; "simple exp"s are the ones that can appear to the left of `handle'.
         (sexp (sexp ":" type) ("(" exps ")")
               (sexp "orelse" sexp)
               (marg ":>" type)
               (sexp "andalso" sexp))
         (cmds (cmds ";" cmds) (exp))
         (exps (exps "," exps) (exp))   ; (exps ";" exps)
         (branches (sexp "=>" exp) (branches "|" branches))
         ;; Operator precedence grammars handle separators much better then
         ;; starters/terminators, so let's pretend that let/fun are separators.
         (decls (sexp "d=" exp)
                (sexp "d=" databranches)
                (funbranches "|" funbranches)
                (sexp "=of" type)       ;After "exception".
                ;; FIXME: Just like PROCEDURE in Pascal and Modula-2, this
                ;; interacts poorly with the other constructs since I
                ;; can't make "local" a separator like fun/val/type/...
                ("local" decls "in" decls "end")
                ;; (decls "local" decls "in" decls "end")
                (decls "functor" decls)
                (decls "signature" decls)
                (decls "structure" decls)
                (decls "type" decls)
                (decls "open" decls)
                (decls "and" decls)
                (decls "infix" decls)
                (decls "infixr" decls)
                (decls "nonfix" decls)
                (decls "abstype" decls)
                (decls "datatype" decls)
                (decls "exception" decls)
                (decls "fun" decls)
                (decls "val" decls))
         (type (type "->" type)
               (type "*" type))
         (funbranches (sexp "d=" exp))
         (databranches (sexp "=of" type) (databranches "d|" databranches))
         ;; Module language.
         ;; (mexp ("functor" marg "d=" mexp)
         ;;       ("structure" marg "d=" mexp)
         ;;       ("signature" marg "d=" mexp))
         (marg (marg ":" type) (marg ":>" type))
         (toplevel (decls) (exp) (toplevel ";" toplevel)))
       ;; '(("local" . opener))
       ;; '((nonassoc "else") (right "handle"))
       '((nonassoc "of") (assoc "|")) ; "case a of b => case c of d => e | f"
       '((nonassoc "handle") (assoc "|")) ; Idem for "handle".
       '((assoc "->") (assoc "*"))
       '((assoc "val" "fun" "type" "datatype" "abstype" "open" "infix" "infixr"
                "nonfix" "functor" "signature" "structure" "exception"
                ;; "local"
                )
         (assoc "and"))
       '((assoc "orelse") (assoc "andalso") (nonassoc ":"))
       '((assoc ";")) '((assoc ",")) '((assoc "d|")))

      (smie-precs->prec2
       '((nonassoc "andalso")                     ;To anchor the prec-table.
         (assoc "before")                         ;0
         (assoc ":=" "o")                         ;3
         (nonassoc ">" ">=" "<>" "<" "<=" "=")    ;4
         (assoc "::" "@")                         ;5
         (assoc "+" "-" "^")                      ;6
         (assoc "/" "*" "quot" "rem" "div" "mod") ;7
         (nonassoc " -dummy- ")))                 ;Bogus anchor at the end.
      ))))

(defvar sml-indent-separator-outdent 2)

(defun sml-smie-rules (kind token)
  ;; I much preferred the pcase version of the code, especially while
  ;; edebugging the code.  But that will have to wait until we get rid of
  ;; support for Emacs-23.
  (case kind
    (:elem (case token
             (basic sml-indent-level)
             (args  sml-indent-args)))
    (:list-intro (member token '("fn")))
    (:after
     (cond
      ((equal token "struct") 0)
      ((equal token "=>") (if (smie-rule-hanging-p) 0 2))
      ((equal token "in") (if (smie-rule-parent-p "local") 0))
      ((equal token "of") 3)
      ((member token '("(" "{" "[")) (if (not (smie-rule-hanging-p)) 2))
      ((equal token "else") (if (smie-rule-hanging-p) 0)) ;; (:next "if" 0)
      ((member token '("|" "d|" ";" ",")) (smie-rule-separator kind))
      ((equal token "d=")
       (if (and (smie-rule-parent-p "val") (smie-rule-next-p "fn")) -3))))
    (:before
     (cond
      ((equal token "=>") (if (smie-rule-parent-p "fn") 3))
      ((equal token "of") 1)
      ;; In case the language is extended to allow a | directly after of.
      ((and (equal token "|") (smie-rule-prev-p "of")) 1)
      ((member token '("|" "d|" ";" ",")) (smie-rule-separator kind))
      ;; Treat purely syntactic block-constructs as being part of their parent,
      ;; when the opening statement is hanging.
      ((member token '("let" "(" "[" "{"))
       (if (smie-rule-hanging-p) (smie-rule-parent)))
      ;; Treat if ... else if ... as a single long syntactic construct.
      ;; Similarly, treat fn a => fn b => ... as a single construct.
      ((member token '("if" "fn"))
       (and (not (smie-rule-bolp))
            (smie-rule-prev-p (if (equal token "if") "else" "=>"))
            (smie-rule-parent)))
      ((equal token "and")
       ;; FIXME: maybe "and" (c|sh)ould be handled as an smie-separator.
       (cond
        ((smie-rule-parent-p "datatype") (if sml-rightalign-and 5 0))
        ((smie-rule-parent-p "fun" "val") 0)))
      ((equal token "d=")
       (cond
        ((smie-rule-parent-p "datatype") (if (smie-rule-bolp) 2))
        ((smie-rule-parent-p "structure" "signature") 0)))
      ;; Indent an expression starting with "local" as if it were starting
      ;; with "fun".
      ((equal token "local") (smie-indent-keyword "fun"))
      ;; FIXME: type/val/fun/... are separators but "local" is not, even though
      ;; it appears in the same list.  Try to fix up the problem by hand.
      ;; ((or (equal token "local")
      ;;      (equal (cdr (assoc token smie-grammar))
      ;;             (cdr (assoc "fun" smie-grammar))))
      ;;  (let ((parent (save-excursion (smie-backward-sexp))))
      ;;    (when (or (and (equal (nth 2 parent) "local")
      ;;                   (null (car parent)))
      ;;              (progn
      ;;                (setq parent (save-excursion (smie-backward-sexp "fun")))
      ;;                (eq (car parent) (nth 1 (assoc "fun" smie-grammar)))))
      ;;      (goto-char (nth 1 parent))
      ;;      (cons 'column (smie-indent-virtual)))))
      ))))

(defun sml-smie-definitional-equal-p ()
  "Figure out which kind of \"=\" this is.
Assumes point is right before the = sign."
  ;; The idea is to look backward for the first occurrence of a token that
  ;; requires a definitional "=" and then see if there's such a definitional
  ;; equal between that token and ourselves (in which case we're not
  ;; a definitional = ourselves).
  ;; The "search for =" is naive and will match "=>" and "<=", but it turns
  ;; out to be OK in practice because such tokens very rarely (if ever) appear
  ;; between the =-starter and the corresponding definitional equal.
  ;; One known problem case is code like:
  ;; "functor foo (structure s : S) where type t = s.t ="
  ;; where the "type t = s.t" is mistaken for a type definition.
  (let ((re (concat "\\(" sml-=-starter-re "\\)\\|=")))
    (save-excursion
      (and (re-search-backward re nil t)
           (or (match-beginning 1)
               ;; If we first hit a "=", then that = is probably definitional
               ;; and  we're an equality, but not necessarily.  One known
               ;; problem case is code like:
               ;; "functor foo (structure s : S) where type t = s.t ="
               ;; where the first = is more like an equality (tho it doesn't
               ;; matter much) and the second is definitional.
               ;;
               ;; FIXME: The test below could be used to recognize that the
               ;; second = is not a mere equality, but that's not enough to
               ;; parse the construct properly: we'd need something
               ;; like a third kind of = token for structure definitions, in
               ;; order for the parser to be able to skip the "type t = s.t"
               ;; as a sub-expression.
               ;;
               ;; (and (not (looking-at "=>"))
               ;;      (not (eq ?< (char-before))) ;Not a <=
               ;;      (re-search-backward re nil t)
               ;;      (match-beginning 1)
               ;;      (equal "type" (buffer-substring (- (match-end 1) 4)
               ;;                                      (match-end 1))))
               )))))

(defun sml-smie-non-nested-of-p ()
  ;; FIXME: Maybe datatype-|-p makes this nested-of business unnecessary.
  "Figure out which kind of \"of\" this is.
Assumes point is right before the \"of\" symbol."
  (save-excursion
    (and (re-search-backward (concat "\\(" sml-non-nested-of-starter-re
                                     "\\)\\|\\<case\\>") nil t)
         (match-beginning 1))))

(defun sml-smie-datatype-|-p ()
  "Figure out which kind of \"|\" this is.
Assumes point is right before the | symbol."
  (save-excursion
    (forward-char 1)                    ;Skip the |.
    (let ((after-type-def
           '("|" "of" "in" "datatype" "and" "exception" "abstype" "infix"
             "infixr" "nonfix" "local" "val" "fun" "structure" "functor"
             "signature")))
      (or (member (sml-smie-forward-token-1) after-type-def) ;Skip the tag.
          (member (sml-smie-forward-token-1) after-type-def)))))

(defun sml-smie-forward-token-1 ()
  (forward-comment (point-max))
  (buffer-substring-no-properties
   (point)
   (progn
     (or (/= 0 (skip-syntax-forward "'w_"))
         (skip-syntax-forward ".'"))
     (point))))

(defun sml-smie-forward-token ()
  (let ((sym (sml-smie-forward-token-1)))
    (cond
     ((equal "op" sym)
      (concat "op " (sml-smie-forward-token-1)))
     ((member sym '("|" "of" "="))
      ;; The important lexer for indentation's performance is the backward
      ;; lexer, so for the forward lexer we delegate to the backward one.
      (save-excursion (sml-smie-backward-token)))
     (t sym))))

(defun sml-smie-backward-token-1 ()
  (forward-comment (- (point)))
  (buffer-substring-no-properties
   (point)
   (progn
     (or (/= 0 (skip-syntax-backward ".'"))
         (skip-syntax-backward "'w_"))
     (point))))

(defun sml-smie-backward-token ()
  (let ((sym (sml-smie-backward-token-1)))
    (unless (zerop (length sym))
      ;; FIXME: what should we do if `sym' = "op" ?
      (let ((point (point)))
	(if (equal "op" (sml-smie-backward-token-1))
	    (concat "op " sym)
	  (goto-char point)
	  (cond
	   ((string= sym "=") (if (sml-smie-definitional-equal-p) "d=" "="))
	   ((string= sym "of") (if (sml-smie-non-nested-of-p) "=of" "of"))
           ((string= sym "|") (if (sml-smie-datatype-|-p) "d|" "|"))
	   (t sym)))))))

;;;;
;;;; Imenu support
;;;;

(defvar sml-imenu-regexp
  (concat "^[ \t]*\\(let[ \t]+\\)?"
	  (regexp-opt (append sml-module-head-syms
			      '("and" "fun" "datatype" "abstype" "type")) t)
	  "\\>"))

(defun sml-imenu-create-index ()
  (let (alist)
    (goto-char (point-max))
    (while (re-search-backward sml-imenu-regexp nil t)
      (save-excursion
	(let ((kind (match-string 2))
	      (column (progn (goto-char (match-beginning 2)) (current-column)))
	      (location
	       (progn (goto-char (match-end 0))
		      (forward-comment (point-max))
		      (when (looking-at sml-tyvarseq-re)
			(goto-char (match-end 0)))
		      (point)))
	      (name (sml-smie-forward-token)))
	  ;; Eliminate trivial renamings.
	  (when (or (not (member kind '("structure" "signature")))
		    (progn (search-forward "=")
			   (forward-comment (point-max))
			   (looking-at "sig\\|struct")))
	    (push (cons (concat (make-string (/ column 2) ?\ ) name) location)
		  alist)))))
    alist))

;;; MORE CODE FOR SML-MODE

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.s\\(ml\\|ig\\)\\'" . sml-mode))

(unless (fboundp 'prog-mode) (defalias 'prog-mode 'fundamental-mode))
(defvar comment-quote-nested)
(defvar electric-indent-chars)
(defvar electric-layout-rules)

;;;###autoload
(define-derived-mode sml-mode prog-mode "SML"
  "\\<sml-mode-map>Major mode for editing ML code.
This mode runs `sml-mode-hook' just before exiting.
\\{sml-mode-map}"
  (set (make-local-variable 'font-lock-defaults) sml-font-lock-defaults)
  (set (make-local-variable 'outline-regexp) sml-outline-regexp)
  (set (make-local-variable 'imenu-create-index-function)
       'sml-imenu-create-index)
  (set (make-local-variable 'add-log-current-defun-function)
       'sml-current-fun-name)
  ;; Treat paragraph-separators in comments as paragraph-separators.
  (set (make-local-variable 'paragraph-separate)
       (concat "\\([ \t]*\\*)?\\)?\\(" paragraph-separate "\\)"))
  (set (make-local-variable 'require-final-newline) t)
  (set (make-local-variable 'electric-indent-chars)
       (cons ?\; (if (boundp 'electric-indent-chars)
                     electric-indent-chars '(?\n))))
  (set (make-local-variable 'electric-layout-rules)
       `((?\; . ,(lambda ()
                   (save-excursion
                     (skip-chars-backward " \t;")
                     (unless (or (bolp)
                                 (progn (skip-chars-forward " \t;")
                                        (eolp)))
                       'after))))))
  ;; For XEmacs
  (easy-menu-add sml-mode-menu)
  ;; Compatibility.  FIXME: we should use `-' in Emacs-CVS.
  (unless (boundp 'skeleton-positions) (set (make-local-variable '@) nil))
  (sml-mode-variables))

(defun sml-mode-variables ()
  (set-syntax-table sml-mode-syntax-table)
  (setq local-abbrev-table sml-mode-abbrev-table)
  ;; Setup indentation and sexp-navigation.
  (when (fboundp 'smie-setup)
    (smie-setup sml-smie-grammar #'sml-smie-rules
                :backward-token #'sml-smie-backward-token
                :forward-token #'sml-smie-forward-token))
  (unless (and sml-use-smie (fboundp 'smie-setup))
    (set (make-local-variable 'forward-sexp-function) 'sml-user-forward-sexp)
    (set (make-local-variable 'indent-line-function) 'sml-indent-line))
  (set (make-local-variable 'parse-sexp-ignore-comments) t)
  (set (make-local-variable 'comment-start) "(* ")
  (set (make-local-variable 'comment-end) " *)")
  (set (make-local-variable 'comment-start-skip) "(\\*+\\s-*")
  (set (make-local-variable 'comment-end-skip) "\\s-*\\*+)")
  ;; No need to quote nested comments markers.
  (set (make-local-variable 'comment-quote-nested) nil))

(defun sml-funname-of-and ()
  "Name of the function this `and' defines, or nil if not a function.
Point has to be right after the `and' symbol and is not preserved."
  (forward-comment (point-max))
  (if (looking-at sml-tyvarseq-re) (goto-char (match-end 0)))
  (let ((sym (sml-smie-forward-token)))
    (forward-comment (point-max))
    (unless (or (member sym '(nil "d="))
		(member (sml-smie-forward-token) '("d=")))
      sym)))

(defun sml-find-forward (re)
  (while (progn (forward-comment (point-max))
                (not (looking-at re)))
    (or (ignore-errors (forward-sexp 1) t) (forward-char 1))))

(defun sml-electric-pipe ()
  "Insert a \"|\".
Depending on the context insert the name of function, a \"=>\" etc."
  ;; FIXME: Make it a skeleton.
  (interactive)
  (unless (save-excursion (skip-chars-backward "\t ") (bolp)) (insert "\n"))
  (insert "| ")
  (let ((text
         (save-excursion
           (backward-char 2)		;back over the just inserted "| "
           (let ((sym (sml-find-matching-starter sml-pipeheads
                                                 ;; (sml-op-prec "|" 'back)
                                                 )))
             (sml-smie-forward-token)
             (forward-comment (point-max))
             (cond
              ((string= sym "|")
               (let ((f (sml-smie-forward-token)))
                 (sml-find-forward "\\(=>\\|=\\||\\)\\S.")
                 (cond
                  ((looking-at "|") "")      ;probably a datatype
                  ((looking-at "=>") " => ") ;`case', or `fn' or `handle'
                  ((looking-at "=") (concat f "  = "))))) ;a function
              ((string= sym "and")
               ;; could be a datatype or a function
               (setq sym (sml-funname-of-and))
               (if sym (concat sym "  = ") ""))
              ;; trivial cases
              ((string= sym "fun")
               (while (and (setq sym (sml-smie-forward-token))
                           (string-match "^'" sym))
                 (forward-comment (point-max)))
               (concat sym "  = "))
              ((member sym '("case" "handle" "fn" "of")) " => ")
              ;;((member sym '("abstype" "datatype")) "")
              (t ""))))))

    (insert text)
    (indent-according-to-mode)
    (beginning-of-line)
    (skip-chars-forward "\t |")
    (skip-syntax-forward "w")
    (skip-chars-forward "\t ")
    (when (eq ?= (char-after)) (backward-char))))

(defun sml-electric-semi ()
  "Insert a \;.
If variable `sml-electric-semi-mode' is t, indent the current line, insert
a newline, and indent."
  (interactive)
  (self-insert-command 1)
  (if sml-electric-semi-mode
      (reindent-then-newline-and-indent)))

;;; Misc

(defun sml-mark-function ()
  "Mark the surrounding function.  Or try to at least."
  (interactive)
  (if (not (fboundp 'smie-setup))
      (mark-paragraph)
    ;; FIXME: Provide beginning-of-defun-function so mark-defun "just works".
    (let ((start (point)))
      (sml-beginning-of-defun)
      (let ((beg (point)))
        (smie-forward-sexp 'halfsexp)
        (if (or (< start beg) (> start (point)))
            (progn
              (goto-char start)
              (mark-paragraph))
          (push-mark nil t t)
          (goto-char beg))))))

(defun sml-back-to-outer-indent ()
  "Unindents to the next outer level of indentation."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (skip-chars-forward "\t ")
    (let ((start-column (current-column))
          (indent (current-column)))
      (if (> start-column 0)
          (progn
            (save-excursion
              (while (>= indent start-column)
                (if (re-search-backward "^[^\n]" nil t)
                    (setq indent (current-indentation))
                  (setq indent 0))))
            (backward-delete-char-untabify (- start-column indent)))))))

(defun sml-smie-find-matching-starter (syms)
  (let ((halfsexp nil)
        tok)
    ;;(sml-smie-forward-token)
    (while (not (or (bobp)
                    (member (nth 2 (setq tok (smie-backward-sexp halfsexp)))
                            syms)))
      (cond
       ((null (car tok)) nil)
       ((numberp (car tok)) (setq halfsexp 'half))
       (t (goto-char (cadr tok)))))
    (if (nth 2 tok) (goto-char (cadr tok)))
    (nth 2 tok)))

(defun sml-find-matching-starter (syms)
  (cond
   ((and sml-use-smie (fboundp 'smie-backward-sexp))
    (sml-smie-find-matching-starter syms))
   ((fboundp 'sml-old-find-matching-starter)
    (sml-old-find-matching-starter syms))))

(defun sml-smie-skip-siblings ()
  (let (tok)
    (while (and (not (bobp))
                (progn (setq tok (smie-backward-sexp 'half))
                       (cond
                        ((null (car tok)) t)
                        ((numberp (car tok)) t)
                        (t nil)))))
    (if (nth 2 tok) (goto-char (cadr tok)))
    (nth 2 tok)))

(defun sml-skip-siblings ()
  (cond
   ((and sml-use-smie (fboundp 'smie-backward-sexp))
    (sml-smie-skip-siblings))
   ((fboundp 'sml-old-skip-siblings)
    (sml-old-skip-siblings))
   (t (up-list -1))))

(defun sml-beginning-of-defun ()
  (let ((sym (sml-find-matching-starter sml-starters-syms)))
    (if (member sym '("fun" "and" "functor" "signature" "structure"
		      "abstraction" "datatype" "abstype"))
	(save-excursion (sml-smie-forward-token) (forward-comment (point-max))
			(sml-smie-forward-token))
      ;; We're inside a "non function declaration": let's skip all other
      ;; declarations that we find at the same level and try again.
      (sml-skip-siblings)
      ;; Obviously, let's not try again if we're at bobp.
      (unless (bobp) (sml-beginning-of-defun)))))

(defcustom sml-max-name-components 3
  "Maximum number of components to use for the current function name."
  :type 'integer)

(defun sml-current-fun-name ()
  (save-excursion
    (let ((count sml-max-name-components)
	  fullname name)
      (end-of-line)
      (while (and (> count 0)
		  (setq name (sml-beginning-of-defun)))
	(decf count)
	(setq fullname (if fullname (concat name "." fullname) name))
	;; Skip all other declarations that we find at the same level.
	(sml-skip-siblings))
      fullname)))


;;; INSERTING PROFORMAS (COMMON SML-FORMS)

(defvar sml-forms-alist nil
  "*Alist of code templates.
You can extend this alist to your heart's content.  For each additional
template NAME in the list, declare a keyboard macro or function (or
interactive command) called 'sml-form-NAME'.
If 'sml-form-NAME' is a function it takes no arguments and should
insert the template at point\; if this is a command it may accept any
sensible interactive call arguments\; keyboard macros can't take
arguments at all.  Apropos keyboard macros, see `name-last-kbd-macro'
and `sml-addto-forms-alist'.
`sml-forms-alist' understands let, local, case, abstype, datatype,
signature, structure, and functor by default.")

(defmacro sml-def-skeleton (name interactor &rest elements)
  (when (fboundp 'define-skeleton)
    (let ((fsym (intern (concat "sml-form-" name))))
      ;; TODO: don't do the expansion in comments and strings.
      `(progn
	 (add-to-list 'sml-forms-alist ',(cons name fsym))
	 (condition-case err
	     ;; Try to use the new `system' flag.
	     (define-abbrev sml-mode-abbrev-table ,name "" ',fsym nil 'system)
	   (wrong-number-of-arguments
	    (define-abbrev sml-mode-abbrev-table ,name "" ',fsym)))
         (when (fboundp 'abbrev-put)
           (let ((abbrev (abbrev-symbol ,name sml-mode-abbrev-table)))
             (abbrev-put abbrev :case-fixed t)
             (abbrev-put abbrev :enable-function
                         (lambda () (not (nth 8 (syntax-ppss)))))))
	 (define-skeleton ,fsym
	   ,(format "SML-mode skeleton for `%s..' expressions" name)
	   ,interactor
	   ,(concat name " ") >
	   ,@elements)))))
(put 'sml-def-skeleton 'lisp-indent-function 2)

(sml-def-skeleton "let" nil
  @ "\nin " > _ "\nend" >)

(sml-def-skeleton "if" nil
  @ " then " > _ "\nelse " > _)

(sml-def-skeleton "local" nil
  @ "\nin" > _ "\nend" >)

(sml-def-skeleton "case" "Case expr: "
  str "\nof " > _ " => ")

(sml-def-skeleton "signature" "Signature name: "
  str " =\nsig" > "\n" > _ "\nend" >)

(sml-def-skeleton "structure" "Structure name: "
  str " =\nstruct" > "\n" > _ "\nend" >)

(sml-def-skeleton "functor" "Functor name: "
  str " () : =\nstruct" > "\n" > _ "\nend" >)

(sml-def-skeleton "datatype" "Datatype name and type params: "
  str " =" \n)

(sml-def-skeleton "abstype" "Abstype name and type params: "
  str " =" \n _ "\nwith" > "\nend" >)

;;

(sml-def-skeleton "struct" nil
  _ "\nend" >)

(sml-def-skeleton "sig" nil
  _ "\nend" >)

(sml-def-skeleton "val" nil
  @ " = " > _)

(sml-def-skeleton "fn" nil
  @ " =>" > _)

(sml-def-skeleton "fun" nil
  @ " =" > _)

;;

(defun sml-forms-menu (menu)
  (mapcar (lambda (x) (vector (car x) (cdr x) t))
	  sml-forms-alist))

(defvar sml-last-form "let")

(defun sml-electric-space ()
  "Expand a symbol into an SML form, or just insert a space.
If the point directly precedes a symbol for which an SML form exists,
the corresponding form is inserted."
  (interactive)
  (let ((abbrev-mode (not abbrev-mode))
	(last-command-event ?\ )
	;; Bind `this-command' to fool skeleton's special abbrev handling.
	(this-command 'self-insert-command))
    (call-interactively 'self-insert-command)))

(defun sml-insert-form (name newline)
  "Interactive short-cut to insert the NAME common ML form.
If a prefix argument is given insert a NEWLINE and indent first, or
just move to the proper indentation if the line is blank\; otherwise
insert at point (which forces indentation to current column).

The default form to insert is 'whatever you inserted last time'
\(just hit return when prompted\)\; otherwise the command reads with
completion from `sml-forms-alist'."
  (interactive
   (list (completing-read
	  (format "Form to insert: (default %s) " sml-last-form)
	  sml-forms-alist nil t nil)
	 current-prefix-arg))
  ;; default is whatever the last insert was...
  (if (string= name "") (setq name sml-last-form) (setq sml-last-form name))
  (unless (or (not newline)
	      (save-excursion (beginning-of-line) (looking-at "\\s-*$")))
    (insert "\n"))
  (unless (/= ?w (char-syntax (preceding-char))) (insert " "))
  (let ((f (cdr (assoc name sml-forms-alist))))
    (cond
     ((commandp f) (command-execute f))
     (f (funcall f))
     (t (error "Undefined form: %s" name)))))

;; See also macros.el in emacs lisp dir.

(defun sml-addto-forms-alist (name)
  "Assign a name to the last keyboard macro defined.
Argument NAME is transmogrified to sml-form-NAME which is the symbol
actually defined.

The symbol's function definition becomes the keyboard macro string.

If that works, NAME is added to `sml-forms-alist' so you'll be able to
reinvoke the macro through \\[sml-insert-form].  You might want to save
the macro to use in a later editing session -- see `insert-kbd-macro'
and add these macros to your .emacs file.

See also `edit-kbd-macro' which is bound to \\[edit-kbd-macro]."
  (interactive "sName for last kbd macro (\"sml-form-\" will be added): ")
  (when (string= name "") (error "No command name given"))
  (let ((fsym (intern (concat "sml-form-" name))))
    (name-last-kbd-macro fsym)
    (message "Macro bound to %s" fsym)
    (add-to-list 'sml-forms-alist (cons name fsym))))

;;;
;;; MLton support
;;;

(defvar sml-mlton-command "mlton"
  "Command to run MLton.   Can include arguments.")

(defvar sml-mlton-mainfile nil)

(defconst sml-mlton-error-regexp-alist
  ;; I wish they just changed MLton to use one of the standard
  ;; error formats.
  `(("^\\(?:Error\\|\\(Warning\\)\\): \\(.+\\) \\([0-9]+\\)\\.\\([0-9]+\\)\\.$"
     2 3 4
     ;; If subgroup 1 matched, then it's a warning, otherwise it's an error.
     ,@(if (fboundp 'compilation-fake-loc) '((1))))))

(defvar compilation-error-regexp-alist)
(eval-after-load "compile"
  '(dolist (x sml-mlton-error-regexp-alist)
     (add-to-list 'compilation-error-regexp-alist x)))

(defun sml-mlton-typecheck (mainfile)
  "typecheck using MLton."
  (interactive
   (list (if (and mainfile (not current-prefix-arg))
             mainfile
           (read-file-name "Main file: "))))
  (save-some-buffers)
  (require 'compile)
  (dolist (x sml-mlton-error-regexp-alist)
    (add-to-list 'compilation-error-regexp-alist x))
  (with-current-buffer (find-file-noselect mainfile)
    (compile (concat sml-mlton-command
                     " -stop tc "       ;Stop right after type checking.
                     (shell-quote-argument
                      (file-relative-name buffer-file-name))))))

;;;
;;; MLton's def-use info.
;;;

(defvar sml-defuse-file nil)

(defun sml-defuse-file ()
  (or sml-defuse-file (sml-defuse-set-file)))

(defun sml-defuse-set-file ()
  "Specify the def-use file to use."
  (interactive)
  (setq sml-defuse-file (read-file-name "Def-use file: ")))

(defun sml-defuse-symdata-at-point ()
  (save-excursion
    (sml-smie-forward-token)
    (let ((symname (sml-smie-backward-token)))
      (if (equal symname "op")
          (save-excursion (setq symname (sml-smie-forward-token))))
      (when (string-match "op " symname)
        (setq symname (substring symname (match-end 0)))
        (forward-word)
        (forward-comment (point-max)))
      (list symname
            ;; Def-use files seem to count chars, not columns.
            ;; We hope here that they don't actually count bytes.
            ;; Also they seem to start counting at 1.
            (1+ (- (point) (progn (beginning-of-line) (point))))
            (save-restriction
              (widen) (1+ (count-lines (point-min) (point))))
            buffer-file-name))))

(defconst sml-defuse-def-regexp
  "^[[:alpha:]]+ \\([^ \n]+\\) \\(.+\\) \\([0-9]+\\)\\.\\([0-9]+\\)$")
(defconst sml-defuse-use-regexp-format "^    %s %d\\.%d $")

(defun sml-defuse-jump-to-def ()
  "Jump to the definition corresponding to the symbol at point."
  (interactive)
  (let ((symdata (sml-defuse-symdata-at-point)))
    (if (null (car symdata))
        (error "Not on a symbol")
      (with-current-buffer (find-file-noselect (sml-defuse-file))
        (goto-char (point-min))
        (unless (re-search-forward
                 (format sml-defuse-use-regexp-format
                         (concat "\\(?:"
                                 ;; May be an absolute file name.
                                 (regexp-quote (nth 3 symdata))
                                 "\\|"
                                 ;; Or a relative file name.
                                 (regexp-quote (file-relative-name
                                                (nth 3 symdata)))
                                 "\\)")
                         (nth 2 symdata)
                         (nth 1 symdata))
                 nil t)
          ;; FIXME: This is typically due to editing: any minor editing will
          ;; mess everything up.  We should try to fail more gracefully.
          (error "Def-use info not found"))
        (unless (re-search-backward sml-defuse-def-regexp nil t)
          ;; This indicates a bug in this code.
          (error "Internal failure while looking up def-use"))
        (unless (equal (match-string 1) (nth 0 symdata))
          ;; FIXME: This again is most likely due to editing.
          (error "Incoherence in the def-use info found"))
        (let ((line (string-to-number (match-string 3)))
              (char (string-to-number (match-string 4))))
          (pop-to-buffer (find-file-noselect (match-string 2)))
          (goto-char (point-min))
          (forward-line (1- line))
          (forward-char (1- char)))))))

;;;
;;; SML/NJ's Compilation Manager support
;;;

(defvar sml-cm-mode-syntax-table sml-mode-syntax-table)
(defvar sml-cm-font-lock-keywords
 `(,(concat "\\<" (regexp-opt '("library" "group" "is" "structure"
				"functor" "signature" "funsig") t)
	    "\\>")))
;;;###autoload
(add-to-list 'completion-ignored-extensions ".cm/")
;; This was used with the old compilation manager.
(add-to-list 'completion-ignored-extensions "CM/")
;;;###autoload
(add-to-list 'auto-mode-alist '("\\.cm\\'" . sml-cm-mode))
;;;###autoload
(define-derived-mode sml-cm-mode fundamental-mode "SML-CM"
  "Major mode for SML/NJ's Compilation Manager configuration files."
  (local-set-key "\C-c\C-c" 'sml-compile)
  (set (make-local-variable 'font-lock-defaults)
       '(sml-cm-font-lock-keywords nil t nil nil)))

;;;
;;; ML-Lex support
;;;

(defvar sml-lex-font-lock-keywords
  (append
   '(("^%\\sw+" . font-lock-builtin-face)
     ("^%%" . font-lock-module-def-face))
   sml-font-lock-keywords))
(defconst sml-lex-font-lock-defaults
  (cons 'sml-lex-font-lock-keywords (cdr sml-font-lock-defaults)))

;;;###autoload
(define-derived-mode sml-lex-mode sml-mode "SML-Lex"
  "Major Mode for editing ML-Lex files."
  (set (make-local-variable 'font-lock-defaults) sml-lex-font-lock-defaults))

;;;
;;; ML-Yacc support
;;;

(defface sml-yacc-bnf-face
  '((t (:foreground "darkgreen")))
  "Face used to highlight (non)terminals in `sml-yacc-mode'.")
(defvar sml-yacc-bnf-face 'sml-yacc-bnf-face)

(defcustom sml-yacc-indent-action 16
  "Indentation column of the opening paren of actions."
  :type 'integer)

(defcustom sml-yacc-indent-pipe nil
  "Indentation column of the pipe char in the BNF.
If nil, align it with `:' or with previous cases."
  :type 'integer)

(defcustom sml-yacc-indent-term nil
  "Indentation column of the (non)term part.
If nil, align it with previous cases."
  :type 'integer)

(defvar sml-yacc-font-lock-keywords
  (cons '("^\\(\\sw+\\s-*:\\|\\s-*|\\)\\(\\s-*\\sw+\\)*\\s-*\\(\\(%\\sw+\\)\\s-+\\sw+\\|\\)"
	  (0 (save-excursion
	       (save-match-data
		 (goto-char (match-beginning 0))
		 (unless (or (re-search-forward "\\<of\\>" (match-end 0) 'move)
			     (progn (forward-comment (point-max))
				    (not (looking-at "("))))
		   sml-yacc-bnf-face))))
	  (4 font-lock-builtin-face t t))
	sml-lex-font-lock-keywords))
(defconst sml-yacc-font-lock-defaults
  (cons 'sml-yacc-font-lock-keywords (cdr sml-font-lock-defaults)))

(defun sml-yacc-indent-line ()
  "Indent current line of ML-Yacc code."
  (let ((savep (> (current-column) (current-indentation)))
	(indent (max (or (ignore-errors (sml-yacc-indentation)) 0) 0)))
    (if savep
	(save-excursion (indent-line-to indent))
      (indent-line-to indent))))

(defun sml-yacc-indentation ()
  (save-excursion
    (back-to-indentation)
    (or (and (looking-at "%\\|\\(\\sw\\|\\s_\\)+\\s-*:") 0)
	(when (save-excursion
		(condition-case nil (progn (up-list -1) nil) (scan-error t)))
	  ;; We're outside an action.
	  (cond
	   ;; Special handling of indentation inside %term and %nonterm
	   ((save-excursion
	      (and (re-search-backward "^%\\(\\sw+\\)" nil t)
		   (member (match-string 1) '("term" "nonterm"))))
	    (if (numberp sml-yacc-indent-term) sml-yacc-indent-term
	      (let ((offset (if (looking-at "|") -2 0)))
		(forward-line -1)
		(looking-at "\\s-*\\(%\\sw*\\||\\)?\\s-*")
		(goto-char (match-end 0))
		(+ offset (current-column)))))
	   ((looking-at "(") sml-yacc-indent-action)
	   ((looking-at "|")
	    (if (numberp sml-yacc-indent-pipe) sml-yacc-indent-pipe
	      (backward-sexp 1)
	      (while (progn (forward-comment (- (point)))
			    (/= 0 (skip-syntax-backward "w_"))))
	      (forward-comment (- (point)))
	      (if (not (looking-at "\\s-$"))
		  (1- (current-column))
		(skip-syntax-forward " ")
		(- (current-column) 2))))))
	;; default to SML rules
        (cond
         ((and sml-use-smie (fboundp 'smie-indent-calculate))
          (smie-indent-calculate))
         ((fboundp 'sml-calculate-indentation) (sml-calculate-indentation))))))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.grm\\'" . sml-yacc-mode))
;;;###autoload
(define-derived-mode sml-yacc-mode sml-mode "SML-Yacc"
  "Major Mode for editing ML-Yacc files."
  (set (make-local-variable 'indent-line-function) 'sml-yacc-indent-line)
  (set (make-local-variable 'font-lock-defaults) sml-yacc-font-lock-defaults))

(provide 'sml-mode)

(unless (and sml-use-smie (fboundp 'smie-setup))
  (require 'sml-oldindent))

;;; sml-mode.el ends here
