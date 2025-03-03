#!/usr/bin/env -S sbcl --script

(setf max_d 12000)
(setf maxf (/ 1 2))
(setf minf (/ 1 3))

(defun number_list (down up stp)
  (labels
    ((gen_num_list
       (down up lst)
       (if (> down up)
     lst
     (gen_num_list down
               (- up stp)
               (cons up lst)))))
    (gen_num_list down up '())))

(defun reduced (n d)
  (= 1 (gcd n d)))

(defun test (n d)
  (let ((f (/ n d)))
    (if (and
      (reduced n d)
      (< minf f)
      (> maxf f))
      t
      nil)))

(defun count_fractions (cur_number nmr)
  (if (> nmr max_d)
    cur_number
    (count_fractions
      (cnt_fracs cur_number nmr (number_list nmr max_d 1))
      (+ nmr 1))))

(defun cnt_fracs (cnt nmr denoms)
  (if (null denoms)
    cnt
    (let ((fd (car denoms))
      (rd (cdr denoms)))
      (if (test nmr fd)
    (cnt_fracs (+ cnt 1) nmr rd)
    (cnt_fracs cnt nmr rd)))))

(format t "~A~%" (count_fractions 0 1))
