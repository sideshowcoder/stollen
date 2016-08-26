;; Mandelbrot implementation in CL
;;
;; Stollen is the german word for a special cake containing Almonds, which are
;; called Mandeln in german.

(ql:quickload "zpng")

;; todo need to create a proper package that is installable in asdf
;; todo checkout https://github.com/xach/quickproject/ for that
;; todo put this in ~/quicklisp/local-projects

(defpackage :stollen
  (:use :cl :zpng)
  (:export :draw-mandelbrot))

(in-package :stollen)

;; todo optimize as this takes ages
;; todo don't write the png every loop but just once at the end
;; todo make this colorfull
;; todo make the macro a normal function calling a render-pixel function for each pixel coordinate
;; todo make this multicore

(defmacro with-png-data (size path data &body body)
  (let ((png (gensym)))
    `(let* ((,png (make-instance 'png
                              :color-type :grayscale-alpha
                              :width ,size
                              :height ,size))
          (,data (data-array ,png)))
       (progn ,@body (write-png ,png ,path)))))

(defun draw-mandelbrot ()
  (let ((size 300)
        (max 100))
    (with-png-data size "mandelbrot.png" image
      (loop for x from 0 to (- size 1)
         do (loop for y from 0 to (- size 1)
               do (let ((c (complex (- (/ x 100.0) 1.5) (- (/ y 100.0) 1.5)))
                        (z (complex 0.0 0.0))
                        (iteration 0))
                    (progn 
                      (loop
                         (setf z (+ (expt z 2) c))
                         (incf iteration)
                         (cond ((< 4 (abs z))
                                (setf (aref image x y 1) iteration)
                                (return))
                               ((= iteration max)
                                (setf (aref image x y 1) 255)
                                (return)))))))))))

      


