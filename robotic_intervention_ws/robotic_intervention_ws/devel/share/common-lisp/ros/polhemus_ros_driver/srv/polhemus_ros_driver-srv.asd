
(cl:in-package :asdf)

(defsystem "polhemus_ros_driver-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "calibrate" :depends-on ("_package_calibrate"))
    (:file "_package_calibrate" :depends-on ("_package"))
    (:file "persist" :depends-on ("_package_persist"))
    (:file "_package_persist" :depends-on ("_package"))
    (:file "set_source" :depends-on ("_package_set_source"))
    (:file "_package_set_source" :depends-on ("_package"))
  ))