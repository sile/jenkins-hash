(in-package :jenkins-hash)

(declaim (inline hash-octets)
         (ftype (function (simple-octets &key (:start index) (:end index)
                                              (:seed1 u32) (:seed2 u32)) (values u32 u32)) 
                hash-octets)

         (inline hash-string)
         (ftype (function (simple-characters &key (:start index) (:end index)
                                                  (:seed1 u32) (:seed2 u32)) (values u32 u32))
                hash-string)

         (inline nth-hash)
         (ftype (function (index u32 u32) u32) nth-hash))

(defun hash-octets (octets &key (start 0) (end (length octets)) 
                                (seed1 +GOLDEN_RATIO_PRIME+) (seed2 0))
  (declare #.*muffle*)
  (assert (<= start end (length octets)))
  (@hash-octets2 octets start end seed1 seed2))

(defun hash-string (str &key (start 0) (end (length str))
                             (seed1 +GOLDEN_RATIO_PRIME+) (seed2 0))
  (declare #.*muffle*)
  (assert (<= start end (length str)))
  (@hash-string str start end seed1 seed2))

(defun nth-hash (nth hashcode1 hashcode2)
  (double-hash hashcode1 hashcode2 nth))
