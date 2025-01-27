(defun za/org-clock-resolve-clock
    (clock resolve-to clock-out-time close restart fail-quietly)
  "Resolve CLOCK given the time RESOLVE-TO, and the present.
CLOCK is a cons cell of the form (MARKER START-TIME)."
  (let ((org-clock-resolving-clocks t)
	;; If the clocked entry contained only a clock and possibly
	;; the associated drawer, and we either cancel it or clock it
	;; out, `org-clock-out-remove-zero-time-clocks' may clear all
	;; contents, and leave point on the /next/ headline.  We store
	;; the current entry location to be able to get back here when
	;; we need to clock in again the previously clocked task.
	(heading (org-with-point-at (car clock)
		   (org-back-to-heading t)
		   (point-marker))))
    (pcase resolve-to
      (`nil
       (org-clock-clock-cancel clock)
       (when (and restart (not org-clock-clocking-in))
	 (org-with-point-at heading (org-clock-in))))
      (`now
       (cond
	(restart (error "RESTART is not valid here"))
	((or close org-clock-clocking-in)
	 (org-clock-clock-out clock fail-quietly))
	((org-is-active-clock clock) nil)
	(t (org-clock-clock-in clock t))))
      ((pred (time-less-p nil))
       (error "RESOLVE-TO must refer to a time in the past"))
      (_
       (when restart (error "RESTART is not valid here"))
       ;; I switched the or condition here because i want G to work the way I want
       (org-clock-clock-out clock fail-quietly (or resolve-to clock-out-time))
       (cond
	(org-clock-clocking-in nil)
	(close
	 (setq org-clock-leftover-time (and (null clock-out-time) resolve-to)))
	(t
	 (org-with-point-at heading
	   (org-clock-in nil (and clock-out-time resolve-to)))))))))

(advice-add 'org-clock-resolve-clock :override #'za/org-clock-resolve-clock)

(provide 'org-clock-override)
