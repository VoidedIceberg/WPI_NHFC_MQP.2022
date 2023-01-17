
(cl:in-package :asdf)

(defsystem "custom_msg_srv_package-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "control_steps" :depends-on ("_package_control_steps"))
    (:file "_package_control_steps" :depends-on ("_package"))
  ))