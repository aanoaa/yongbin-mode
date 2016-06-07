(defvar yongbin-mode nil "Mode variable for yongbin minor mode.")
(make-variable-buffer-local 'yongbin-mode)

(defun yongbin-mode (&optional arg)
  "Make self-inserting keys swap ㅔ and ㅐ"
  (interactive "P")
  (setq yongbin-mode
        (if (null arg) (not yongbin-mode)
          (> (prefix-numeric-value arg) 0)))
  (if yongbin-mode
      (add-hook 'pre-command-hook 'yongbin-swap)
    (remove-hook 'pre-command-hook 'yongbin-swap)))

(if (not (assq 'yongbin-mode minor-mode-alist))
    (setq minor-mode-alist
          (cons '(yongbin-mode " Yongbin")
                minor-mode-alist)))

(defun yongbin-swap ()
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

(defcustom yongbinize-command "yb"
  "yongbinized command."
  :type 'string)

(defcustom yongbinize-buffer-name "*yongbinized*"
  "buffer name of yongbinized."
  :type 'string)

(defun yongbinize-cleanup-buffer ()
  (let ((buffer (get-buffer yongbinize-buffer-name)))
    (when buffer
      (with-current-buffer buffer
        (setq buffer-read-only nil)
        (erase-buffer)))))

(defun yongbinize-buffer ()
  (interactive)
  (yongbinize-cleanup-buffer)
  (yongbinize-region (point-min) (point-max)))

(defun yongbinize-line ()
  (interactive)
  (yongbinize-cleanup-buffer)
  (yongbinize-region (line-beginning-position) (line-end-position)))

(defun yongbinize-region (start end)
  (interactive "r")
  (yongbinize-cleanup-buffer)
  (shell-command-on-region
   ;; beginning and end of buffer(STDIN)
   start end
   ;; command and parameter
   yongbinize-command
   ;; output buffer
   yongbinize-buffer-name
   ;; replace?
   nil
   ;; name of error buffer
   "*yongbinize Error*"
   ;; show error buffer?
   t))

(provide 'yongbin-mode)
