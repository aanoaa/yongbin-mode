(define-minor-mode yongbin-mode
  "swap ㅔ and ㅐ"
  :init-value nil
  :lighter " Yongbin"
  :keymap '(
            (?ㅔ . (lambda () (interactive) (insert (string-to-char "ㅐ"))))
            (?ㅐ . (lambda () (interactive) (insert (string-to-char "ㅔ"))))))
