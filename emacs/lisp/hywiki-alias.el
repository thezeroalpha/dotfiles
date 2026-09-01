;;; hywiki-alias.el --- Derived case/space aliases for HyWikiWords -*- lexical-binding: t; -*-

;; Highlight and activate case- and space-variants of existing HyWikiWords
;; without typing any aliases.  A HyWikiWord like `DataModelTesting' is split at
;; its CamelCase boundaries (Data | Model | Testing); the mode then highlights
;; any case-insensitive occurrence with optional single spaces at those
;; boundaries -- "Data Model Testing", "data model testing", "DaTa moDel
;; TESTING" -- and the Action Key (M-RET) on such a phrase jumps to the
;; `DataModelTesting' page, exactly as on the real WikiWord.  The alias set is
;; derived from your live HyWiki pages, so there is nothing to maintain.
;;
;; This is an EDITING-TIME convenience only: highlighting + Action-Key jump.
;; It does NOT feed HyWiki's data model, so backlinks, publishing, the
;; hywiki-graph, cross-file grep and completion do not see these aliases.  See
;; hywiki-alias.README.md for the full list and the rationale.
;;
;; Implementation is a thin, reversible layer over HyWiki: two pieces of advice
;; plus its own overlay pass.  Disabling the mode removes both and all overlays.
;; Off by default -- `M-x zetta-hywiki-alias-mode' to toggle.

(require 'cl-lib)

(declare-function hywiki-get-wikiword-list "hywiki")
(declare-function hywiki-active-in-current-buffer-p "hywiki")
(declare-function hywiki-word-at "hywiki")
(declare-function hywiki-maybe-highlight-references "hywiki")
(declare-function hywiki-add-referent "hywiki")
(declare-function hywiki-add-page "hywiki")
(declare-function hywiki-find-referent "hywiki")
(declare-function hywiki-word-strip-suffix "hywiki")
(declare-function hywiki-word-create-and-display "hywiki")
(declare-function hywiki-get-plural-wikiword "hywiki")
(declare-function hywiki-get-singular-wikiword "hywiki")
(defvar hywiki-allow-plurals-flag)
(defvar hywiki-word-face)
(defvar hywiki-directory)
(defvar hywiki-file-suffix)
(defvar zetta-hywiki-alias-mode)

(defgroup zetta-hywiki-alias nil
  "Derived case/space aliases for HyWikiWords."
  :group 'hyperbole-hywiki)

(defcustom zetta-hywiki-alias-min-length 1
  "Only HyWikiWords at least this many characters get a derived alias.
The default, 1, imposes no real length floor; raise it to suppress aliases
for very short page names, whose lowercase forms are the most prose-prone."
  :type 'integer :group 'zetta-hywiki-alias)

(defcustom zetta-hywiki-alias-min-segments 1
  "Minimum CamelCase segments a HyWikiWord needs to get a derived alias.
The default, 1, aliases every page including single-word ones like `Emacs',
so lowercase `emacs' is highlighted and activates.  Set to 2 to skip
single-word pages, whose case-insensitive match tends to light up prose; use
`zetta-hywiki-alias-deny-list' to exclude specific offenders either way."
  :type 'integer :group 'zetta-hywiki-alias)

(defcustom zetta-hywiki-alias-deny-list nil
  "HyWikiWords that should never get a derived alias (e.g. common phrases)."
  :type '(repeat string) :group 'zetta-hywiki-alias)

