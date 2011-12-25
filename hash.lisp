(in-package :jenkins-hash)

(declaim (inline hash-octets)
         (ftype (function (simple-octets &optional u32 u32) (values u32 u32)) hash-octets)

         (inline double-hash)
         (ftype (function (u32 u32 index) u32) double-hash))

(defun hash-octets (octets &optional (initial-value 7) (secondary-initial-value 0))
  (declare #.*muffle*)
  (@hash-octets2 octets initial-value secondary-initial-value))

(defun hash-string (str)
  (declare (ignore str))
  )

(defun hash-u32-array (u32-array)
  (declare (ignore u32-array))
  )

(defun double-hash (hashcode-1 hashcode-2 nth)
  (u32 (+ hashcode-1 (* hashcode-2 nth))))
