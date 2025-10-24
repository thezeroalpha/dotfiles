;;; ob-passthrough.el ---  passthrough evaluator          -*- lexical-binding: t; -*-

;; this ob evaluates the block as ifself, so it can be used as input
;; for another block

(require 'ob)

(defun org-babel-execute:passthrough (body params)
  body)

;; json output is json
(defalias 'org-babel-execute:json 'org-babel-execute:passthrough)

(provide 'ob-passthrough)
;;; ob-passthrough.el ends here
