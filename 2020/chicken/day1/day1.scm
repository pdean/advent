(import miscmacros 
        simple-loops 
        (chicken string)
        (chicken io))

(define data 
  (with-input-from-file "input"
    (lambda () 
      (map string->number 
       (string-split 
         (read-string) "\n")))))

;(print data)

(define (part1 data)
  (let/cc return 
    (do-list i data
     (do-list j data
       (if (= 2020 (+ i j))
         (return (list (list i j) (* i j))))))))

(print (part1 data))


(define (part2 data)
  (let/cc return 
    (do-list i data
     (do-list j data
       (do-list k data
         (if (= 2020 (+ i j k))
           (return (list (list i j k) (* i j k)))))))))

(print (part2 data))
