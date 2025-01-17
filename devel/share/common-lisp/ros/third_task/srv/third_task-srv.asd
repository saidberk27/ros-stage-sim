
(cl:in-package :asdf)

(defsystem "third_task-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Distance" :depends-on ("_package_Distance"))
    (:file "_package_Distance" :depends-on ("_package"))
  ))