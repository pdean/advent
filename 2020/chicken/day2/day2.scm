(import (chicken io) regex srfi-1)

(define lines (with-input-from-file "input" read-lines))
(define rx (regexp "^(\\d+)-(\\d+) (.): (.*)"))

(define (valid1 line)
  (let* ((list (cdr (string-match rx line)))
         (i (string->number (first list)))
         (j (string->number (second list)))
         (ch  (car (string->list (third list))))
         (pass (string->list (fourth list))))
    (<= i (count (cut eq? ch <>) pass) j)))

(print (count valid1 lines))

(define (valid2 line)
  (let* ((list (cdr (string-match rx line)))
         (i (string->number (first list)))
         (j (string->number (second list)))
         (ch  (car (string->list (third list))))
         (pass (fourth list))
         (a (eq? ch (string-ref pass (sub1 i))))
         (b (eq? ch (string-ref pass (sub1 j)))))
    (not (eq? a b))))

(print (count valid2 lines))




