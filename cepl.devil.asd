(asdf:defsystem #:cepl.devil
  :description "A couple of helper functions to load from devil straight to cepl c-arrays or textures"
  :author "Chris Bagley Baggers <techsnuffle@gmail.com>"
  :license "BSD 2 Clause"
  :serial t
  :depends-on (#:cepl #:cl-devil)
  :components ((:file "package")
               (:file "devil-helper")))
