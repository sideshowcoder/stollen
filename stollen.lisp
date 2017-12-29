(in-package #:stollen)

(defun point-value (x y &key transpose-x transpose-y scale (max 255))
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

(defun create-png (width height &key transpose-x transpose-y scale)
  (let* ((png (make-instance 'png
                             :color-type :grayscale-alpha
                             :width width
                             :height height))
         (data (data-array png)))
    (loop for x from 0 to (- height 1)
       do (loop for y from 0 to (- width 1)
             do (setf (aref data x y 1) (point-value x y
                                                     :transpose-y transpose-y
                                                     :transpose-x transpose-x
                                                     :scale scale))))
    png))

(defun draw-png (path &key width height (transpose-x 1.5) (transpose-y 1.8) (scale 1.0))
  (write-png
   (create-png width height
               :transpose-x transpose-x
               :transpose-y transpose-y
               :scale scale) path))
