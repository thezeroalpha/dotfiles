(require 'quail)

(quail-define-package "boxdrawing" "English" "|-" t "English with boxdrawing maps" nil t nil nil nil nil nil nil nil nil t)
(quail-define-rules
 ("|-" ?├)
 ("--" ?─)
 ("|" ?│)
 ("|_" ?└))

(provide 'quail-boxdrawing)
