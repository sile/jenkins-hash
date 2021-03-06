(in-package :jenkins-hash)

(defun @hash-string (str start end init-primary init-secondary &aux (len (- end start)))
  (declare #.*fastest*
           (simple-characters str)
           (u32 init-primary init-secondary)
           (index start end len))
  (let* ((a (u32 (+ +INIT_MAGIC+ (ash len 2) init-primary)))
         (b a)
         (c (u32 (+ a init-secondary))))
    (declare (u32 a b c))
    
    (loop FOR i FROM start BELOW (- end 3) BY 3
      DO
      (incf-u32 a (char-code (aref str (+ i 0))))
      (incf-u32 b (char-code (aref str (+ i 1))))
      (incf-u32 c (char-code (aref str (+ i 2))))
      (mix a b c)

      FINALLY
      (tagbody
       (case (the (mod 4) (- end i))
         (3 (go :3))
         (2 (go :2))
         (1 (go :1))
         (0 (go :return)))

       :3 (incf-u32 c (char-code (aref str (+ i 2)))) (go :2)
       :2 (incf-u32 b (char-code (aref str (+ i 1)))) (go :1)
       :1 (incf-u32 a (char-code (aref str (+ i 0))))
       (final a b c)

       :return (return (values c b))))))
