;;; starter-kit-js.el --- Some helpful Javascript helpers
;;
;; Part of the Emacs Starter Kit

(autoload 'js2-mode "js2" nil t)

(autoload 'espresso-mode "espresso" "Espresso Mode" t nil)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(eval-after-load 'js2-mode
  '(progn

     ;; Cosmetics
     ;; (font-lock-add-keywords
     ;;  'js2-mode `(("\\(function *\\)("
     ;;               (0 (progn (compose-region (match-beginning 1) (match-end 1)
     ;;                                         "ƒ")
     ;;                         nil)))))

     (font-lock-add-keywords
      'js2-mode
      '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\):"
         1 font-lock-warning-face t)))

     (defun js-lambda () (interactive) (insert "function() {\n}")
       (backward-char 5))

     (add-hook 'js2-mode-hook 'run-coding-hook)

     (define-key js2-mode-map (kbd "C-c l") 'js-lambda)
     (define-key js2-mode-map "\C-\M-h" 'backward-kill-word)

;;     Fix js's crazy indentation
;;     (define-key js2-mode-map (kbd "TAB") (lambda () (interactive)
;;                                            (indent-for-tab-command)
;;                                            (back-to-indentation)))

;;     (setq js-bounce-indent-flag nil
;;           js-indent-on-enter-key nil)

     ;; (defun js-continued-var-decl-list-p ()
     ;;   "Return non-nil if point is inside a continued variable declaration list."
     ;;   (interactive)
     ;;   (let ((start (save-excursion (js-re-search-backward "\\<var\\>" nil t))))
     ;;     (and start
     ;;          (save-excursion (re-search-backward "\n" start t))
     ;;          (not (save-excursion
     ;;                 (js-re-search-backward
     ;;                  ";\\|[^, \t][ \t]*\\(/[/*]\\|$\\)" start t))))))
     
     ;; (defun js-proper-indentation (parse-status)
     ;;   "Return the proper indentation for the current line."
     ;;   (save-excursion
     ;;     (back-to-indentation)
     ;;     (let ((ctrl-stmt-indent (js-ctrl-statement-indentation))
     ;;           (same-indent-p (looking-at "[]})]\\|\\<case\\>\\|\\<default\\>"))
     ;;           (continued-expr-p (js-continued-expression-p)))
     ;;       (cond (ctrl-stmt-indent)
     ;;             ((js-continued-var-decl-list-p)
     ;;              (js-re-search-backward "\\<var\\>" nil t)
     ;;              (+ (current-indentation) js-basic-offset))
     ;;             ((nth 1 parse-status)
     ;;              (goto-char (nth 1 parse-status))
     ;;              (if (looking-at "[({[][ \t]*\\(/[/*]\\|$\\)")
     ;;                  (progn
     ;;                    (skip-syntax-backward " ")
     ;;                    (when (= (char-before) ?\)) (backward-list))
     ;;                    (back-to-indentation)
     ;;                    (cond (same-indent-p
     ;;                           (current-column))
     ;;                          (continued-expr-p
     ;;                           (+ (current-column) (* 2 js-basic-offset)))
     ;;                          (t
     ;;                           (+ (current-column) js-basic-offset))))
     ;;                (unless same-indent-p
     ;;                  (forward-char)
     ;;                  (skip-chars-forward " \t"))
     ;;                (current-column)))
     ;;             (continued-expr-p js-basic-offset)
     ;;             (t 0)))))
     ))

(defun esk-pp-json ()
  "Pretty-print the json object following point."
  (interactive)
  (require 'json)
  (let ((json-object (save-excursion (json-read))))
    (switch-to-buffer "*json*")
    (delete-region (point-min) (point-max))
    (insert (pp json-object))
    (goto-char (point-min))))


(require 'snippet)
(define-abbrev-table 'js2-mode-abbrev-table ())
(snippet-with-abbrev-table
 'js2-mode-abbrev-table
 ("qfor" .  "$>for(var $${i}=$${0},$${len}=$${thing}.length;$${i}<$${len};++$${i}){\n$>$.\n}$>")
 ("forin" . "$>for(var $${i} in $${var}){\n$>$$;\n}$.$>")
 ("deach" . "$>dojo.forEach($${arr}, $${func})$.;")
 ("dmap" . "$>dojo.map($${arr}, $${func})$.;")
 ("dquery" . "$>dojo.query($${selector}, $${root})$.;")
 ("qif"  .  "$>if($${cond}){$>\n$>$.;\n}$>")
 ("ifel" . "$>if($${cond}){$>\n$>$$;\n} else {$>\n$>$$;\n}$.$>")
 ("wh"  .  "$>while($${i}){\n$>$.\n}$>")
 ("whinc" . "$>while($${i}<$${10}){\n$>$.\n$>$${i}++;\n}$>")
 ("trn" . "$${if}?$${then}:$${else};")
 ("qvar" . "var $${variable} = $${value};")
 ("qfn" . "$>function $${name}($${args}){\n$>$.\n}$>")
 ("qlam" . "$>function ($${args}){\n$>$.\n}$>")
 ("qlog" . "console.log('$${message}');")) ;Firebug logging 
(add-hook 'js2-mode-hook
          (lambda ()
            (abbrev-mode 1)
            ;; This line is not in the documentation of snippet.el, but seems to be
            ;; essential for various modes (not for python-mode though, which serves as
            ;; the example mode in said documentation)
            (setq local-abbrev-table js2-mode-abbrev-table)))

(provide 'starter-kit-js)
;;; starter-kit-js.el ends here
