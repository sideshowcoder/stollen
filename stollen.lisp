;; Mandelbrot implementation in CL
;;
;; Stollen is the german word for a special cake containing Almonds, which are
;; called Mandeln in german.

(ql:quickload "zpng")

(defpackage :stollen
  (:use :cl :zpng))

(in-package :stollen)

;; todo create macro with-image creating an instace of the png and passing the image data-array to the function
;; todo wrap this in a function
;; todo optimize as this takes ages

(let* ((size 100)
       (png (make-instance 'png
                          :color-type :grayscale-alpha
                          :width size
                          :height size))
       (image (data-array png))
       (max 100))
  (loop for x from 0 to (- size 1)
     do (loop for y from 0 to (- size 1)
           do (let ((c (complex (- (/ x 100.0) 1.5) (- (/ y 100.0) 1.5)))
                    (z (complex 0.0 0.0))
                    (iteration 0))
                (progn 
                  (loop
                     (setf z (+ (* z z) c))
                     (incf iteration)
                     (cond ((< 4 (abs z))
                            (setf (aref image x y 1) iteration)
                            (return))
                           ((= iteration max)
                            (setf (aref image x y 1) 255)
                            (return))))
                  (write-png png "mandelbrot.png"))))))
                           
                          
             
         
  
    
  

