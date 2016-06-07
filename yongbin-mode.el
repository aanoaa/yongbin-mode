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

(defun yongbin-e-or-ae-p (char)
  (or (char-equal char ?ㅔ)
      (char-equal char ?ㅐ)))

(defun yongbin-swap-e-and-ae (char)
  "Swap ㅔ and ㅐ"
  (cond ((char-equal char ?ㅔ) ?ㅐ)
        ((char-equal char ?ㅐ) ?ㅔ)
        (t char)))

(provide 'yongbin-mode)
