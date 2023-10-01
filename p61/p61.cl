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

(defun imax (&rest args)
  (labels ((im
	     (cm mi ci
	      args)
	     (if (eql ci (length args))
	       (list cm mi)
	       (if (> (nth ci args))
		 (im (nth ci args) ci (+ ci 1) args)
		 (im cm mi (+ ci 1) args)))))
    (if (null args)
      nil
      (im (nth 0 args) 0 1 args))))

;(defun ins-el (chlist el ulist sval &optional (i 0) (af nil))
;  (if (< i (length chlist))
;    (let* ((nic (nth i chlist))
;	  (nicl (nth (- (length nic) 1) nic)))
;      (if (and (cycl-check nicl el) (not (eql sval (car (nth i ulist)))))
;	(progn
;	  (setf (nth i chlist) (append nic (list el)))
;;	  (setf (nth i ulist) sval)
;	  (setf (nth i ulist) (append (list sval) (nth i ulist)))
;	  (setf af t)))
;      (ins-el chlist el ulist sval (+ i 1) af))
;    (if af
;      (values chlist ulist)
;      (values (append chlist (list (list el))) (append ulist (list (list sval)))))))

(defun ins-el (chlist el ulist sval &optional (i 0) (af nil))
  (if (< i (length chlist))
    (let* ((nic (nth i chlist))
	  (nicl (nth (- (length nic) 1) nic)))
      (if (and (cycl-check nicl el) (not (eql sval (car (nth i ulist)))))
	(progn
	  (setf (nth i chlist) (append nic (list el)))
;	  (setf (nth i ulist) sval)
	  (setf (nth i ulist) (append (list sval) (nth i ulist)))
	  (setf af t)))
      (ins-el chlist el ulist sval (+ i 1) af))
    (if af
      (values chlist ulist)
      (values (append chlist (list (list el))) (append ulist (list (list sval)))))))

(defun remove-doubles (chlist ulist &optional (i 0))
  (if (>= i (length ulist))
    (values chlist ulist)
    (let* ((nic (nth i chlist))
	  (nicp (position nic chlist :test 'equal)))
;      (format t "~A ~A ~A~%" i nicp nic)
      (if (eql i nicp)
	(remove-doubles chlist ulist (+ i 1))
	(remove-doubles
	  (remove nic chlist :count 1)
	  (remove-if (lambda (x)
		       (and (eql x (nth i ulist))
			    (eql (position x ulist)
				 (position nic chlist))))
		     ulist :count 1))))))

(defun add-list (chlist alist ulist sval
			&optional (i 0))
;  (format t "~A~%" (nth i alist))
;  (format t "~A: ~A~%" i chlist)
  (if (< i (length alist))
    (multiple-value-call (lambda (cl ul)
			   (add-list cl alist
				     ul sval (+ i 1)))
      (if (< i (- (length alist) 1))
	(if (eql
	      (truncate (nth (+ i 1) alist) 100)
	      (truncate (nth i alist) 100))
	  (multiple-value-bind (cl ul)
	    (ins-el (copy-list chlist) (nth i alist) (copy-list ulist) sval)
	    (multiple-value-bind (cl2 ul2)
	      (ins-el chlist (nth (+ i 1) alist) ulist sval)
;	      (format t "=~%~A ~% - ~% ~A~%=~%" cl cl2)
	      (remove-doubles (append cl cl2) (append ul ul2))))
	  (ins-el chlist (nth i alist) ulist sval))
	(ins-el chlist (nth i alist) ulist sval)))
    (values chlist ulist)))

(defun clear-list (chlist ulist sval &optional (i 0) (nchlist '()) (nulist '()))
  (if (eql i (length ulist))
    (values nchlist nulist)
    (if (eql (car (nth i ulist)) sval)
      (clear-list chlist ulist sval
			  (+ i 1)
			  (append nchlist
				  (list
				    (nth i chlist)))
			  (append nulist
				  (list
				    (nth i ulist))))
      (clear-list chlist ulist sval
			  (+ i 1) nchlist nulist))))

(defun check-list (ulist &optional (i 0))
  (if (eql i (length ulist))
    t
    (if (eql (position (nth i ulist) ulist) i)
      (check-list ulist (+ i 1))
      nil)))

(defun search-good (chlist ulist &optional (i 0))
  (if (eql i (length ulist))
    nil
    (let ((niu (nth i ulist))
	  (nic (nth i chlist)))
      (if (and (eql 6 (length niu))
	       (check-list niu)
	       (cycl-check (nth (- (length nic) 1) nic) (nth 0 nic)))
	(nth i chlist)
	(search-good chlist ulist (+ i 1))))))

(defun search-nums (&optional (cur_set 1)
			      (chlist (mapcar 'list (nth 0 sets)))
			      (ulist
				(gen-v-list (list 0) (length (nth 0 sets)))))
  (format t "~A: ~A~%~A~%~%" cur_set chlist ulist)
  (if (eql (read) 'q)
    (return-from search-nums (values chlist ulist)))
  (let ((gv (search-good chlist ulist)))
;    (format t "~A: ~A~%~%" cur_set gv)
    (if gv
      gv
      (multiple-value-call
	(lambda (cl ul)
	  (search-nums (mod (+ cur_set 1) 6)
		       cl ul))
	(multiple-value-call
	  (lambda (cl ul)
	    (clear-list cl ul cur_set))
	  (add-list chlist (nth cur_set sets) ulist cur_set))))))

(case (read)
  ('s (format t "~A~%" sets))
  (otherwise (format t "~A~%" (search-nums))))

;(format t "~A~%" (multiple-value-list (remove-doubles '((1221 2145 4569 6983 8312)
;				(1221 2145 4569 6983 8312 1263)
;				(1221 2145 4569 6983 8312 1212)
;				(1222 2248 4872 7283 8354 5412)
;				(1222 2248 4872 7283 8354 5412)
;				(1222 2248 4872 7283 8354 5412)
;				(1221 2145 4567 6783 8312 1212))
;			      '((0 1 2 3 4)
;				(5 2 4 3 1 0)
;				(3 1 3 2 5 3)
;				(5 2 4 3 1 0)
;				(5 2 4 3 1 0)
;				(5 2 4 3 1 0)
;				(0 2 1 4 5 3)))))

;(format t "~A~%" (search-good '((1221 2145 4569 6983 8312)
;				(1221 2145 4569 6983 8312 1263)
;				(1221 2145 4569 6983 8312 1212)
;				(1222 2248 4872 7283 8354 5412)
;				(1221 2145 4567 6783 8312 1212))
;			      '((0 1 2 3 4)
;				(5 2 4 3 1 0)
;				(3 1 3 2 5 3)
;				(5 2 4 3 1 0)
;				(0 2 1 4 5 3))))

;(format t "~A~%" (multiple-value-list
;		   (multiple-value-call
;		     (lambda (cl ul)
;		       (clear-list cl ul 1))
;		     (add-list '((2321 2342 7452)
;				 (8912)
;				 (3131 2398 1023 1312)
;				 (2347) (5732 4312)
;				 (2389 2432))
;			       (list 1234 5217 5224 6969)
;			       '((0) (0) (0) (0) (1) (1))
;			       1))))

;(format t "~A~%" (multiple-value-list (ins-el '((2321 2342 7452)
;						(8912)
;						(3131 2398 1023 1312)
;						(2347) (5732 4312)
;						(2389 2432))
;					      1234 '((0) (0) (0) (0) (1) (1)) 1)))
