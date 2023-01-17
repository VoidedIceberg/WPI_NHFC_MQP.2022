; Auto-generated. Do not edit!


(cl:in-package custom_msg_srv_package-msg)


;//! \htmlinclude control_steps.msg.html

(cl:defclass <control_steps> (roslisp-msg-protocol:ros-message)
  ((linear_steps
    :reader linear_steps
    :initarg :linear_steps
    :type cl:integer
    :initform 0)
   (angular_steps
    :reader angular_steps
    :initarg :angular_steps
    :type cl:integer
    :initform 0))
)

(cl:defclass control_steps (<control_steps>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <control_steps>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'control_steps)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name custom_msg_srv_package-msg:<control_steps> is deprecated: use custom_msg_srv_package-msg:control_steps instead.")))

(cl:ensure-generic-function 'linear_steps-val :lambda-list '(m))
(cl:defmethod linear_steps-val ((m <control_steps>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msg_srv_package-msg:linear_steps-val is deprecated.  Use custom_msg_srv_package-msg:linear_steps instead.")
  (linear_steps m))

(cl:ensure-generic-function 'angular_steps-val :lambda-list '(m))
(cl:defmethod angular_steps-val ((m <control_steps>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msg_srv_package-msg:angular_steps-val is deprecated.  Use custom_msg_srv_package-msg:angular_steps instead.")
  (angular_steps m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <control_steps>) ostream)
  "Serializes a message object of type '<control_steps>"
  (cl:let* ((signed (cl:slot-value msg 'linear_steps)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'angular_steps)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <control_steps>) istream)
  "Deserializes a message object of type '<control_steps>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'linear_steps) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'angular_steps) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<control_steps>)))
  "Returns string type for a message object of type '<control_steps>"
  "custom_msg_srv_package/control_steps")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'control_steps)))
  "Returns string type for a message object of type 'control_steps"
  "custom_msg_srv_package/control_steps")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<control_steps>)))
  "Returns md5sum for a message object of type '<control_steps>"
  "51d557b1f317b489bd121f68c2b0a5e9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'control_steps)))
  "Returns md5sum for a message object of type 'control_steps"
  "51d557b1f317b489bd121f68c2b0a5e9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<control_steps>)))
  "Returns full string definition for message of type '<control_steps>"
  (cl:format cl:nil "int64 linear_steps~%int64 angular_steps~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'control_steps)))
  "Returns full string definition for message of type 'control_steps"
  (cl:format cl:nil "int64 linear_steps~%int64 angular_steps~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <control_steps>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <control_steps>))
  "Converts a ROS message object to a list"
  (cl:list 'control_steps
    (cl:cons ':linear_steps (linear_steps msg))
    (cl:cons ':angular_steps (angular_steps msg))
))
