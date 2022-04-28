#|
 This file is a part of Alloy
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(defpackage #:org.shirakumo.alloy.renderers.opengl.png
  (:use #:cl)
  (:local-nicknames
   (#:alloy #:org.shirakumo.alloy)
   (#:opengl #:org.shirakumo.alloy.renderers.opengl)
   (#:simple #:org.shirakumo.alloy.renderers.simple))
  (:export
   #:renderer))
(in-package #:org.shirakumo.alloy.renderers.opengl.png)

(defclass renderer (opengl:renderer)
  ())

(defmethod simple:request-image ((renderer renderer) (data pathname) &key)
  (cond ((string-equal "png" (pathname-type data))
         (pngload:with-png-in-static-vector (png data :flip-y T)
           (opengl:make-texture renderer (pngload:width png) (pngload:height png) (pngload:data png))))
        (T (call-next-method))))