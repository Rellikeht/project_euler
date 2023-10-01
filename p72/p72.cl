#!/bin/sbcl --script

(declaim
  (optimize
    (speed 3)
    (safety 0)
    (debug 0)
    (compilation-speed 0)))
(declaim (fixnum max_d))

(setf max_d 10000)

(defun reduced (n d)
  (= 1 (gcd n d)))

(defun reduced_list (down up num)
  (declare (fixnum num)
	   (integer down up))
  (labels
    ((gen_red_list
       (down up cnt)
       (declare (integer down up cnt))
       (if (> down up)
	 cnt
	 (gen_red_list down (the integer (1- up))
		       (if (reduced num up)
			 (the integer (1+ cnt))
			 cnt)))))
    (gen_red_list down up 0)))

(defun count_fractions (cur_count cur_num)
  (declare (fixnum cur_count)
	   (integer cur_num))
;  (format t "~A ~A~%" cur_num cur_count)
  (if (> cur_num max_d)
    cur_count
    (count_fractions
      (the fixnum (+ cur_count
	 (reduced_list cur_num max_d cur_num)))
      (the fixnum (1+ cur_num)))))

(declaim (inline reduced))

(format t "~A~%" (count_fractions 0 1))
