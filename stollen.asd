(asdf:defsystem #:stollen
  :description "Mandelbrot CL implementation"
  :author "Philipp Fehre <philipp@fehre.co.uk>"
  :license "MIT"
  :depends-on (#:zpng)
  :serial t
  :components ((:file "package")
               (:file "stollen")))

