(setf *bfrac* (/ 3 7))
(setf *mfrac* (expt 10 6))

(defun display (arg)
  (format t "~A" arg))
(defun displayln (arg)
  (format t "~A~%" arg))
(defun nl ()
  (format t "~%"))

(defun lsb (x y b)
  (and
    (< x y)
    (< (/ x y) b)))

(defun chd (x y b)
  (= (gcd x y) 1))

(defun chk (x y b)
  (and (lsb x y b)
       (chd x y b)))

(defun findMCFrac (mx brd cd cc)
  (if (or
	(> cd mx)
	(> (/ cd mx)
	   brd))
    cc
    (findMCFrac
      mx brd
      (+ cd 1)
      (let ((nf
	      (checkNum
		cd brd mx cd
		(cons cd mx) 1)))
	(if (chk (car nf) (cdr nf) brd)
	  (maxFrac nf cc)
	  cc)))))

(defun maxFrac (f1 f2)
  (if (> (/
	   (car f1) (cdr f1))
	 (/
	   (car f2) (cdr f2)))
    f1
    f2))

(defun checkNum (num brd mx mn mxv mnv)
;  (displayln (cons num (cons mx mn)))
  (if (< (- mx mn) 2)
    (if (chk num mx brd)
      (cons num mx)
      (cons num mn))
    (let*
      ((np (floor (+ mx mn) 2))
       (npv (/ num np)))
      (if (lsb num np brd)
	  (checkNum
	    num brd np
	    mn npv mnv)
	(checkNum
	  num brd mx
	  np mxv npv)))))

(displayln (findMCFrac 1000000 *bfrac* 1 (cons 0 1)))

;(defun getCFrac (den num mx brd stp)
;  (if (eql stp 1)
;    (cons den num)
;    (if (> (/ den num) brd)
;      (getCFrac
;	den
;	(+ num stp)
;	mx brd
;	(floor stp 2))
;      (getCFrac
;	den
;	(- num stp)
;	mx brd
;	(floor stp 2)))))
;
;(defun getMCFrac (cden mx brd cmax)
;  (if (> cden mx)
;    cmax
;    (let ((cf (getCFrac
;		cden
;		(floor (- mx cden) 2)
;		mx brd
;		(floor mx 2)))
;	  (f (car fc))
;	  (s (car cf)))
;      (if (and (chk f s brd)
;	       (> (/ f s)
;		  (/
;		    (car cmax)
;		    (car cmax))))
;	(getMCFrac (+ cden 1) mx brd cf)
;	(getMCFrac (+ cden 1) mx brd cmax)))))
;
;(setf cbrd 10)
;(setf cnum 2)
;
;(displayln (getCFrac
;	     cnum
;	     (floor cbrd 2)
;	     cbrd *bfrac*
;	     (ceiling cbrd 4)))

;(defun getFracs (d n m frs)
;  (if (> n m)
;    frs
;    (if (chk d n *bfrac*)
;      (getFracs
;	d (+ n 1)
;	m (cons (/ d n) frs))
;      (getFracs d (+ n 1) m frs))))
;
;(defun genFracs (n m frs)
;  (if (> n m)
;    frs
;    (if (> (/ n m) *bfrac*)
;      frs
;      (genFracs
;	(+ n 1)
;	m
;	(append
;	  frs
;	  (getFracs n (+ n 1)
;		    m
;		    '()))))))

;(displayln (car (last (sort (genFracs 1 (read) '()) '<))))

;(setf tvs '(100 500 1000 5000))
;(defun testv (v)
;  (displayln (time (sort (genFracs 1 v '()) '<))))
;
;(defun testvs (vs)
;  (if (null vs)
;    'done
;    (progn
;      (testv (car vs))
;      (testvs (cdr vs)))))
;
;(testvs tvs)
