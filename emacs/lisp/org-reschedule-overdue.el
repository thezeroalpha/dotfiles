(require 'org)
(require 'calendar)

;;; -------------------------------------------------------------------
;;; Low-level date helpers (operate on "absolute day numbers", i.e. the
;;; integers returned by `time-to-days', so arithmetic is just +/- 1).
;;; -------------------------------------------------------------------

(defun org-reschedule-overdue--weekend-day-p (day)
  "Non-nil if absolute DAY number falls on Saturday or Sunday."
  (memq (calendar-day-of-week (calendar-gregorian-from-absolute day)) '(0 6)))

(defun org-reschedule-overdue--next-non-weekend-day (day)
  "Return the first day >= DAY that is not a weekend."
  (while (org-reschedule-overdue--weekend-day-p day)
    (setq day (1+ day)))
  day)

(defun org-reschedule-overdue--day-to-date-string (day)
  "Convert absolute DAY number to an \"YYYY-MM-DD\" string."
  (let ((greg (calendar-gregorian-from-absolute day)))
    (format "%04d-%02d-%02d" (nth 2 greg) (nth 0 greg) (nth 1 greg))))

;;; -------------------------------------------------------------------
;;; Entry predicates
;;; -------------------------------------------------------------------

(defun org-reschedule-overdue--habit-p ()
  "Non-nil if the entry at point is tagged :HABIT:."
  (member "HABIT" (org-get-tags)))

(defun org-reschedule-overdue--habits-on-day (day files)
  "Return markers of not-done :HABIT: entries scheduled on absolute DAY, across FILES."
  (let (markers)
    (org-map-entries
     (lambda ()
       (let ((sched (org-get-scheduled-time (point))))
         (when (and sched
                    (= (time-to-days sched) day)
                    (not (org-entry-is-done-p))
                    (org-reschedule-overdue--habit-p))
           (push (point-marker) markers))))
     nil files)
    (nreverse markers)))

;;; -------------------------------------------------------------------
;;; HABIT conflict resolution
;;; -------------------------------------------------------------------

(defun org-reschedule-overdue--resolve-habit-conflicts (start-day files)
  "Ensure no day from START-DAY onward has 2+ scheduled HABIT entries.

Walks forward day by day starting at START-DAY.  On any (non-weekend)
day where two or more not-done HABIT-tagged entries are scheduled,
all but the first of them are pushed to the next non-weekend day.
Because that target day is always later, and the day-by-day walk
continues until no more work is pending, conflicts cascade correctly
even if they ripple across several days."
  (let ((day start-day)
        (last-day-with-work start-day))
    (while (<= day last-day-with-work)
      (unless (org-reschedule-overdue--weekend-day-p day)
        (let ((habits (org-reschedule-overdue--habits-on-day day files)))
          (when (> (length habits) 2)
            ;; Keep the first habit where it is; bump the rest forward.
            (dolist (m (cdr habits))
              (let ((next-day (org-reschedule-overdue--next-non-weekend-day (1+ day))))
                (org-with-point-at m
                  (org-schedule nil (org-reschedule-overdue--day-to-date-string next-day)))
                (when (> next-day last-day-with-work)
                  (setq last-day-with-work next-day)))))))
      (setq day (1+ day)))))

(defun org-reschedule-overdue--schedule-and-cascade (marker day files)
  "Schedule the entry at MARKER onto absolute DAY, then cascade-resolve
any :HABIT: pile-up that scheduling just created, starting at DAY and
walking forward through FILES."
  (org-with-point-at marker
    (org-schedule nil (org-reschedule-overdue--day-to-date-string day)))
  (org-reschedule-overdue--resolve-habit-conflicts day files))

;;; -------------------------------------------------------------------
;;; Main entry points
;;; -------------------------------------------------------------------

;;;###autoload
(defun org-reschedule-overdue-tasks ()
  "Reschedule overdue TODO entries in `org-agenda-files'.

Prompts for a starting date.  Every currently overdue, not-done entry
\(i.e. its SCHEDULED timestamp is earlier than today) is rescheduled
onto the first day on or after the starting date that is not a
Saturday or Sunday.

Each overdue task is handled one at a time: it is scheduled onto the
target day, and then entries tagged :HABIT: are immediately checked
day by day starting at that target day. Whenever a day ends up with
two or more scheduled HABIT entries, all but the first are pushed
forward to the next non-weekend day, cascading forward as necessary
so that no day ever holds more than one HABIT entry -- before the
next overdue task is even scheduled."
  (interactive)
  (let* ((start-str (org-read-date nil nil nil
                                    "Reschedule overdue tasks starting from: "))
         (start-day (time-to-days (org-time-string-to-time start-str)))
         (target-day (org-reschedule-overdue--next-non-weekend-day start-day))
         (today-day (time-to-days (current-time)))
         (files (org-agenda-files))
         overdue-markers)
    (unless files
      (user-error "`org-agenda-files' is empty"))
    ;; 1. Collect overdue, not-done entries.
    (org-map-entries
     (lambda ()
       (let ((sched (org-get-scheduled-time (point))))
         (when (and sched
                    (not (org-entry-is-done-p))
                    (< (time-to-days sched) today-day))
           (push (point-marker) overdue-markers))))
     nil files)
    (setq overdue-markers (nreverse overdue-markers))
    (unless overdue-markers
      (user-error "No overdue tasks found"))
    ;; 2. Reschedule each overdue task onto TARGET-DAY, and immediately
    ;;    cascade-resolve any HABIT clash that scheduling it just created,
    ;;    before moving on to the next task.
    (dolist (m overdue-markers)
      (org-reschedule-overdue--schedule-and-cascade m target-day files))
    (message "Rescheduled %d overdue task(s) onto %s (HABIT clashes resolved)."
             (length overdue-markers)
             (org-reschedule-overdue--day-to-date-string target-day))))

;;;###autoload
(defun org-reschedule-overdue-schedule-at-point-with-cascade ()
  "Schedule the org heading at point, applying the same cascading rules
as `org-reschedule-overdue-reschedule-overdue-tasks'.

Prompts for a date.  The heading at point is scheduled onto the first
day on or after that date which is not a Saturday or Sunday.  If that
placement gives the day two or more scheduled :HABIT: entries, all
but the first are pushed forward to the next non-weekend day,
cascading forward as necessary so that no day ever holds more than
one HABIT entry."
  (interactive)
  (save-excursion
    (org-back-to-heading t)
    (let* ((date-str (org-read-date nil nil nil "Schedule for: "))
           (day (time-to-days (org-time-string-to-time date-str)))
           (target-day (org-reschedule-overdue--next-non-weekend-day day))
           (files (org-agenda-files))
           (marker (point-marker)))
      (org-reschedule-overdue--schedule-and-cascade marker target-day files)
      (message "Scheduled onto %s (HABIT clashes resolved)."
               (org-reschedule-overdue--day-to-date-string target-day)))))

(defun org-reschedule-overdue-org-schedule-wrapper (arg &optional time)
  (interactive "P")
  (cond ((equal arg '(256))
         (org-reschedule-overdue-schedule-at-point-with-cascade))
        (t (org-schedule arg time))))

(provide 'org-reschedule-overdue)
