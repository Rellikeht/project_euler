(load "primes_functions.scm")

(define sd 500)

(define (search_tn)
  (let ((ctn (next_tn)))
    (if (> (divs ctn) 500)
      ctn
      (search_tn))))

(display (search_tn))
(newline)
