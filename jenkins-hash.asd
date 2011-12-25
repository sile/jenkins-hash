(in-package :asdf)

(defsystem jenkins-hash
  :name "jenkins-hash"
  :version "0.0.1"
  :author "Takeru Ohta"
  :description "jenkins hash function (http://burtleburtle.net/bob/hash/doobs.html)"
  
  :serial t
  :components ((:file "package")
               (:file "utils")
               (:file "hash-octets")
               (:file "hash-u32-array")
               (:file "hash-string")
               (:file "hash")))
