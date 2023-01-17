;; Auto-generated. Do not edit!


(when (boundp 'polhemus_ros_driver::persist)
  (if (not (find-package "POLHEMUS_ROS_DRIVER"))
    (make-package "POLHEMUS_ROS_DRIVER"))
  (shadow 'persist (find-package "POLHEMUS_ROS_DRIVER")))
(unless (find-package "POLHEMUS_ROS_DRIVER::PERSIST")
  (make-package "POLHEMUS_ROS_DRIVER::PERSIST"))
(unless (find-package "POLHEMUS_ROS_DRIVER::PERSISTREQUEST")
  (make-package "POLHEMUS_ROS_DRIVER::PERSISTREQUEST"))
(unless (find-package "POLHEMUS_ROS_DRIVER::PERSISTRESPONSE")
  (make-package "POLHEMUS_ROS_DRIVER::PERSISTRESPONSE"))

(in-package "ROS")





(defclass polhemus_ros_driver::persistRequest
  :super ros::object
  :slots ())

(defmethod polhemus_ros_driver::persistRequest
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass polhemus_ros_driver::persistResponse
  :super ros::object
  :slots (_success ))

(defmethod polhemus_ros_driver::persistResponse
  (:init
   (&key
    ((:success __success) nil)
    )
   (send-super :init)
   (setq _success __success)
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass polhemus_ros_driver::persist
  :super ros::object
  :slots ())

(setf (get polhemus_ros_driver::persist :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get polhemus_ros_driver::persist :datatype-) "polhemus_ros_driver/persist")
(setf (get polhemus_ros_driver::persist :request) polhemus_ros_driver::persistRequest)
(setf (get polhemus_ros_driver::persist :response) polhemus_ros_driver::persistResponse)

(defmethod polhemus_ros_driver::persistRequest
  (:response () (instance polhemus_ros_driver::persistResponse :init)))

(setf (get polhemus_ros_driver::persistRequest :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get polhemus_ros_driver::persistRequest :datatype-) "polhemus_ros_driver/persistRequest")
(setf (get polhemus_ros_driver::persistRequest :definition-)
      "---

bool success   # indicate successful run of calibration
")

(setf (get polhemus_ros_driver::persistResponse :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get polhemus_ros_driver::persistResponse :datatype-) "polhemus_ros_driver/persistResponse")
(setf (get polhemus_ros_driver::persistResponse :definition-)
      "---

bool success   # indicate successful run of calibration
")



(provide :polhemus_ros_driver/persist "358e233cde0c8a8bcfea4ce193f8fc15")


