(in-package #:stollen)

(defun calculate-mandelbrot (x y max &key transpose-x transpose-y scale)
  (let ((c (complex (- (/ x (* 100.0 scale)) transpose-x) (- (/ y (* 100.0 scale)) transpose-y)))
        (z (complex 0.0 0.0))
        (i 0))
    (loop
       (setf z (+ (expt z 2) c))
       (incf i)
       (cond ((< 4 (abs z))
              (return i))
             ((= i max)
              (return 255))))))

(defun mandelbrot-png (w h &key transpose-x transpose-y scale)
  (let* ((png (make-instance 'png
                             :color-type :grayscale-alpha
                             :width w
                             :height h))
         (data (data-array png)))
    (loop for x from 0 to (- h 1)
       do (loop for y from 0 to (- w 1)
             do (setf (aref data x y 1) (calculate-mandelbrot x y 255
                                                              :transpose-y transpose-y
                                                              :transpose-x transpose-x
                                                              :scale scale))))
    png))

;; Generate some images
(write-png
 (mandelbrot-png 1500 1000 :transpose-x 1.0 :transpose-y 1.0 :scale 10)
 "~/Desktop/test.png")
