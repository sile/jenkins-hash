;; TODO: util => common
(in-package :jenkins-hash)

(declaim (inline u32 rot))

;; auxiliary
(defun u32 (n)
  (ldb (byte 32 0) n))

(defun rot (x k)
  (logior (ash x k) (ash x (- k 32))))

;;; mix          
(defmacro mix-one (a b c n)
  `(setf ,a (u32 (- ,a ,c))
         ,a (u32 (logxor ,a (rot ,c ,n)))
         ,c (u32 (+ ,c ,b))))

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


;;; final
(defmacro final-one (a b n)
  `(setf ,a (u32 (- (logxor ,a ,b) (rot ,b ,n)))))

(defmacro final (a b c)
  `(locally
    (declare #.*fastest*
             (u32 ,a ,b ,c))
    (final-one ,c ,b 14)
    (final-one ,a ,c 11)
    (final-one ,b ,a 25)
    (final-one ,c ,b 16)
    (final-one ,a ,c 04)
    (final-one ,b ,a 14)
    (final-one ,c ,b 24)))

(defmacro incf-u32 (place delta)
  `(setf ,place (u32 (+ ,place ,delta))))

;;; TODO: hashword, hashword2
