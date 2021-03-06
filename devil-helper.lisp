(in-package :cepl.devil)

(defun load-image-to-c-array (filename)
  (cl-devil:with-init
    (cl-devil:with-images ((a filename))
      (declare (ignore a))
      (cl-devil:check-error)
      (let* ((height (cl-devil:image-height))
             (width (cl-devil:image-width))
             (data-cpy (cffi:foreign-alloc :uint8-vec4 :count (* height width))))
        (cl-devil:copy-pixels 0 0 0 (cl-devil:image-width) (cl-devil:image-height) 1
                              :rgba :unsigned-byte data-cpy)
        (cepl:make-c-array-from-pointer (list width height)
                                       :uint8-vec4 data-cpy)))))

(defun load-image-to-texture (filename &optional (image-format :rgba8) mipmap
					 generate-mipmaps)
  (let* ((array (load-image-to-c-array filename))
	 (pixel-format (cepl:lisp-type->pixel-format :uint8-vec4))
	 (texture (cepl:make-texture
		   array
		   :element-type image-format
		   :pixel-format pixel-format
		   :mipmap mipmap
		   :generate-mipmaps generate-mipmaps)))
    (cepl:free-c-array array)
    texture))
