(require 'org-install)
 ;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(org-remember-insinuate)
(setq org-directory "~/notes/")
(setq org-default-notes-file (concat org-directory "/remember.org"))
(define-key global-map "\C-cr" 'org-remember)

(setq org-remember-templates
      '(("Todo" ?t "* TODO %?\n %i\n %a" "~/notes/remember.org" "Tasks")
        ("Bug" ?b "* TODO %?\n %i\n %a" "~/notes/joost.org" "Bugs")
        ("Idea" ?i "* %^{Title}\n %i\n %a" "~/notes/remember.org" "New Ideas")))

;; make the clock persist across invocations of emacs
(setq org-clock-persist t)
(org-clock-persistence-insinuate)

(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only
(setq org-log-done t)

(setq org-completion-use-ido t)
(setq org-hide-leading-stars t)
(setq org-agenda-files (file-expand-wildcards "~/notes/*.org"))
(setq org-link-abbrev-alist
      '(("MWF" . "https://intranet.joost.com/bugs/browse/MWF-")
        ("PRJ" . "https://intranet.joost.com/bugs/browse/PRJ-")
        ("FRS" . "https://intranet.joost.com/bugs/browse/FRS-")
        ("MWB" . "https://intranet.joost.com/bugs/browse/MWB-")
        ("UIF" . "https://intranet.joost.com/bugs/browse/UIF-")
        ("OPS" . "https://intranet.joost.com/bugs/browse/OPS-")
        ("TRV" . "https://intranet.joost.com/bugs/browse/TRV-")
        ("CPR" . "https://intranet.joost.com/bugs/browse/CPR-")
        ("dojobug"  . "http://bugs.dojotoolkit.org/ticket/")
        ("google"   . "http://www.google.com/search?q=")))
(setq org-icalendar-store-UID t)
(setq org-combined-agenda-icalendar-file "~/Sites/org.ics")


(setq org-todo-keywords
      '((sequence "TODO(t)" "STALLED(s)" "|" "DONE(d)" "DELEGATED(g)")
        (sequence "MAYBE(m)" "|" "YES(y)" "NO(n)")
        (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")))

(provide 'starter-kit-org)