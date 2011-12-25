(in-package :asdf)

(defsystem jenkins-hash
  :name "jenkins-hash"
  :version "0.0.1"
  :author "Takeru Ohta"
  :description "jenkins hash function (http://burtleburtle.net/bob/hash/doobs.html)"
  
  :serial t
  :components ((:file "package")
               (:file "byte-order")
               (:file "utils")
               (:file "hash-little")
               (:file "hash")))
