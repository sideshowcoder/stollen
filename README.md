# stollen

Mandelbrot images

# Run

using quicklisp and putting it in `~/quicklisp/local-projects` this can be
loaded via `(ql:quickload "stollen")` creating an image via

```
CL-USER> (draw-png "~/Desktop/test.png" :width 300 :height 400)
```

Will create an image on your desktop.


# Todos

- [ ] create a mandelbrot server via hunchentoot
  https://en.wikibooks.org/wiki/Common_Lisp/External_libraries/Hunchentoot take
  the draw-png params as parameters and return the image.
- [ ] create a seperate server component for this

