(define (cpaths #!optional (size 20) (pos (list 0 0)) (c 0) (fc 0))
  (if (equal? pos (list (- size 1) (- size 1)))
    (set! c (+ c 1))
    (begin
      (if (< (list-ref pos 0) (- size 1))
        (set! c (cpaths size (list (+ (list-ref pos 0) 1) (list-ref pos 1)) c (+ fc 1))))
      (if (< (list-ref pos 1) (- size 1))
        (set! c (cpaths size (list (list-ref pos 0) (+ (list-ref pos 1) 1)) c (+ fc 1))))))
  c)

(display (cpaths (read)))
(newline)
