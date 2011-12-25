(defpackage jenkins-hash
  (:use :common-lisp)
  (:shadow :common-lisp hash)
  (:export hash-octets
           hash-string
           hash-u32-array
           double-hash
           hash)) ; XXX: delete
(in-package :jenkins-hash)

(deftype u32 () '(unsigned-byte 32))
(deftype array-index () '(unsigned-byte 24)) ; XXX:
(deftype index () '(unsigned-byte 24)) ; XXX:

(deftype u8 () '(unsigned-byte 8))
(deftype simple-octets () '(simple-array u8))

(deftype simple-u32-array () '(simple-array u32))

(deftype simple-characters () '(simple-array character))

(defparameter *fastest* '(optimize (speed 3) (safety 0) (debug 0) (compilation-speed 0)))
(defparameter *muffle* #+SBCL '(sb-ext:muffle-conditions sb-ext:compiler-note)
                       #-SBCL '())

(defconstant +INIT_MAGIC+ #xDEADBEEF)