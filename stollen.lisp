(in-package #:stollen)

;; todo optimize as this takes ages
;; todo don't write the png every loop but just once at the end
;; todo make this colorful
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

(defun calculate-mandelbrot (x y max)
  (let ((c (complex (- (/ x 100.0) 1.5) (- (/ y 100.0) 1.5)))
        (z (complex 0.0 0.0))
        (i 0))
    (loop
       (setf z (+ (expt z 2) c))
       (incf i)
       (cond ((< 4 (abs z))
              (return i))
             ((= i max)
              (return 255))))))

(defun draw-mandelbrot (path)
  (let ((size 300))
    (with-png-data size path image
      (loop for x from 0 to (- size 1)
         do (loop for y from 0 to (- size 1)
               do (setf (aref image x y 1) (calculate-mandelbrot x y 100)))))))



