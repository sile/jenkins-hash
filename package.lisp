(defpackage jenkins-hash
  (:use :common-lisp)
  (:shadow :common-lisp hash)
  (:export hash))
(in-package :jenkins-hash)

(deftype u32 () '(unsigned-byte 32))
(deftype i32 () '(signed-byte 32))

(defparameter *fastest* '(optimize (speed 3) (safety 0) (debug 0) (compilation-speed 0)))
