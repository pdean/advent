(import (chicken io) )

(define data (list->vector (with-input-from-file "input" read-lines)))
(define rows (vector-length data))
(define cols (string-length (vector-ref data 0)))

(define (total rowi coli)
  (define (ref i j)
    (if (eq? #\# (string-ref (vector-ref data i)
                    (remainder j cols))) 1 0))
  (let loop ((row 0) (col 0) (tot 0))
    (cond ((>= row rows) tot)
          (else 
            (loop (+ row rowi) (+ col coli) (+ tot (ref row col)))))))

(print (total 1 3))

(print (* (total 1 1) (total 1 3) (total 1 5) (total 1 7) (total 2 1)))
