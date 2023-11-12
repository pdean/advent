(import (chicken io) (chicken string) 
        (chicken sort) regex
        srfi-1)

(define input (with-input-from-file "input" read-string))

(define lines 
  (string-split 
    (string-translate* input '(("\n\n" . "\f") ("\n" . " "))) 
    "\f"))

(define (valid line)
  (let* ((fields (string-split line))
         (dict (map (cut string-split <> ":") fields))
         (names (map car dict))
         (label (apply string-append (sort names string<?))))
    (cond ((or (string=? label "byrcidecleyrhclhgtiyrpid")
               (string=? label "byrecleyrhclhgtiyrpid")) dict)
          (else #f))))

(define dict (filter valid lines))
(print (length dict))

(define (check pp)
  (define (get key)
    (cadr (assoc key pp)))
  (define (byr) 
    (let ((val (get "byr")))


    )
  (define (ecl)
    )
  (define (eyr)

    )
  (define (hcl)

    )
  (define (


