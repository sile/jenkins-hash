;# <- バイトオーダー判定用文字列
(in-package :jenkins-hash)

(eval-when (:compile-toplevel :load-toplevel)
  (defun guess-byte-order (sample-file)
    (with-open-file (1byte sample-file :element-type '(unsigned-byte 8))
      (with-open-file (2byte sample-file :element-type '(unsigned-byte 16))
        (if (= (read-byte 2byte)
               (+ (ash (read-byte 1byte) 8) (read-byte 1byte)))
            :big-endian
          :little-endian)))))

(defconstant +NATIVE_BYTE_ORDER+ 
  (guess-byte-order (or *compile-file-pathname* *load-pathname*)))
