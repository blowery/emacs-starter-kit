(require 'org-install)
 ;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(org-remember-insinuate)
(setq org-directory "~/todo/")
(setq org-default-notes-file (concat org-directory "/joost.org"))
(define-key global-map "\C-cr" 'org-remember)

;; make the clock persist across invocations of emacs
(setq org-clock-persist t)
(org-clock-persistence-insinuate)

(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only
(setq org-log-done t)

(setq org-completion-use-ido t)
(setq org-hide-leading-stars t)
(setq org-agenda-files (file-expand-wildcards "~/todo/*.org"))
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


(provide 'starter-kit-org)