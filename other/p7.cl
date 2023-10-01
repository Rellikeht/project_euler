#!/bin/sbcl --script
(setf primes '(2 3 5 7 11 13 17 19))

(defun get_next_prime (&optional (i (+ (nth (- (length primes) 1) primes) 1)) (j 0))
  (if (eql j (- (length primes) 1))
    (progn
      (setf primes (append primes (list i)))
      i)
    (if (eql 0 (mod i (nth j primes)))
      (get_next_prime (+ i 1) 0)
      (get_next_prime i (+ j 1)))))

(setf np (read))
(do ((i (length primes) (+ i 1))) ((eql i np))
  (get_next_prime))
(format t "~A~%" (get_next_prime))
