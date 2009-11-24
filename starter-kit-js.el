;;; starter-kit-js.el --- Some helpful Javascript helpers
;;
;; Part of the Emacs Starter Kit

(autoload 'js2-mode "js2" nil t)

;; yeah yeah using the build in js-mode for now
;; need js2-mode to catch up on the indentation front
;; before I start using it again
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))

(defun whitespace-mode-on ()
  (whitespace-mode t))

;; javascript lint 
(defun jslint-thisfile ()
  (interactive)
  (compile (format "~/bin/jsl -process %s" (buffer-file-name))))

(defun javascript-mode-keybindings ()
  (local-set-key [f8] 'jslint-thisfile)
  (local-set-key (kbd "M-n") 'next-error)
  (local-set-key (kbd "M-p") 'previous-error))

(add-hook 'js-mode-hook 'run-coding-hook)
(add-hook 'js-mode-hook 'whitespace-mode-on)
(add-hook 'js-mode-hook 'javascript-mode-keybindings)
;;(add-hook 'js-mode-hook 'esk-paredit-nonlisp)

(eval-after-load 'js
  '(progn (font-lock-add-keywords 'js-mode
                        '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\):"
                           1 font-lock-warning-face t)))))

(defun esk-pp-json ()
  "Pretty-print the json object following point."
  (interactive)
  (require 'json)
  (let ((json-object (save-excursion (json-read))))
    (switch-to-buffer "*json*")
    (delete-region (point-min) (point-max))
    (insert (pp json-object))
    (goto-char (point-min))))


(provide 'starter-kit-js)
;;; starter-kit-js.el ends here
