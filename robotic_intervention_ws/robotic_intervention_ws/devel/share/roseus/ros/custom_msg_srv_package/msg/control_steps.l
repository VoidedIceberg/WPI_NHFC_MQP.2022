;; Auto-generated. Do not edit!


(when (boundp 'custom_msg_srv_package::control_steps)
  (if (not (find-package "CUSTOM_MSG_SRV_PACKAGE"))
    (make-package "CUSTOM_MSG_SRV_PACKAGE"))
  (shadow 'control_steps (find-package "CUSTOM_MSG_SRV_PACKAGE")))
(unless (find-package "CUSTOM_MSG_SRV_PACKAGE::CONTROL_STEPS")
  (make-package "CUSTOM_MSG_SRV_PACKAGE::CONTROL_STEPS"))

(in-package "ROS")
;;//! \htmlinclude control_steps.msg.html


(defclass custom_msg_srv_package::control_steps
  :super ros::object
  :slots (_linear_steps _angular_steps ))

(defmethod custom_msg_srv_package::control_steps
  (:init
   (&key
    ((:linear_steps __linear_steps) 0)
    ((:angular_steps __angular_steps) 0)
    )
   (send-super :init)
   (setq _linear_steps (round __linear_steps))
   (setq _angular_steps (round __angular_steps))
   self)
  (:linear_steps
   (&optional __linear_steps)
   (if __linear_steps (setq _linear_steps __linear_steps)) _linear_steps)
  (:angular_steps
   (&optional __angular_steps)
   (if __angular_steps (setq _angular_steps __angular_steps)) _angular_steps)
  (:serialization-length
   ()
   (+
    ;; int64 _linear_steps
    8
    ;; int64 _angular_steps
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _linear_steps
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _linear_steps (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _linear_steps) (= (length (_linear_steps . bv)) 2)) ;; bignum
              (write-long (ash (elt (_linear_steps . bv) 0) 0) s)
              (write-long (ash (elt (_linear_steps . bv) 1) -1) s))
             ((and (class _linear_steps) (= (length (_linear_steps . bv)) 1)) ;; big1
              (write-long (elt (_linear_steps . bv) 0) s)
              (write-long (if (>= _linear_steps 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _linear_steps s)(write-long (if (>= _linear_steps 0) 0 #xffffffff) s)))
     ;; int64 _angular_steps
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _angular_steps (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _angular_steps) (= (length (_angular_steps . bv)) 2)) ;; bignum
              (write-long (ash (elt (_angular_steps . bv) 0) 0) s)
              (write-long (ash (elt (_angular_steps . bv) 1) -1) s))
             ((and (class _angular_steps) (= (length (_angular_steps . bv)) 1)) ;; big1
              (write-long (elt (_angular_steps . bv) 0) s)
              (write-long (if (>= _angular_steps 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _angular_steps s)(write-long (if (>= _angular_steps 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _linear_steps
#+(or :alpha :irix6 :x86_64)
      (setf _linear_steps (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _linear_steps (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _angular_steps
#+(or :alpha :irix6 :x86_64)
      (setf _angular_steps (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _angular_steps (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(setf (get custom_msg_srv_package::control_steps :md5sum-) "51d557b1f317b489bd121f68c2b0a5e9")
(setf (get custom_msg_srv_package::control_steps :datatype-) "custom_msg_srv_package/control_steps")
(setf (get custom_msg_srv_package::control_steps :definition-)
      "int64 linear_steps
int64 angular_steps

")



(provide :custom_msg_srv_package/control_steps "51d557b1f317b489bd121f68c2b0a5e9")


