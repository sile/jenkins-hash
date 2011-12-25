(in-package :jenkins-hash)

(defmacro ref-uint (octets start width)
  `(logior ,@(loop FOR i FROM 0 BELOW width 
                   COLLECT `(ash (aref ,octets (+ ,start ,i)) ,(* i 8)))))

(defun @hash-octets2 (octets init-primary init-secondary &aux (len (length octets)))
  (declare #.*fastest*
           (simple-octets octets)
           (u32 init-primary init-secondary)
           (index len))
  (let* ((a (u32 (+ +INIT_MAGIC+ len init-primary)))
         (b a)
         (c (u32 (+ a init-secondary))))
    (declare (u32 a b c))
    
    (loop FOR i FROM 0 BELOW (- len 12) BY 12
      DO
      (incf-u32 a (ref-uint octets (+ i 0) 4))
      (incf-u32 b (ref-uint octets (+ i 4) 4))
      (incf-u32 c (ref-uint octets (+ i 8) 4))
      (mix a b c)

      FINALLY
      (tagbody
       (case (- len i)
         (12 (go :12)) (11 (go :11)) (10 (go :10)) (09 (go :09))
         (08 (go :08)) (07 (go :07)) (06 (go :06)) (05 (go :05))
         (04 (go :04)) (03 (go :03)) (02 (go :02)) (01 (go :01))
         (00 (go :return)))

       :12 (incf-u32 c (ref-uint octets (+ i 8) 4)) (go :08)
       :11 (incf-u32 c (ref-uint octets (+ i 8) 3)) (go :08)
       :10 (incf-u32 c (ref-uint octets (+ i 8) 2)) (go :08)
       :09 (incf-u32 c (ref-uint octets (+ i 8) 1)) 
       :08 (incf-u32 b (ref-uint octets (+ i 4) 4)) (go :04)
       :07 (incf-u32 b (ref-uint octets (+ i 4) 3)) (go :04)
       :06 (incf-u32 b (ref-uint octets (+ i 4) 2)) (go :04)
       :05 (incf-u32 b (ref-uint octets (+ i 4) 1))
       :04 (incf-u32 a (ref-uint octets (+ i 0) 4)) (go :final)
       :03 (incf-u32 a (ref-uint octets (+ i 0) 3)) (go :final)
       :02 (incf-u32 a (ref-uint octets (+ i 0) 2)) (go :final)
       :01 (incf-u32 a (ref-uint octets (+ i 0) 1))
       
       :final (final a b c)

       :return (return (values c b))))))
