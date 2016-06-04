;;; Code:
(defun yongbin-e-or-ae-p (char)
  (or (string= char "ㅔ")
      (string= char "ㅐ")))

(defun yongbin-swap-e-and-ae (char)
  "Swap ㅔ and ㅐ"
  (cond ((string= char "ㅐ") "ㅔ")
        ((string= char "ㅔ") "ㅐ")
        (t char)))

(defun yongbinize ()
  "Insert the character you type, but swap ㅔ and ㅐ."
  (when (and (characterp last-command-event)
             (or (yongbin-e-or-ae-p last-command-event)
                 (eq this-command (key-binding [remap self-insert-command]))))
    (setq last-command-event (yongbin-swap-e-and-ae last-command-event))))

;;;###autoload
(define-minor-mode yongbin-mode
  "Make self-inserting keys swap ㅔ and ㅐ"
  :global t
  (if yongbin-mode
      (add-hook 'pre-command-hook #'yongbinize)
    (remove-hook 'pre-command-hook #'yongbinize)))

(provide 'yongbin-mode)
;;; yongbin-mode.el ends here
