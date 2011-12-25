(in-package :asdf)

(defsystem jenkins-hash
  :name "jenkins-hash"
  :version "0.0.2"
  :author "Takeru Ohta"
  :description "jenkins hash function (http://burtleburtle.net/bob/hash/doobs.html)"
  
  :serial t
  :components ((:file "package")
               (:file "common")
               (:file "hash-octets")
               (:file "hash-string")
               (:file "hash")))
