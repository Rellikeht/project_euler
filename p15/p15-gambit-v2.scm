(define (opt-arg args n default)
  (if (< n (length args))
    (list-ref args n)
    default))
     
(define (next-row cur_row . rest)
  (let* ((cl (vector-length cur_row))
	(pos (opt-arg rest 0 0))
	(next_row (opt-arg rest 1
			    (make-vector (+ cl 1)))))
    (if (= pos cl)
      (begin
	(vector-set! next_row pos
		     (vector-ref cur_row (- pos 1)))
	next_row)
      (begin
	(if (= pos 0)
	  (vector-set! next_row pos
		       (vector-ref cur_row pos))
	  (begin
	    (vector-set! next_row pos
			 (+ (vector-ref cur_row pos)
			    (vector-ref cur_row
					(- pos 1))))))
	    (next-row cur_row (+ pos 1) next_row)))))

(define (lsolve lsize . cr)
  (if (null? cr)
    (set! cr (vector 1))
    (set! cr (list-ref cr 0)))
  (if (= lsize 0)
    (do ((i 0 (+ i 1))
	 (s 0 (+ s (expt
		     (vector-ref cr i)
		     2))))
      ((= i (vector-length cr))
       s))
    (lsolve (- lsize 1)
	    (next-row cr))))

(display (lsolve (read)))
(newline)
