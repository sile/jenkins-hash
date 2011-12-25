(in-package :jenkins-hash)

(declaim (inline hash-octets)
         (ftype (function (simple-octets &optional u32 u32) (values u32 u32)) hash-octets)

         (inline hash-string)
         (ftype (function (simple-characters &optional u32 u32) (values u32 u32)) hash-string)

         (inline nth-hash)
         (ftype (function (index u32 u32) u32) nth-hash))

(defun hash-octets (octets &optional (initial-value +GOLDEN_RATIO_PRIME+)
                                     (secondary-initial-value 0))
  (declare #.*muffle*)
  (@hash-octets2 octets initial-value secondary-initial-value))

(defun hash-string (str &optional (initial-value +GOLDEN_RATIO_PRIME+)
                                  (secondary-initial-value 0))
  (declare #.*muffle*)
  (@hash-string str initial-value secondary-initial-value))

(defun nth-hash (nth seed1 seed2)
  (double-hash seed1 seed2 nth))
