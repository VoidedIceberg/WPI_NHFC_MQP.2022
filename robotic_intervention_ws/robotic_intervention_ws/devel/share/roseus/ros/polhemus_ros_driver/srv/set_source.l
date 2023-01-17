;; Auto-generated. Do not edit!


(when (boundp 'polhemus_ros_driver::set_source)
  (if (not (find-package "POLHEMUS_ROS_DRIVER"))
    (make-package "POLHEMUS_ROS_DRIVER"))
  (shadow 'set_source (find-package "POLHEMUS_ROS_DRIVER")))
(unless (find-package "POLHEMUS_ROS_DRIVER::SET_SOURCE")
  (make-package "POLHEMUS_ROS_DRIVER::SET_SOURCE"))
(unless (find-package "POLHEMUS_ROS_DRIVER::SET_SOURCEREQUEST")
  (make-package "POLHEMUS_ROS_DRIVER::SET_SOURCEREQUEST"))
(unless (find-package "POLHEMUS_ROS_DRIVER::SET_SOURCERESPONSE")
  (make-package "POLHEMUS_ROS_DRIVER::SET_SOURCERESPONSE"))

(in-package "ROS")





(defclass polhemus_ros_driver::set_sourceRequest
  :super ros::object
  :slots (_source _sensor ))

(defmethod polhemus_ros_driver::set_sourceRequest
  (:init
   (&key
    ((:source __source) 0)
    ((:sensor __sensor) 0)
    )
   (send-super :init)
   (setq _source (round __source))
   (setq _sensor (round __sensor))
   self)
  (:source
   (&optional __source)
   (if __source (setq _source __source)) _source)
  (:sensor
   (&optional __sensor)
   (if __sensor (setq _sensor __sensor)) _sensor)
  (:serialization-length
   ()
   (+
    ;; int64 _source
    8
    ;; int64 _sensor
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _source
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _source (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _source) (= (length (_source . bv)) 2)) ;; bignum
              (write-long (ash (elt (_source . bv) 0) 0) s)
              (write-long (ash (elt (_source . bv) 1) -1) s))
             ((and (class _source) (= (length (_source . bv)) 1)) ;; big1
              (write-long (elt (_source . bv) 0) s)
              (write-long (if (>= _source 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _source s)(write-long (if (>= _source 0) 0 #xffffffff) s)))
     ;; int64 _sensor
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _sensor (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _sensor) (= (length (_sensor . bv)) 2)) ;; bignum
              (write-long (ash (elt (_sensor . bv) 0) 0) s)
              (write-long (ash (elt (_sensor . bv) 1) -1) s))
             ((and (class _sensor) (= (length (_sensor . bv)) 1)) ;; big1
              (write-long (elt (_sensor . bv) 0) s)
              (write-long (if (>= _sensor 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _sensor s)(write-long (if (>= _sensor 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _source
#+(or :alpha :irix6 :x86_64)
      (setf _source (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _source (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _sensor
#+(or :alpha :irix6 :x86_64)
      (setf _sensor (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _sensor (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(defclass polhemus_ros_driver::set_sourceResponse
  :super ros::object
  :slots (_success ))

(defmethod polhemus_ros_driver::set_sourceResponse
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

(defclass polhemus_ros_driver::set_source
  :super ros::object
  :slots ())

(setf (get polhemus_ros_driver::set_source :md5sum-) "a11e7ea3e225df8a203dc448504ef4dd")
(setf (get polhemus_ros_driver::set_source :datatype-) "polhemus_ros_driver/set_source")
(setf (get polhemus_ros_driver::set_source :request) polhemus_ros_driver::set_sourceRequest)
(setf (get polhemus_ros_driver::set_source :response) polhemus_ros_driver::set_sourceResponse)

(defmethod polhemus_ros_driver::set_sourceRequest
  (:response () (instance polhemus_ros_driver::set_sourceResponse :init)))

(setf (get polhemus_ros_driver::set_sourceRequest :md5sum-) "a11e7ea3e225df8a203dc448504ef4dd")
(setf (get polhemus_ros_driver::set_sourceRequest :datatype-) "polhemus_ros_driver/set_sourceRequest")
(setf (get polhemus_ros_driver::set_sourceRequest :definition-)
      "int64 source
int64 sensor
---

bool success   # indicate successful run of setting source for a sensor
")

(setf (get polhemus_ros_driver::set_sourceResponse :md5sum-) "a11e7ea3e225df8a203dc448504ef4dd")
(setf (get polhemus_ros_driver::set_sourceResponse :datatype-) "polhemus_ros_driver/set_sourceResponse")
(setf (get polhemus_ros_driver::set_sourceResponse :definition-)
      "int64 source
int64 sensor
---

bool success   # indicate successful run of setting source for a sensor
")



(provide :polhemus_ros_driver/set_source "a11e7ea3e225df8a203dc448504ef4dd")


