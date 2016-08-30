# stollen

Mandelbrot images

# Run

using quicklisp and putting it in `~/quicklisp/local-projects` this can be
loaded via `(ql:quickload "stollen")` creating an image via

```
CL-USER> (draw-mandelbrot #p"~/mandelbrot.png")
```

Will create an image in your home directory.
