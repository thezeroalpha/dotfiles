;;; slovak-qwerty.el --- Slovak QWERTY quail input method
;;;
;;; Commentary:
;;; The default Slovak input method is QWERTZ, this provides QWERTY.
;;;
;;; Code:
(require 'quail)

(quail-define-package
 "slovak-qwerty" "Slovak" "SK" t
 "Standard Slovak Qwerty keyboard."
 nil t nil nil t nil nil nil nil nil t)

(quail-define-rules
 ("1" ?+)
 ("2" ?ľ)
 ("3" ?š)
 ("4" ?č)
 ("5" ?ť)
 ("6" ?ž)
 ("7" ?ý)
 ("8" ?á)
 ("9" ?í)
 ("0" ?é)
 ("!" ?1)
 ("@" ?2)
 ("#" ?3)
 ("$" ?4)
 ("%" ?5)
 ("^" ?6)
 ("&" ?7)
 ("*" ?8)
 ("(" ?9)
 (")" ?0)
 ("-" ?=)
 ("_" ?%)
 ("=" ?')
 ("[" ?ú)
 ("{" ?/)
 ("]" ?ä)
 ("}" ?\()
 ("\\" ?ň)
 ("|" ?\))
 (";" ?ô)
 (":" ?\")
 ("'" ?§)
 ("\"" ?!)
 ("<" ??)
 (">" ?:)
 ("/" ?-)
 ("?" ?_)
 ("`" ?\;)
 ("~" ?^)
 ("~~" ?~)
 ("y" ?y)
 ("z" ?z)
 ("Y" ?Y)
 ("Z" ?Z)
 ("=a" ?á)
 ("+a" ?ä)
 ("+=a" ?ä)
 ("+c" ?č)
 ("+d" ?ď)
 ("=e" ?é)
 ("+e" ?ě)
 ("=i" ?í)
 ("=l" ?ĺ)
 ("+l" ?ľ)
 ("+n" ?ň)
 ("=o" ?ó)
 ("+o" ?ô)
 ("~o" ?ô)
 ("+=o" ?ö)
 ("=r" ?ŕ)
 ("+r" ?ř)
 ("=s" ?ß)
 ("+s" ?š)
 ("+t" ?ť)
 ("=u" ?ú)
 ("+u" ?ů)
 ("+=u" ?ü)
 ("=y" ?ý)
 ("+z" ?ž)
 ("=A" ?Á)
 ("+A" ?Ä)
 ("+=A" ?Ä)
 ("+C" ?Č)
 ("+D" ?Ď)
 ("=E" ?É)
 ("+E" ?Ě)
 ("=I" ?Í)
 ("=L" ?Ĺ)
 ("+L" ?Ľ)
 ("+N" ?Ň)
 ("=O" ?Ó)
 ("+O" ?Ô)
 ("~O" ?Ô)
 ("+=O" ?Ö)
 ("=R" ?Ŕ)
 ("+R" ?Ř)
 ("=S" ?ß)
 ("+S" ?Š)
 ("+T" ?Ť)
 ("=U" ?Ú)
 ("+U" ?Ů)
 ("+=U" ?Ü)
 ("=Z" ?Ź)
 ("+Z" ?Ž)
 ("=Y" ?Ý)
 ("+Y" ?Y)
 ("=q" ?`)
 ("=2" ?@)
 ("=3" ?#)
 ("=4" ?$)
 ("=5" ?%)
 ("=6" ?^)
 ("=7" ?&)
 ("=8" ?*)
 ("=9" ?\()
 ("=0" ?\))
 ("+1" ?!)
 ("+2" ?@)
 ("+3" ?#)
 ("+4" ?$)
 ("+5" ?%)
 ("+6" ?^)
 ("+7" ?&)
 ("+8" ?*)
 ("+9" ?\()
 ("+0" ?\)))

;;; slovak-qwerty.el ends here

(provide 'slovak-qwerty)