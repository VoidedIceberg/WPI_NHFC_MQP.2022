;; Auto-generated. Do not edit!


(when (boundp 'polhemus_ros_driver::calibrate)
  (if (not (find-package "POLHEMUS_ROS_DRIVER"))
    (make-package "POLHEMUS_ROS_DRIVER"))
  (shadow 'calibrate (find-package "POLHEMUS_ROS_DRIVER")))
(unless (find-package "POLHEMUS_ROS_DRIVER::CALIBRATE")
  (make-package "POLHEMUS_ROS_DRIVER::CALIBRATE"))
(unless (find-package "POLHEMUS_ROS_DRIVER::CALIBRATEREQUEST")
  (make-package "POLHEMUS_ROS_DRIVER::CALIBRATEREQUEST"))
(unless (find-package "POLHEMUS_ROS_DRIVER::CALIBRATERESPONSE")
  (make-package "POLHEMUS_ROS_DRIVER::CALIBRATERESPONSE"))

(in-package "ROS")





(defclass polhemus_ros_driver::calibrateRequest
  :super ros::object
  :slots ())

(defmethod polhemus_ros_driver::calibrateRequest
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

(defclass polhemus_ros_driver::calibrateResponse
  :super ros::object
  :slots (_success ))

(defmethod polhemus_ros_driver::calibrateResponse
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

(defclass polhemus_ros_driver::calibrate
  :super ros::object
  :slots ())

(setf (get polhemus_ros_driver::calibrate :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get polhemus_ros_driver::calibrate :datatype-) "polhemus_ros_driver/calibrate")
(setf (get polhemus_ros_driver::calibrate :request) polhemus_ros_driver::calibrateRequest)
(setf (get polhemus_ros_driver::calibrate :response) polhemus_ros_driver::calibrateResponse)

(defmethod polhemus_ros_driver::calibrateRequest
  (:response () (instance polhemus_ros_driver::calibrateResponse :init)))

(setf (get polhemus_ros_driver::calibrateRequest :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get polhemus_ros_driver::calibrateRequest :datatype-) "polhemus_ros_driver/calibrateRequest")
(setf (get polhemus_ros_driver::calibrateRequest :definition-)
      "
---

bool success   # indicate successful run of making settings persistent
")

(setf (get polhemus_ros_driver::calibrateResponse :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get polhemus_ros_driver::calibrateResponse :datatype-) "polhemus_ros_driver/calibrateResponse")
(setf (get polhemus_ros_driver::calibrateResponse :definition-)
      "
---

bool success   # indicate successful run of making settings persistent
")



(provide :polhemus_ros_driver/calibrate "358e233cde0c8a8bcfea4ce193f8fc15")


