;;; sml-oldindent.el --- Navigation and indentation for SML without SMIE

;; Copyright (C) 1999,2000,2004,2007,2012  Stefan Monnier <monnier@gnu.org>
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


;;; Commentary:


;;; Code:

(eval-when-compile (require 'cl))
(require 'sml-mode)

(defun sml-preproc-alist (al)
  "Expand an alist AL where keys can be lists of keys into a normal one."
  (apply #'nconc
         (mapcar (lambda (x)
                   (let ((k (car x))
                         (v (cdr x)))
                     (if (consp k)
                         (mapcar (lambda (y) (cons y v)) k)
                       (list x))))
                 al)))

(defconst sml-begin-syms
  '("let" "abstype" "local" "struct" "sig")
  "Symbols matching the `end' symbol.")

(defconst sml-begin-syms-re
  (sml-syms-re sml-begin-syms)
  "Symbols matching the `end' symbol.")

;; (defconst sml-user-begin-symbols-re
;;   (sml-syms-re '("let" "abstype" "local" "struct" "sig" "in" "with"))
;;   "Symbols matching (loosely) the `end' symbol.")

(defconst sml-sexp-head-symbols-re
  (sml-syms-re `("let" "abstype" "local" "struct" "sig" "in" "with"
                 "if" "then" "else" "case" "of" "fn" "fun" "val" "and"
                 "datatype" "type" "exception" "open" "infix" "infixr" "nonfix"
                 ,@sml-module-head-syms
                 "handle" "raise"))
  "Symbols starting an sexp.")

;; (defconst sml-not-arg-start-re
;;   (sml-syms-re '("in" "of" "end" "andalso"))
;;   "Symbols that can't be found at the head of an arg.")

;; (defconst sml-not-arg-re
;;   (sml-syms-re '("in" "of" "end" "andalso"))
;;   "Symbols that should not be confused with an arg.")

(defconst sml-indent-rule
  (sml-preproc-alist
   `(("struct" . 0)
     (,sml-module-head-syms "d=" 0)
     ("local" "in" 0)
     ;;("of" . (3 nil))
     ;;("else" . (sml-indent-level 0))
     ;;(("in" "fun" "and" "of") . (sml-indent-level nil))
     ("if" "else" 0)
     (,sml-=-starter-syms nil)
     (("abstype" "case" "datatype" "if" "then" "else" "sharing" "infix" "infixr"
       "let" "local" "nonfix" "open" "raise" "sig" "struct" "type" "val" "while"
       "do" "with" "withtype")))))

(defconst sml-delegate
  (sml-preproc-alist
   `((("of" "else" "then" "d=") . (not (sml-bolp)))
     ("in" . t)))
  "Words which might delegate indentation to their parent.")

(defcustom sml-symbol-indent
  '(("fn" . -3)
    ("of" . 1)
    ("|" . -2)
    ("," . -2)
    (";" . -2)
    ;;("in" . 1)
    ("d=" . 2))
  "Special indentation alist for some symbols.
An entry like (\"in\" . 1) indicates that a line starting with the
symbol `in' should be indented one char further to the right.
This is only used in a few specific cases, so it does not work
for all symbols and in all lines starting with the given symbol."
  :group 'sml
  :type '(repeat (cons string integer)))

(defconst sml-open-paren
  (sml-preproc-alist
   `((,(list* "with" "in" sml-begin-syms) ,sml-begin-syms-re "\\<end\\>")))
  "Symbols that should behave somewhat like opening parens.")

(defconst sml-close-paren
  `(("in" "\\<l\\(ocal\\|et\\)\\>")
    ("with" "\\<abstype\\>")
    ("withtype" "\\<\\(abs\\|data\\)type\\>")
    ("end" ,sml-begin-syms-re)
    ("then" "\\<if\\>")
    ("else" "\\<if\\>" (sml-bolp))
    ("of" "\\<case\\>")
    ("d=" nil))
  "Symbols that should behave somewhat like close parens.")

(defconst sml-agglomerate-re "\\<else[ \t]+if\\>"
  "Regexp of compound symbols (pairs of symbols to be considered as one).")

(defvar sml-internal-syntax-table
  (let ((st (make-syntax-table sml-mode-syntax-table)))
    (modify-syntax-entry ?_ "w" st)
    (modify-syntax-entry ?' "w" st)
    (modify-syntax-entry ?. "w" st)
    ;; Treating `~' as a word constituent is not quite right, but
    ;; close enough.  Think about 12.3E~2 for example.  Also `~' on its
    ;; own *is* a nonfix symbol.
    (modify-syntax-entry ?~ "w" st)
    st)
  "Syntax table used for internal sml-mode operation.")

;;; 
;;; various macros
;;; 

(defmacro sml-with-ist (&rest r)
  (let ((ost-sym (make-symbol "oldtable")))
    `(let ((,ost-sym (syntax-table))
	   (case-fold-search nil)
	   (parse-sexp-lookup-properties t)
	   (parse-sexp-ignore-comments t))
       (unwind-protect
	   (progn (set-syntax-table sml-internal-syntax-table) . ,r)
	 (set-syntax-table ,ost-sym)))))
(def-edebug-spec sml-with-ist t)

(defmacro sml-move-if (&rest body)
  (let ((pt-sym (make-symbol "point"))
	(res-sym (make-symbol "result")))
    `(let ((,pt-sym (point))
	   (,res-sym ,(cons 'progn body)))
       (unless ,res-sym (goto-char ,pt-sym))
       ,res-sym)))
(def-edebug-spec sml-move-if t)

(defmacro sml-point-after (&rest body)
  `(save-excursion
     ,@body
     (point)))
(def-edebug-spec sml-point-after t)

;;

(defvar sml-op-prec
  (sml-preproc-alist
   '(("before" . 0)
     ((":=" "o") . 3)
     ((">" ">=" "<>" "<" "<=" "=") . 4)
     (("::" "@") . 5)
     (("+" "-" "^") . 6)
     (("/" "*" "quot" "rem" "div" "mod") . 7)))
  "Alist of SML infix operators and their precedence.")

(defconst sml-syntax-prec
  (sml-preproc-alist
   `((("in" "with") . 10)
     ((";" ",") . 20)
     (("=>" "d=" "=of") . (65 . 40))
     ("|" . (47 . 30))
     (("case" "of" "fn") . 45)
     (("if" "then" "else" "while" "do" "raise") . 50)
     ("handle" . 60)
     ("orelse" . 70)
     ("andalso" . 80)
     ((":" ":>") . 90)
     ("->" . 95)
     (,(cons "end" sml-begin-syms) . 10000)))
  "Alist of pseudo-precedence of syntactic elements.")

(defun sml-op-prec (op dir)
  "Return the precedence of OP or nil if it's not an infix.
DIR should be set to BACK if you want to precedence w.r.t the left side
    and to FORW for the precedence w.r.t the right side.
This assumes that we are `looking-at' the OP."
  (when op
    (let ((sprec (cdr (assoc op sml-syntax-prec))))
      (cond
       ((consp sprec) (if (eq dir 'back) (car sprec) (cdr sprec)))
       (sprec sprec)
       (t
	(let ((prec (cdr (assoc op sml-op-prec))))
	  (when prec (+ prec 100))))))))

;;

(defun sml-forward-spaces () (forward-comment 100000))
(defun sml-backward-spaces () (forward-comment -100000))


;;
;; moving forward around matching symbols
;;

(defun sml-looking-back-at (re)
  (save-excursion
    (when (= 0 (skip-syntax-backward "w_")) (backward-char))
    (looking-at re)))

(defun sml-find-match-forward (this match)
  "Only works for word matches."
  (let ((level 1)
	(forward-sexp-function nil)
	(either (concat this "\\|" match)))
    (while (and (not (eobp)) (> level 0))
      (forward-sexp 1)
      (while (not (or (eobp) (sml-looking-back-at either)))
	(condition-case () (forward-sexp 1) (error (forward-char 1))))
      (setq level
	    (cond
	     ((sml-looking-back-at this) (1+ level))
	     ((sml-looking-back-at match) (1- level))
	     (t (error "Unbalanced")))))
    t))

(defun sml-find-match-backward (this match)
  (let ((level 1)
	(forward-sexp-function nil)
	(either (concat this "\\|" match)))
    (while (> level 0)
      (backward-sexp 1)
      (while (not (or (bobp) (looking-at either)))
	(condition-case () (backward-sexp 1) (error (backward-char 1))))
      (setq level
	    (cond
	     ((looking-at this) (1+ level))
	     ((looking-at match) (1- level))
	     (t (error "Unbalanced")))))
    t))

;;; 
;;; Read a symbol, including the special "op <sym>" case
;;; 

(defmacro sml-move-read (&rest body)
  (let ((pt-sym (make-symbol "point")))
    `(let ((,pt-sym (point)))
       ,@body
       (when (/= (point) ,pt-sym)
	 (buffer-substring-no-properties (point) ,pt-sym)))))
(def-edebug-spec sml-move-read t)

(defun sml-poly-equal-p ()
  (< (sml-point-after (re-search-backward sml-=-starter-re nil 'move))
     (sml-point-after (re-search-backward "=" nil 'move))))

(defun sml-nested-of-p ()
  (< (sml-point-after
      (re-search-backward sml-non-nested-of-starter-re nil 'move))
     (sml-point-after (re-search-backward "\\<case\\>" nil 'move))))

(defun sml-forward-sym-1 ()
  (or (/= 0 (skip-syntax-forward "'w_"))
      (/= 0 (skip-syntax-forward ".'"))))
(defun sml-forward-sym ()
  (let ((sym (sml-move-read (sml-forward-sym-1))))
    (cond
     ((equal "op" sym)
      (sml-forward-spaces)
      (concat "op " (or (sml-move-read (sml-forward-sym-1)) "")))
     ((equal sym "=")
      (save-excursion
	(sml-backward-sym-1)
	(if (sml-poly-equal-p) "=" "d=")))
     ((equal sym "of")
      (save-excursion
	(sml-backward-sym-1)
	(if (sml-nested-of-p) "of" "=of")))
     ;; ((equal sym "datatype")
     ;;  (save-excursion
     ;; 	(sml-backward-sym-1)
     ;; 	(sml-backward-spaces)
     ;; 	(if (eq (preceding-char) ?=) "=datatype" sym)))
     (t sym))))

(defun sml-backward-sym-1 ()
  (or (/= 0 (skip-syntax-backward ".'"))
      (/= 0 (skip-syntax-backward "'w_"))))
(defun sml-backward-sym ()
  (let ((sym (sml-move-read (sml-backward-sym-1))))
    (when sym
      ;; FIXME: what should we do if `sym' = "op" ?
      (let ((point (point)))
	(sml-backward-spaces)
	(if (equal "op" (sml-move-read (sml-backward-sym-1)))
	    (concat "op " sym)
	  (goto-char point)
	  (cond
	   ((string= sym "=") (if (sml-poly-equal-p) "=" "d="))
	   ((string= sym "of") (if (sml-nested-of-p) "of" "=of"))
	   ;; ((string= sym "datatype")
	   ;;  (save-excursion (sml-backward-spaces)
	   ;; 		    (if (eq (preceding-char) ?=) "=datatype" sym)))
	   (t sym)))))))
    

(defun sml-backward-sexp (prec)
  "Move one sexp backward if possible, or one char else.
Returns t if the move indeed moved through one sexp and nil if not.
PREC is the precedence currently looked for."
  (let ((parse-sexp-lookup-properties t)
	(parse-sexp-ignore-comments t))
    (sml-backward-spaces)
    (let* ((op (sml-backward-sym))
	   (op-prec (sml-op-prec op 'back))
	   match)
      (cond
       ((not op)
	(let ((point (point)))
	  (ignore-errors (let ((forward-sexp-function nil)) (backward-sexp 1)))
	  (if (/= point (point)) t (ignore-errors (backward-char 1)) nil)))
       ;; stop as soon as precedence is smaller than `prec'
       ((and prec op-prec (>= prec op-prec)) nil)
       ;; special rules for nested constructs like if..then..else
       ((and (or (not prec) (and prec op-prec))
	     (setq match (second (assoc op sml-close-paren))))
	(sml-find-match-backward (concat "\\<" op "\\>") match))
       ;; don't back over open-parens
       ((assoc op sml-open-paren) nil)
       ;; infix ops precedence
       ((and prec op-prec) (< prec op-prec))
       ;; [ prec = nil ]  a new operator, let's skip the sexps until the next
       (op-prec (while (sml-move-if (sml-backward-sexp op-prec))) t)
       ;; special symbols indicating we're getting out of a nesting level
       ((string-match sml-sexp-head-symbols-re op) nil)
       ;; if the op was not alphanum, then we still have to do the backward-sexp
       ;; this reproduces the usual backward-sexp, but it might be bogus
       ;; in this case since !@$% is a perfectly fine symbol
       (t t))))) ;(or (string-match "\\sw" op) (sml-backward-sexp prec))

(defun sml-forward-sexp (prec)
  "Moves one sexp forward if possible, or one char else.
Returns T if the move indeed moved through one sexp and NIL if not."
  (let ((parse-sexp-lookup-properties t)
	(parse-sexp-ignore-comments t))
    (sml-forward-spaces)
    (let* ((op (sml-forward-sym))
	   (op-prec (sml-op-prec op 'forw))
	   match)
      (cond
       ((not op)
	(let ((point (point)))
	  (ignore-errors (let ((forward-sexp-function nil)) (forward-sexp 1)))
	  (if (/= point (point)) t (forward-char 1) nil)))
       ;; stop as soon as precedence is smaller than `prec'
       ((and prec op-prec (>= prec op-prec)) nil)
       ;; special rules for nested constructs like if..then..else
       ((and (or (not prec) (and prec op-prec))
	     (setq match (cdr (assoc op sml-open-paren))))
	(sml-find-match-forward (first match) (second match)))
       ;; don't forw over close-parens
       ((assoc op sml-close-paren) nil)
       ;; infix ops precedence
       ((and prec op-prec) (< prec op-prec))
       ;; [ prec = nil ]  a new operator, let's skip the sexps until the next
       (op-prec (while (sml-move-if (sml-forward-sexp op-prec))) t)
       ;; special symbols indicating we're getting out of a nesting level
       ((string-match sml-sexp-head-symbols-re op) nil)
       ;; if the op was not alphanum, then we still have to do the backward-sexp
       ;; this reproduces the usual backward-sexp, but it might be bogus
       ;; in this case since !@$% is a perfectly fine symbol
       (t t))))) ;(or (string-match "\\sw" op) (sml-backward-sexp prec))

(defun sml-in-word-p ()
  (and (eq ?w (char-syntax (or (char-before) ? )))
       (eq ?w (char-syntax (or (char-after) ? )))))

(defun sml-user-backward-sexp (&optional count)
  "Like `backward-sexp' but tailored to the SML syntax."
  (interactive "p")
  (unless count (setq count 1))
  (sml-with-ist
   (let ((point (point)))
     (if (< count 0) (sml-user-forward-sexp (- count))
       (when (sml-in-word-p) (forward-word 1))
       (dotimes (i count)
	 (unless (sml-backward-sexp nil)
	   (goto-char point)
	   (error "Containing expression ends prematurely")))))))

(defun sml-user-forward-sexp (&optional count)
  "Like `forward-sexp' but tailored to the SML syntax."
  (interactive "p")
  (unless count (setq count 1))
  (sml-with-ist
   (let ((point (point)))
     (if (< count 0) (sml-user-backward-sexp (- count))
       (when (sml-in-word-p) (backward-word 1))
       (dotimes (i count)
	 (unless (sml-forward-sexp nil)
	   (goto-char point)
	   (error "Containing expression ends prematurely")))))))

;;(defun sml-forward-thing ()
;;  (if (= ?w (char-syntax (char-after))) (forward-word 1) (forward-char 1)))

(defun sml-backward-arg () (sml-backward-sexp 1000))
(defun sml-forward-arg () (sml-forward-sexp 1000))

(provide 'sml-move)

(defvar sml-rightalign-and)
(defvar sml-indent-args)
(defvar sml-indent-level)

(defun sml-indent-line ()
  "Indent current line of ML code."
  (interactive)
  (let ((savep (> (current-column) (current-indentation)))
	(indent (max (or (ignore-errors (sml-calculate-indentation)) 0) 0)))
    (if savep
	(save-excursion (indent-line-to indent))
      (indent-line-to indent))))

(defun sml-find-comment-indent ()
  (save-excursion
    (let ((depth 1))
      (while (> depth 0)
	(if (re-search-backward "(\\*\\|\\*)" nil t)
	    (cond
	     ;; FIXME: That's just a stop-gap.
	     ((eq (get-text-property (point) 'face) 'font-lock-string-face))
	     ((looking-at "*)") (incf depth))
	     ((looking-at comment-start-skip) (decf depth)))
	  (setq depth -1)))
      (if (= depth 0)
	  (1+ (current-column))
	nil))))

(defun sml-calculate-indentation ()
  (save-excursion
    (beginning-of-line) (skip-chars-forward "\t ")
    (sml-with-ist
     ;; Indentation for comments alone on a line, matches the
     ;; proper indentation of the next line.
     (when (looking-at "(\\*") (sml-forward-spaces))
     (let (data
	   (sym (save-excursion (sml-forward-sym))))
       (or
	;; Allow the user to override the indentation.
	(when (looking-at (concat ".*" (regexp-quote comment-start)
				  "[ \t]*fixindent[ \t]*"
				  (regexp-quote comment-end)))
	  (current-indentation))

	;; Continued comment.
	(and (looking-at "\\*") (sml-find-comment-indent))

	;; Continued string ? (Added 890113 lbn)
	(and (looking-at "\\\\")
             (or (save-excursion (forward-line -1)
                                 (if (looking-at "[\t ]*\\\\")
                                     (current-indentation)))
                 (save-excursion
                   (if (re-search-backward "[^\\\\]\"" nil t)
                       (1+ (current-column))
                     0))))

	;; Closing parens.  Could be handled below with `sml-indent-relative'?
	(and (looking-at "\\s)")
	     (save-excursion
	       (skip-syntax-forward ")")
	       (backward-sexp 1)
	       (if (sml-dangling-sym)
		   (sml-indent-default 'noindent)
		 (current-column))))

	(and (setq data (assoc sym sml-close-paren))
	     (sml-indent-relative sym data))

	(and (member sym sml-starters-syms)
	     (sml-indent-starter sym))

	(and (string= sym "|") (sml-indent-pipe))

	(sml-indent-arg)
	(sml-indent-default))))))

(defsubst sml-bolp ()
  (save-excursion (skip-chars-backward " \t|") (bolp)))

(defun sml-first-starter-p ()
  "Non-nil if starter at point is immediately preceded by let/local/in/..."
  (save-excursion
    (let ((sym (unless (save-excursion (sml-backward-arg))
                 (sml-backward-spaces)
                 (sml-backward-sym))))
      (if (member sym '(";" "d=")) (setq sym nil))
      sym)))

(defun sml-indent-starter (orig-sym)
  "Return the indentation to use for a symbol in `sml-starters-syms'.
Point should be just before the symbol ORIG-SYM and is not preserved."
  (let ((sym (unless (save-excursion (sml-backward-arg))
	       (sml-backward-spaces)
	       (sml-backward-sym))))
    (if (member sym '(";" "d=")) (setq sym nil))
    (if sym (sml-get-sym-indent sym)
      ;; FIXME: this can take a *long* time !!
      (setq sym (sml-old-find-matching-starter sml-starters-syms))
      (if (or (sml-first-starter-p)
              ;; Don't align with `and' because it might be specially indented.
              (and (or (equal orig-sym "and") (not (equal sym "and")))
                   (sml-bolp)))
	  (+ (current-column)
	     (if (and sml-rightalign-and (equal orig-sym "and"))
		 (- (length sym) 3) 0))
	(sml-indent-starter orig-sym)))))

(defun sml-indent-relative (sym data)
  (save-excursion
    (sml-forward-sym) (sml-backward-sexp nil)
    (unless (second data) (sml-backward-spaces) (sml-backward-sym))
    (+ (or (cdr (assoc sym sml-symbol-indent)) 0)
       (sml-delegated-indent))))

(defun sml-indent-pipe ()
  (let ((sym (sml-old-find-matching-starter sml-pipeheads
                                            (sml-op-prec "|" 'back))))
    (when sym
      (if (string= sym "|")
	  (if (sml-bolp) (current-column) (sml-indent-pipe))
	(let ((pipe-indent (or (cdr (assoc "|" sml-symbol-indent)) -2)))
	  (when (or (member sym '("datatype" "abstype"))
		    (and (equal sym "and")
			 (save-excursion
			   (forward-word 1)
			   (not (sml-funname-of-and)))))
	    (re-search-forward "="))
	  (sml-forward-sym)
	  (sml-forward-spaces)
	  (+ pipe-indent (current-column)))))))

(defun sml-indent-arg ()
  (and (save-excursion (ignore-errors (sml-forward-arg)))
       ;;(not (looking-at sml-not-arg-re))
       ;; looks like a function or an argument
       (sml-move-if (sml-backward-arg))
       ;; an argument
       (if (save-excursion (not (sml-backward-arg)))
	   ;; a first argument
	   (+ (current-column) sml-indent-args)
	 ;; not a first arg
	 (while (and (/= (current-column) (current-indentation))
		     (sml-move-if (sml-backward-arg))))
	 (unless (save-excursion (sml-backward-arg))
	   ;; all earlier args are on the same line
	   (sml-forward-arg) (sml-forward-spaces))
	 (current-column))))

(defun sml-get-indent (data sym)
  (let (d)
    (cond
     ((not (listp data)) data)
     ((setq d (member sym data)) (cadr d))
     ((and (consp data) (not (stringp (car data)))) (car data))
     (t sml-indent-level))))

(defun sml-dangling-sym ()
  "Non-nil if the symbol after point is dangling.
The symbol can be an SML symbol or an open-paren. \"Dangling\" means that
it is not on its own line but is the last element on that line."
  (save-excursion
    (and (not (sml-bolp))
	 (< (sml-point-after (end-of-line))
	    (sml-point-after (or (sml-forward-sym) (skip-syntax-forward "("))
			     (sml-forward-spaces))))))

(defun sml-delegated-indent ()
  (if (sml-dangling-sym)
      (sml-indent-default 'noindent)
    (sml-move-if (backward-word 1)
		 (looking-at sml-agglomerate-re))
    (current-column)))

(defun sml-get-sym-indent (sym &optional style)
  "Find the indentation for the SYM we're `looking-at'.
If indentation is delegated, point will move to the start of the parent.
Optional argument STYLE is currently ignored."
  (assert (equal sym (save-excursion (sml-forward-sym))))
  (save-excursion
    (let ((delegate (and (not (equal sym "end")) (assoc sym sml-close-paren)))
	  (head-sym sym))
      (when (and delegate (not (eval (third delegate))))
	;;(sml-find-match-backward sym delegate)
	(sml-forward-sym) (sml-backward-sexp nil)
	(setq head-sym
	      (if (second delegate)
		  (save-excursion (sml-forward-sym))
		(sml-backward-spaces) (sml-backward-sym))))

      (let ((idata (assoc head-sym sml-indent-rule)))
	(when idata
	  ;;(if (or style (not delegate))
	  ;; normal indentation
	  (let ((indent (sml-get-indent (cdr idata) sym)))
	    (when indent (+ (sml-delegated-indent) indent)))
	  ;; delgate indentation to the parent
	  ;;(sml-forward-sym) (sml-backward-sexp nil)
	  ;;(let* ((parent-sym (save-excursion (sml-forward-sym)))
	  ;;     (parent-indent (cdr (assoc parent-sym sml-indent-starters))))
	  ;; check the special rules
	  ;;(+ (sml-delegated-indent)
	  ;; (or (sml-get-indent (cdr indent-data) 1 'strict)
	  ;; (sml-get-indent (cdr parent-indent) 1 'strict)
	  ;; (sml-get-indent (cdr indent-data) 0)
	  ;; (sml-get-indent (cdr parent-indent) 0))))))))
	  )))))

(defun sml-indent-default (&optional noindent)
  (let* ((sym-after (save-excursion (sml-forward-sym)))
	 (_ (sml-backward-spaces))
	 (sym-before (sml-backward-sym))
	 (sym-indent (and sym-before (sml-get-sym-indent sym-before)))
	 (indent-after (or (cdr (assoc sym-after sml-symbol-indent)) 0)))
    (when (equal sym-before "end")
      ;; I don't understand what's really happening here, but when
      ;; it's `end' clearly, we need to do something special.
      (forward-word 1)
      (setq sym-before nil sym-indent nil))
    (cond
     (sym-indent
      ;; the previous sym is an indentation introducer: follow the rule
      (if noindent
	  ;;(current-column)
	  sym-indent
	(+ sym-indent indent-after)))
     ;; If we're just after a hanging open paren.
     ((and (eq (char-syntax (preceding-char)) ?\()
	   (save-excursion (backward-char) (sml-dangling-sym)))
      (backward-char)
      (sml-indent-default))
     (t
      ;; default-default
      (let* ((prec-after (sml-op-prec sym-after 'back))
	     (prec (or (sml-op-prec sym-before 'back) prec-after 100)))
	;; go back until you hit a symbol that has a lower prec than the
	;; "current one", or until you backed over a sym that has the same prec
	;; but is at the beginning of a line.
	(while (and (not (sml-bolp))
		    (while (sml-move-if (sml-backward-sexp (1- prec))))
		    (not (sml-bolp)))
	  (while (sml-move-if (sml-backward-sexp prec))))
	(if noindent
	    ;; the `noindent' case does back over an introductory symbol
	    ;; such as `fun', ...
	    (progn
	      (sml-move-if
	       (sml-backward-spaces)
	       (member (sml-backward-sym) sml-starters-syms))
	      (current-column))
	  ;; Use `indent-after' for cases such as when , or ; should be
	  ;; outdented so that their following terms are aligned.
	  (+ (if (progn
		   (if (equal sym-after ";")
		       (sml-move-if
			(sml-backward-spaces)
			(member (sml-backward-sym) sml-starters-syms)))
		   (and sym-after (not (looking-at sym-after))))
		 indent-after 0)
	     (current-column))))))))


;; maybe `|' should be set to word-syntax in our temp syntax table ?
(defun sml-current-indentation ()
  (save-excursion
    (beginning-of-line)
    (skip-chars-forward " \t|")
    (current-column)))


(defun sml-old-find-matching-starter (syms &optional prec)
  (let (sym)
    (ignore-errors
      (while
	  (progn (sml-backward-sexp prec)
		 (setq sym (save-excursion (sml-forward-sym)))
		 (not (or (member sym syms) (bobp)))))
      (if (member sym syms) sym))))

(defun sml-old-skip-siblings ()
  (while (and (not (bobp)) (sml-backward-arg))
    (sml-old-find-matching-starter sml-starters-syms))
  (when (looking-at "in\\>\\|local\\>")
    ;; Skip over `local...in' and continue.
    (forward-word 1)
    (sml-backward-sexp nil)
    (sml-old-skip-siblings)))

(provide 'sml-oldindent)

;;; sml-oldindent.el ends here
