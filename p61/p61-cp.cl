#!/bin/sbcl --script

(defun gen-num-to (max_num func
			   &optional
			   (start_num 0))
  (labels ((gnt (mn fn n ce nl sn)
		(if (>= ce mn)
		  (reverse nl)
		  (let ((ce (funcall fn n)))
		    (if (> ce sn)
		      (push ce nl))
		    (gnt mn fn (+ n 1) ce nl sn)))))
    (gnt max_num func 0 0 '() start_num)))

(setf gmn 10000)
(setf stn 1000)

(setf sets (list (gen-num-to gmn (lambda (n)
			    (* (- (* 3 n) 2) n)) stn)))
(push (gen-num-to gmn (lambda (n)
			    (/ (* (- (* 5 n) 3) n) 2)) stn) sets)
(push (gen-num-to gmn (lambda (n)
			    (* (- (* 2 n) 1) n)) stn) sets)
(push (gen-num-to gmn (lambda (n)
			    (/ (* (- (* 3 n) 1) n) 2)) stn) sets)
(push (gen-num-to gmn (lambda (n)
			    (* n n)) stn) sets)
(push (gen-num-to gmn (lambda (n)
			    (/ (* (+ n 1) n) 2)) stn) sets)
(defun cycl-check (bn cn)
  (if (eql (truncate cn 100) (mod bn 100))
    t
    nil))

(defun gen-num-arr (l &optional (ll (length l))
		      (a (make-array ll :fill-pointer 0)) (i 0))
  (if (eql i ll)
    a
    (progn
      (vector-push i a)
      (get-num-arr l ll a (+ i 1)))))

(defun gen-v-list (l n &optional (nl '()))
  (if (eql 0 n)
    nl
    (gen-v-list l (- n 1) (append nl (list l)))))

(defun check-len-subl (l &optional (i 0))
  (if (eql (length (nth i l)) 6)
    i
    (check-len-subl l (+ i 1))))

(defun ins-el (chlist el ulist sval &optional (i 0) (af nil))
  (if (< i (length chlist))
    (let* ((nic (nth i chlist))
	  (nicl (nth (- (length nic) 1) nic)))
      (if (and (cycl-check nicl el) (not (eql sval (nth i ulist))))
	(progn
	  (setf (nth i chlist) (append nic (list el)))
	  (setf (nth i ulist) sval)
	  (setf af t)))
      (ins-el chlist el ulist sval (+ i 1) af))
    (if af
      (values chlist ulist)
      (values (append chlist (list (list el))) (append ulist (list sval))))))

(defun add-list (chlist alist ulist sval
			&optional (i 0))
;  (format t "~A : ~A : ~A : ~A : ~A~%"
;	  i chlist alist ulist sval)
  (if (< i (length alist))
    (multiple-value-call (lambda (cl ul)
			   (add-list cl alist
				     ul sval (+ i 1)))
      (ins-el chlist (nth i alist) ulist sval))
    (values chlist ulist)))

(defun imax (&rest args)
  (labels ((im
	     (cm mi ci
	      args)
;	     (format t "~A~%" args)
;	     (format t "~A: ~A ~A ~A~%" ci cm mi (nth ci args))
	     (if (eql ci (length args))
	       (list cm mi)
	       (if (> (nth ci args))
		 (im (nth ci args) ci (+ ci 1) args)
		 (im cm mi (+ ci 1) args)))))
    (if (null args)
      nil
      (im (nth 0 args) 0 1 args))))

(defun search-nums (&optional (cur_set 1)
			 (chlist (mapcar 'list (nth 0 sets)))
			 (llist
			   (gen-v-list 0 (length (nth 0 sets)))))
  (format t "~A~%" chlist)
  (let ((mi (reduce 'imax (mapcar 'length chlist))))
    (if (eql (nth 0 mi) 6)
      (nth (nth 1 mi) chlist)
      (if (> cur_set (length sets))
	(search-nums 0 chlist llist)
	(multiple-value-call
	  (lambda (cl ll)
	    (search-nums cl ll (+ cur_set 1)))
	  (add-list chlist (nth cur_set sets)
		    llist cur_set))))))

;(format t "~A~%" sets)

;(format t "~A~%" (multiple-value-list (ins-el '((2321 2342 7452)
;						(8912)
;						(3131 2398 1023 1312)
;						(2347) (5732 4312)
;						(2389 2432))
;					      1234 '(0 0 0 0 1 1) 1)))

;(format t "~A~%" (multiple-value-list (add-list '((2321 2342 7452)
;						  (8912)
;						  (3131 2398 1023 1312)
;						  (2347) (5732 4312)
;						  (2389 2432))
;						'(1234 5201 5331)
;						'(0 0 0 0 1 1) 1)))

(format t "~A~%" (search-nums))
;(format t "~A~%" (imax 2 1 3 0))