(defcustom zetta-hywiki-alias-derive-plurals t
  "Non-nil means also alias the plural/singular inflections of each page.
When set, a `Lisp' page also highlights and activates `lisps', a `Class' page
`classes', and so on, using HyWiki's own inflection rules
\(`hywiki-get-plural-wikiword' / `hywiki-get-singular-wikiword').  Both the
derived CamelCase aliases and manual `Aliases' entries are inflected, in both
directions (the plural of a singular name and the singular of a plural one).

This mirrors -- and defers to -- HyWiki's native `hywiki-allow-plurals-flag',
which HyWiki applies only to the capitalized WikiWord form (so it highlights
`Lisps' but never lowercase `lisps'); enabling this extends the same plurals
to the lowercase/spaced/hyphenated alias forms.  Because the underlying
HyWiki functions return nil when `hywiki-allow-plurals-flag' is nil, turning
HyWiki's plurals off turns these off too.  Set to nil to match an alias only
in the exact number the page name uses."
  :type 'boolean :group 'zetta-hywiki-alias)

(defcustom zetta-hywiki-alias-wikify-key "C-c W"
  "Key globally bound to `zetta-hywiki-alias-wikify', or nil for no binding.
A `keymap-set'-style string such as \"C-c W\".  Set it through Customize (which
moves the binding for you) or `setq' it before this module loads; the module
installs the binding once at load time.  Set to nil to leave the command
reachable only via \\[execute-extended-command]."
  :type '(choice (const :tag "No binding" nil) (string :tag "Key"))
  :set (lambda (sym val)
         (when (and (boundp sym) (symbol-value sym))
           (ignore-errors (keymap-global-unset (symbol-value sym) t)))
         (set-default sym val)
         (when val (keymap-global-set val #'zetta-hywiki-alias-wikify)))
  :group 'zetta-hywiki-alias)

(defvar zetta-hywiki-alias--index nil
  "Hash mapping a downcased, space-stripped alias form to its WikiWord(s).
The value is the LIST of canonical WikiWords that share the alias, sorted for
a stable representative; more than one entry means the alias is ambiguous and
the choice between pages is made at activation time.")
(defvar zetta-hywiki-alias--regexp nil
  "Cached alternation regexp matching every derived alias form.")
(defvar zetta-hywiki-alias--generation 0
  "Counter bumped whenever the alias set changes.
Part of the `post-command' refresh-guard key, so adding a HyWikiWord forces
the next command to re-scan even when buffer text and scroll are unchanged.")

(defun zetta-hywiki-alias--segments (word)
  "Split WORD at CamelCase boundaries into a list of segments.
Handles acronym runs, so \"HTMLParser\" -> (\"HTML\" \"Parser\")."
  (let* ((case-fold-search nil)
         (s (replace-regexp-in-string
             "\\([[:upper:]]\\)\\([[:upper:]][[:lower:]]\\)" "\\1\0\\2" word))
         (s (replace-regexp-in-string
             "\\([[:lower:][:digit:]]\\)\\([[:upper:]]\\)" "\\1\0\\2" s)))
    (split-string s "\0" t)))

(defun zetta-hywiki-alias--page-file (word)
  "Return WORD's readable HyWiki page file, or nil."
  (when (and (boundp 'hywiki-directory) hywiki-directory)
    (let ((f (expand-file-name
              (concat word (if (boundp 'hywiki-file-suffix) hywiki-file-suffix ".org"))
              hywiki-directory)))
      (and (file-readable-p f) f))))

(defun zetta-hywiki-alias--hywiki-page-file-p (file)
  "Return non-nil if FILE is a HyWiki page file directly under `hywiki-directory'."
  (and file (boundp 'hywiki-directory) hywiki-directory
       (let ((f (expand-file-name file))
             (dir (file-name-as-directory (expand-file-name hywiki-directory)))
             (suffix (if (boundp 'hywiki-file-suffix) hywiki-file-suffix ".org")))
         (and (string-suffix-p suffix f)
              (equal (file-name-directory f) dir)))))

(defun zetta-hywiki-alias--file-aliases (word)
  "Return the manual alias strings declared in WORD's page `Aliases' section.
Reads WORD's page file and collects each entry beneath a heading whose title
is `Aliases' (any level, case-insensitive), up to the next heading.  Leading
list bullets are stripped; blank lines and Org keyword/comment lines (`#...')
are ignored."
  (let ((file (zetta-hywiki-alias--page-file word)))
    (when file
      (with-temp-buffer
        (insert-file-contents file)
        (goto-char (point-min))
        (let ((case-fold-search t) aliases)
          (when (re-search-forward "^\\*+[ \t]+aliases[ \t]*$" nil t)
            (forward-line 1)
            (while (and (not (eobp)) (not (looking-at-p "^\\*+[ \t]")))
              (let ((line (string-trim (buffer-substring-no-properties
                                        (line-beginning-position)
                                        (line-end-position)))))
                (setq line (replace-regexp-in-string
                            "\\`\\(?:[-+*]\\|[0-9]+[.)]\\)[ \t]+" "" line))
                (when (and (not (string-empty-p line))
                           (not (string-prefix-p "#" line)))
                  (push line aliases)))
              (forward-line 1)))
          (nreverse aliases))))))

(defun zetta-hywiki-alias--add (index canon tokens)
  "Add an alias built from TOKENS -> CANON to INDEX and return its regexp.
TOKENS is the ordered list of word pieces; in text they may be joined, or
separated by a single space/tab or hyphen.  INDEX maps each alias key to the
LIST of canonical WikiWords that claim it, so when several pages share an
alias (e.g. two people both aliased `programmer') every page is kept and
offered at activation time instead of one silently clobbering the other.
CANON is appended when not already present.  Returns nil for empty TOKENS."
  (when tokens
    (let* ((key (downcase (apply #'concat tokens)))
           (existing (gethash key index)))
      (unless (member canon existing)
        (puthash key (append existing (list canon)) index)))
    (mapconcat #'regexp-quote tokens "[ \t-]?")))

(defun zetta-hywiki-alias--number-variants (s)
  "Return plural/singular inflections of S that differ from it, else nil.
Reuses HyWiki's own inflection rules so a lowercase or spaced alias
pluralizes exactly as HyWiki pluralizes the WikiWord itself -- e.g. a `Lisp'
page also lights up `lisps', and a `Class' page `classes'.  Both directions
are produced (plural of a singular name, singular of a plural name), matching
HyWiki's bidirectional plural handling.

HyWiki's singularizer strips a whole `-es' from sibilant endings, which is
right for `Boxes'->`Box' but wrong for the many plurals whose stem ends in a
silent `e' (`Houses'->`Hous', `Pages' left unchanged).  So when S looks
plural we ALSO offer the naive strip-one-trailing-s singular, which recovers
`House'/`Page'/`Case'; any bogus extra (`hous') is inert since it never
occurs in prose.

Honoured only when `zetta-hywiki-alias-derive-plurals' is non-nil; the HyWiki
functions additionally return their input unchanged unless
`hywiki-allow-plurals-flag' is set, so this quietly follows HyWiki's own
plural setting."
  (when zetta-hywiki-alias-derive-plurals
    (let (variants)
      (cl-flet ((add (v)
                  (when (and (stringp v) (not (string-empty-p v))
                             (not (equal v s)) (not (member v variants)))
                    (push v variants))))
        ;; HyWiki's own inflectors, in both directions.
        (dolist (fn '(hywiki-get-plural-wikiword hywiki-get-singular-wikiword))
          (when (fboundp fn) (add (funcall fn s))))
        ;; Naive singular for plural-looking names, to cover the `-se' plurals
        ;; HyWiki's `-es' rule mishandles.  Skip `-ss' endings (`Class') and
        ;; `emacs', and require a non-trivial stem.
        (let ((low (downcase s)))
          (when (and (> (length s) 3)
                     (string-suffix-p "s" low)
                     (not (string-suffix-p "ss" low))
                     (not (equal low "emacs")))
            (add (substring s 0 -1)))))
      (nreverse variants))))

(defun zetta-hywiki-alias--rebuild ()
  "Rebuild the alias index and matching regexp from existing HyWikiWords.
Includes both aliases derived from each WikiWord's CamelCase segments and any
manual aliases listed in a page's `Aliases' section."
  (let ((index (make-hash-table :test 'equal))
        (patterns nil))
    (dolist (word (and (fboundp 'hywiki-get-wikiword-list)
                       (hywiki-get-wikiword-list)))
      (when (stringp word)
        ;; Derived aliases: case/space/hyphen variants of the CamelCase segments.
        (let ((segs (zetta-hywiki-alias--segments word)))
          (when (and (>= (length segs) zetta-hywiki-alias-min-segments)
                     (>= (length word) zetta-hywiki-alias-min-length)
                     (not (member word zetta-hywiki-alias-deny-list)))
            (push (zetta-hywiki-alias--add index word segs) patterns)
            ;; ...and the same variants for its plural/singular inflections.
            (dolist (variant (zetta-hywiki-alias--number-variants word))
              (push (zetta-hywiki-alias--add
                     index word (zetta-hywiki-alias--segments variant))
                    patterns))))
        ;; Manual aliases from the page's `Aliases' section (always honoured),
        ;; each inflected the same way.
        (dolist (alias (zetta-hywiki-alias--file-aliases word))
          (push (zetta-hywiki-alias--add index word (split-string alias "[ \t-]+" t))
                patterns)
          (dolist (variant (zetta-hywiki-alias--number-variants alias))
            (push (zetta-hywiki-alias--add
                   index word (split-string variant "[ \t-]+" t))
                  patterns)))))
    ;; Collision-shared aliases push identical patterns; keep the regexp tidy.
    (setq patterns (delete-dups (delq nil patterns)))
    ;; Longer phrases first so a short alias cannot pre-empt a longer one.
    (setq patterns (sort patterns (lambda (a b) (> (length a) (length b)))))
    ;; Sort each key's candidate list so the representative (and the activation
    ;; prompt's default) is stable rather than hash-iteration order.
    (maphash (lambda (k v) (puthash k (sort v #'string<) index)) index)
    (setq zetta-hywiki-alias--index index
          zetta-hywiki-alias--regexp
          (and patterns
               (concat "\\b\\(?:" (mapconcat #'identity patterns "\\|") "\\)\\b")))))

(defun zetta-hywiki-alias--ensure ()
  "Build the index and regexp if they are not current."
  (unless zetta-hywiki-alias--index (zetta-hywiki-alias--rebuild)))

(defun zetta-hywiki-alias--invalidate (&rest _)
  "Rebuild-on-demand the alias set and re-highlight all visible windows.
Advised onto the HyWikiWord-adding commands so a newly created word's derived
aliases appear immediately.  Drop the cached index/regexp, bump the generation
counter (part of the `post-command' change-guard key, so a scroll-free,
edit-free buffer still re-scans on its next command), and refresh every visible
window now -- creating a WikiWord moves focus to the new page buffer, so the
buffer holding the alias occurrences is usually no longer the selected window."
  (setq zetta-hywiki-alias--index nil
        zetta-hywiki-alias--regexp nil)
  (cl-incf zetta-hywiki-alias--generation)
  (when (bound-and-true-p zetta-hywiki-alias-mode)
    (zetta-hywiki-alias--refresh-windows)))

(defun zetta-hywiki-alias--hywiki-face-at (pos)
  "Return non-nil if a HyWiki highlight overlay already covers POS."
  (seq-find (lambda (o) (eq (overlay-get o 'face) hywiki-word-face))
            (overlays-at pos)))

(defun zetta-hywiki-alias--link-color-at (pos)
  "Return a clickable link's colour at POS, or nil when POS is not a link.
Used to underline a WikiWord that is also a link in the link's own colour, so
it reads as both.  Recognises `shr'/eww links and `button' buttons."
  (cond
   ((and (get-text-property pos 'shr-url) (facep 'shr-link))
    (face-attribute 'shr-link :foreground nil t))
   ((and (get-text-property pos 'button) (facep 'button))
    (face-attribute 'button :foreground nil t))))

(defun zetta-hywiki-alias--hyphen-bounded-p (mb me)
  "Return non-nil if [MB, ME) is joined by a hyphen to another word.
This skips an alias that is only part of a larger hyphenated token -- e.g.
`emacs' inside `emacs-foobar' -- while still allowing a hyphen that lies
between the WikiWord's own segments, since that hyphen is consumed inside the
match rather than sitting at its edge."
  (cl-flet ((wordish (c) (and c (eq ?w (char-syntax c)))))
    (or (and (eq (char-after me) ?-) (wordish (char-after (1+ me))))
        (and (eq (char-before mb) ?-) (wordish (char-before (1- mb)))))))

(defun zetta-hywiki-alias--highlight-region (start end)
  "Highlight derived HyWikiWord aliases between START and END."
  (zetta-hywiki-alias--ensure)
  (when zetta-hywiki-alias--regexp
    (remove-overlays start end 'zetta-hywiki-alias-p t)
    (save-excursion
      (goto-char start)
      (let ((case-fold-search t))
        (while (re-search-forward zetta-hywiki-alias--regexp end t)
          (let* ((mb (match-beginning 0))
                 (me (match-end 0))
                 (text (match-string-no-properties 0))
                 (key (downcase (replace-regexp-in-string "[ \t-]+" "" text)))
                 (cands (gethash key zetta-hywiki-alias--index))
                 (canon (car cands))
                 (link-color (zetta-hywiki-alias--link-color-at mb))
                 (hy-ov (zetta-hywiki-alias--hywiki-face-at mb))
                 ;; Does a HyWiki overlay already span our whole match?  If so it
                 ;; owns the exact WikiWord and we defer.  If it covers only a
                 ;; sub-part -- e.g. `Emacs' inside a longer `Emacs Completion'
                 ;; whose joined form is the page `EmacsCompletion' -- we take
                 ;; over so the longest (composite) WikiWord wins as one unit.
                 (hy-covers-all (and hy-ov (>= (overlay-end hy-ov) me))))
            (when (and canon
                       ;; Not merely part of a larger hyphenated token: catch
                       ;; `emacs-completion' (EmacsCompletion) but not `emacs'
                       ;; inside `emacs-foobar'.
                       (not (zetta-hywiki-alias--hyphen-bounded-p mb me))
                       ;; Defer only to a HyWiki overlay that already covers the
                       ;; whole match; on a link we still layer on for the cue.
                       ;; Elsewhere -- HyWiki idle (eww), a spot it skipped, or a
                       ;; composite it split -- we highlight the match ourselves.
                       (or link-color (not hy-covers-all)))
              ;; Composite override: drop any HyWiki sub-part overlays inside our
              ;; span so the composite shows and activates as a single WikiWord.
              (unless hy-covers-all
                (dolist (o (overlays-in mb me))
                  (when (eq (overlay-get o 'face) hywiki-word-face)
                    (delete-overlay o))))
              (let ((ov (make-overlay mb me)))
                (overlay-put ov 'zetta-hywiki-alias canon)
                (overlay-put ov 'zetta-hywiki-alias-candidates cands)
                (overlay-put ov 'zetta-hywiki-alias-p t)
                ;; A DISTINCT (anonymous) face -- looks identical to
                ;; `hywiki-word-face' but is not `eq' to it, so HyWiki's own
                ;; per-command dehighlight (which clears overlays *by* that face
                ;; value) does not sweep our alias overlays away.  On a link, add
                ;; the link's own colour as the underline and sit above HyWiki's
                ;; overlay, so the word reads as both a WikiWord (orange text)
                ;; and a clickable link (coloured underline).
                (overlay-put ov 'face
                             (if link-color
                                 (list :inherit hywiki-word-face :underline link-color)
                               (list :inherit hywiki-word-face)))
                (when link-color (overlay-put ov 'priority 100))
                (overlay-put ov 'evaporate t)
                (overlay-put ov 'help-echo
                             (cond
                              ((cdr cands)
                               (format "HyWiki alias -> %s (choose on activation)"
                                       (mapconcat #'identity cands " | ")))
                              ((string= text canon)
                               (format "HyWikiWord: %s" canon))
                              (t
                               (format "HyWiki alias -> %s" canon))))))))))))

(defun zetta-hywiki-alias--refresh-region (start end)
  "Re-highlight derived aliases between START and END, expanded to whole lines."
  (zetta-hywiki-alias--highlight-region
   (save-excursion (goto-char start) (line-beginning-position))
   (save-excursion (goto-char (min end (point-max))) (line-end-position))))

(defvar-local zetta-hywiki-alias--last nil
  "Cache key (tick window-start window-end) of the last visible-region refresh.
Skips redundant rescans so `post-command-hook' stays cheap and flicker-free.")

(defun zetta-hywiki-alias--post-command ()
  "Refresh alias highlighting in the selected window's visible region.
Driven off `post-command-hook' so highlights appear promptly and survive
HyWiki's own per-command dehighlight passes.  Only rescans when the buffer
was modified or the window scrolled since the last refresh."
  (when (and (bound-and-true-p zetta-hywiki-alias-mode)
             (fboundp 'hywiki-active-in-current-buffer-p)
             (hywiki-active-in-current-buffer-p))
    (let* ((win (selected-window))
           (ws (window-start win))
           (we (window-end win t))
           (key (list zetta-hywiki-alias--generation
                      (buffer-chars-modified-tick) ws we)))
      (unless (equal key zetta-hywiki-alias--last)
        (setq zetta-hywiki-alias--last key)
        (zetta-hywiki-alias--refresh-region ws we)))))

(defun zetta-hywiki-alias--refresh-window (win)
  "Re-highlight derived aliases in WIN's visible region.
Highlights WIN by its own bounds rather than via the selected window, so a
visible but unselected window -- e.g. the buffer you were editing after focus
moved to a freshly created page -- is refreshed too."
  (with-current-buffer (window-buffer win)
    (when (and (fboundp 'hywiki-active-in-current-buffer-p)
               (hywiki-active-in-current-buffer-p))
      (let ((ws (window-start win))
            (we (window-end win t)))
        ;; Record the guard key so the buffer's own next `post-command' pass
        ;; skips a redundant (flicker-inducing) rescan when it regains focus.
        (setq zetta-hywiki-alias--last
              (list zetta-hywiki-alias--generation
                    (buffer-chars-modified-tick) ws we))
        (zetta-hywiki-alias--refresh-region ws we)))))

(defun zetta-hywiki-alias--refresh-windows ()
  "Force an alias refresh in every visible window on every frame.
Used on mode enable and whenever the alias set changes."
  (walk-windows #'zetta-hywiki-alias--refresh-window nil t))

(defun zetta-hywiki-alias--word-at-advice (orig &optional range-flag hash-sign-only-flag)
  "Make `hywiki-word-at' recognise a derived alias at point.
When point is on an alias overlay, return its canonical WikiWord -- as a
\(WORD START END) list when RANGE-FLAG is set; otherwise defer to ORIG."
  (let ((canon (and (bound-and-true-p zetta-hywiki-alias-mode)
                    (get-char-property (point) 'zetta-hywiki-alias))))
    (if canon
        (if range-flag
            (let ((ov (seq-find (lambda (o) (overlay-get o 'zetta-hywiki-alias))
                                (overlays-at (point)))))
              (list canon (and ov (overlay-start ov)) (and ov (overlay-end ov))))
          canon)
      (funcall orig range-flag hash-sign-only-flag))))

(defun zetta-hywiki-alias--find-referent-advice (orig &optional wikiword prompt-flag)
  "Disambiguate when the alias at point maps to several HyWiki pages.
`hywiki-find-referent' is the single navigation chokepoint every activation
path funnels through -- both the `hywiki-word' and `hywiki-existing-word'
implicit buttons and the Org `hy:' link -- and unlike `hywiki-word-at' it is
not called during highlighting, range detection or idle passes, so it is the
one safe place to prompt.

When point sits on an alias overlay whose candidate list holds more than one
canonical WikiWord -- e.g. `programmer' declared by both CharlieHolland and
CharlieBaker -- and ORIG is about to visit the silently chosen representative
\(WIKIWORD), ask which page to open and route ORIG there instead.  Every
other call -- a real WikiWord, a single-candidate alias, or an unrelated
navigation while point happens to rest on an alias -- passes straight
through, guarded by matching WIKIWORD against the overlay's representative."
  (let* ((ov (and (bound-and-true-p zetta-hywiki-alias-mode)
                  (stringp wikiword)
                  (seq-find (lambda (o) (overlay-get o 'zetta-hywiki-alias-candidates))
                            (overlays-at (point)))))
         (cands (and ov (overlay-get ov 'zetta-hywiki-alias-candidates))))
    (if (and cands (cdr cands)
             (fboundp 'hywiki-word-strip-suffix)
             (equal (hywiki-word-strip-suffix wikiword)
                    (overlay-get ov 'zetta-hywiki-alias)))
        (let ((choice (completing-read
                       (format "Alias \"%s\" -> HyWikiWord: "
                               (buffer-substring-no-properties
                                (overlay-start ov) (overlay-end ov)))
                       cands nil t nil nil (car cands))))
          (funcall orig choice prompt-flag))
      (funcall orig wikiword prompt-flag))))

(defun zetta-hywiki-alias--refresh-on-save ()
  "Rebuild aliases and re-highlight after saving a HyWiki page file.
On `after-save-hook' so edits to a page's `Aliases' section (or a new page
saved to disk) take effect at once, without a manual refresh."
  (when (and (bound-and-true-p zetta-hywiki-alias-mode)
             (zetta-hywiki-alias--hywiki-page-file-p buffer-file-name))
    (zetta-hywiki-alias--invalidate)))

(defun zetta-hywiki-alias--rehighlight-hywiki ()
  "Re-run HyWiki's own WikiWord highlighting in every visible window.
Called on disable so toggling the mode off is a clean A/B against HyWiki's
native behaviour -- restoring its view even where we had replaced its overlays
\(e.g. composites in eww, which HyWiki never re-scans on its own)."
  (when (fboundp 'hywiki-maybe-highlight-references)
    (walk-windows
     (lambda (win)
       (with-current-buffer (window-buffer win)
         (when (and (fboundp 'hywiki-active-in-current-buffer-p)
                    (hywiki-active-in-current-buffer-p))
           (ignore-errors (hywiki-maybe-highlight-references)))))
     nil t)))

;;; ------------------------------------------------------------------------
;;; Creating a HyWikiWord from arbitrary text (the inverse of aliasing)
;;; ------------------------------------------------------------------------

(defun zetta-hywiki-alias-to-wikiword (text)
  "Convert TEXT into a PascalCase HyWikiWord string, or nil if impossible.
This is the inverse of the aliasing this mode performs: it collapses any of
the manifestations the aliases would match back into one canonical WikiWord.

Every run of non-alphabetic characters -- spaces, tabs, newlines, hyphens,
underscores, digits, punctuation -- separates words, and existing CamelCase
inside a run of letters is split too (reusing `zetta-hywiki-alias--segments',
the very splitter the aliases are built from).  So `text embedding',
`text-embedding', `text_embedding', `TEXT EMBEDDING' and `textEmbedding' all
yield `TextEmbedding'.  Each segment is then capitalized -- first letter
upper, rest lower -- so acronyms are title-cased (`HTML parser' ->
`HtmlParser'); that still round-trips because the aliases match
case-insensitively.

Returns nil when TEXT has no letters, or yields only a single letter, since a
HyWikiWord must be an uppercase-initial, all-alphabetic word of at least two
characters.  Digits cannot appear in a HyWikiWord, so they act purely as
separators (`gpt 4 turbo' -> `GptTurbo')."
  (when (stringp text)
    (let* ((words (split-string text "[^[:alpha:]]+" t))
           (segs (mapcan #'zetta-hywiki-alias--segments words))
           (word (mapconcat
                  (lambda (w) (concat (upcase (substring w 0 1))
                                      (downcase (substring w 1))))
                  segs "")))
      (and (string-match-p "\\`[[:upper:]][[:alpha:]]+\\'" word) word))))

;;;###autoload
(defun zetta-hywiki-alias-wikify (beg end &optional stay)
  "Create a HyWikiWord page from the region BEG..END, display it, keep the text.
Interactively, act on the active region; with none, use the symbol at point.
The text is converted to a PascalCase WikiWord via
`zetta-hywiki-alias-to-wikiword', its page is created and shown, but the prose
is left UNCHANGED: this mode immediately highlights it as an alias of the new
page, so `text embedding' lights up and activates in place -- without being
rewritten to the literal `TextEmbedding'.

With a prefix arg STAY, create the page without leaving the current buffer.
Signals a `user-error' if the text cannot form a valid WikiWord or if HyWiki
is unavailable.  Returns the WikiWord."
  (interactive
   (append (cond ((use-region-p) (list (region-beginning) (region-end)))
                 ((bounds-of-thing-at-point 'symbol)
                  (let ((b (bounds-of-thing-at-point 'symbol)))
                    (list (car b) (cdr b))))
                 (t (user-error "No region or symbol at point to wikify")))
           (list current-prefix-arg)))
  (unless (require 'hywiki nil t)
    (user-error "Load GNU Hyperbole/HyWiki before using %s"
                'zetta-hywiki-alias-wikify))
  (let* ((text (buffer-substring-no-properties beg end))
         (word (zetta-hywiki-alias-to-wikiword text))
         (src (current-buffer)))
    (unless word
      (user-error "Cannot form a HyWikiWord from %S" text))
    ;; Create the page -- and by default open it -- but leave the prose alone.
    (if stay
        (hywiki-add-page word)
      (hywiki-word-create-and-display word))
    ;; Make the new page's aliases live and light up the source phrase now.
    ;; `hywiki-add-page' invalidates the alias set via advice, but
    ;; `hywiki-word-create-and-display' can reach the page by another route, so
    ;; invalidate explicitly -- rebuilding the index to include the new page --
    ;; then re-highlight the source region, which may no longer be in a visible
    ;; window now that the page is displayed (so the generic refresh misses it).
    (when (bound-and-true-p zetta-hywiki-alias-mode)
      (zetta-hywiki-alias--invalidate)
      (when (buffer-live-p src)
        (with-current-buffer src
          (when (and (fboundp 'hywiki-active-in-current-buffer-p)
                     (hywiki-active-in-current-buffer-p))
            (zetta-hywiki-alias--refresh-region beg end)))))
    (when (called-interactively-p 'interactive)
      (message "HyWikiWord %s: page created%s, source text left in place"
               word (if stay "" " and opened")))
    word))

;;;###autoload
(define-minor-mode zetta-hywiki-alias-mode
  "Global mode: highlight and activate case/space/hyphen variants of HyWikiWords.
Aliases are derived from your existing HyWiki pages, plus any listed in a page's
`Aliases' section; see hywiki-alias.README.md for details.

This is the toggle between this module and HyWiki's native behaviour: turn it on
\(\\[zetta-hywiki-alias-mode]) for aliasing and composite handling, or off to
fall back to plain HyWiki -- disabling restores HyWiki's own highlighting in the
visible buffers."
  :global t
  :group 'zetta-hywiki-alias
  (if zetta-hywiki-alias-mode
      (if (not (require 'hywiki nil t))
          (progn
            (setq zetta-hywiki-alias-mode nil)
            (user-error "Load GNU Hyperbole/HyWiki before enabling %s"
                        'zetta-hywiki-alias-mode))
        (zetta-hywiki-alias--rebuild)
        (advice-add 'hywiki-word-at :around #'zetta-hywiki-alias--word-at-advice)
        (advice-add 'hywiki-find-referent :around
                    #'zetta-hywiki-alias--find-referent-advice)
        (advice-add 'hywiki-add-referent :after #'zetta-hywiki-alias--invalidate)
        (advice-add 'hywiki-add-page :after #'zetta-hywiki-alias--invalidate)
        (add-hook 'post-command-hook #'zetta-hywiki-alias--post-command)
        (add-hook 'after-save-hook #'zetta-hywiki-alias--refresh-on-save)
        (zetta-hywiki-alias--refresh-windows))
    (remove-hook 'post-command-hook #'zetta-hywiki-alias--post-command)
    (remove-hook 'after-save-hook #'zetta-hywiki-alias--refresh-on-save)
    (advice-remove 'hywiki-word-at #'zetta-hywiki-alias--word-at-advice)
    (advice-remove 'hywiki-find-referent #'zetta-hywiki-alias--find-referent-advice)
    (advice-remove 'hywiki-add-referent #'zetta-hywiki-alias--invalidate)
    (advice-remove 'hywiki-add-page #'zetta-hywiki-alias--invalidate)
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (remove-overlays (point-min) (point-max) 'zetta-hywiki-alias-p t)))
    (zetta-hywiki-alias--invalidate)
    ;; Restore HyWiki's native highlighting in visible buffers so toggling off
    ;; is a clean A/B against HyWiki's own behaviour.
    (zetta-hywiki-alias--rehighlight-hywiki)))

;; Enable automatically once HyWiki is available.  This file loads at startup,
;; before Hyperbole's deferred load, so the mode turns on as soon as HyWiki
;; provides.  Toggle it off any time with `M-x zetta-hywiki-alias-mode'.
;;(with-eval-after-load 'hywiki
  ;;(zetta-hywiki-alias-mode 1))

(provide 'hywiki-alias)
;;; hywiki-alias.el ends here
