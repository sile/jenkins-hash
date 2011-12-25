(in-package :jenkins-hash)

(declaim (inline u32 rot))

(defun u32 (n)
  (ldb (byte 32 0) n))

(defun rot (x k)
  (logior (ash x k) (ash x (- k 32))))
          
(defmacro mix-one (a b c n)
  `(progn
     (setf ,a (u32 (- ,a ,c)))
     (setf ,a (u32 (logxor ,a (rot ,c ,n))))
     (setf ,c (u32 (+ ,c ,b)))))

(defmacro mix (a b c)
  `(locally
    (declare #.*fastest*
             (u32 ,a ,b ,c))
    (mix-one ,a ,b ,c 04)
    (mix-one ,b ,c ,a 06)
    (mix-one ,c ,a ,b 08)
    (mix-one ,a ,b ,c 16)
    (mix-one ,b ,c ,a 19)
    (mix-one ,c ,a ,b 04)))
