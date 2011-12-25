(in-package :jenkins-hash)

(declaim (inline hash-octets)
         (ftype (function (simple-octets &key (:seed1 u32) (:seed2 u32)) (values u32 u32)) 
                hash-octets)

         (inline hash-string)
         (ftype (function (simple-characters &key (:seed1 u32) (:seed2 u32)) (values u32 u32))
                hash-string)

         (inline nth-hash)
         (ftype (function (index u32 u32) u32) nth-hash))

(defun hash-octets (octets &key (seed1 +GOLDEN_RATIO_PRIME+) (seed2 0))
  (declare #.*muffle*)
  (@hash-octets2 octets seed1 seed2))

(defun hash-string (str &key (seed1 +GOLDEN_RATIO_PRIME+) (seed2 0))
  (declare #.*muffle*)
  (@hash-string str seed1 seed2))

(defun nth-hash (nth hashcode1 hashcode2)
  (double-hash hashcode1 hashcode2 nth))
