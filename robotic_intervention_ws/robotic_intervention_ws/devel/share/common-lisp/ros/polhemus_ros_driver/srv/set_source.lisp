; Auto-generated. Do not edit!


(cl:in-package polhemus_ros_driver-srv)


;//! \htmlinclude set_source-request.msg.html

(cl:defclass <set_source-request> (roslisp-msg-protocol:ros-message)
  ((source
    :reader source
    :initarg :source
    :type cl:integer
    :initform 0)
   (sensor
    :reader sensor
    :initarg :sensor
    :type cl:integer
    :initform 0))
)

(cl:defclass set_source-request (<set_source-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <set_source-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'set_source-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name polhemus_ros_driver-srv:<set_source-request> is deprecated: use polhemus_ros_driver-srv:set_source-request instead.")))

(cl:ensure-generic-function 'source-val :lambda-list '(m))
(cl:defmethod source-val ((m <set_source-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader polhemus_ros_driver-srv:source-val is deprecated.  Use polhemus_ros_driver-srv:source instead.")
  (source m))

(cl:ensure-generic-function 'sensor-val :lambda-list '(m))
(cl:defmethod sensor-val ((m <set_source-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader polhemus_ros_driver-srv:sensor-val is deprecated.  Use polhemus_ros_driver-srv:sensor instead.")
  (sensor m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <set_source-request>) ostream)
  "Serializes a message object of type '<set_source-request>"
  (cl:let* ((signed (cl:slot-value msg 'source)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'sensor)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <set_source-request>) istream)
  "Deserializes a message object of type '<set_source-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'source) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'sensor) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<set_source-request>)))
  "Returns string type for a service object of type '<set_source-request>"
  "polhemus_ros_driver/set_sourceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'set_source-request)))
  "Returns string type for a service object of type 'set_source-request"
  "polhemus_ros_driver/set_sourceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<set_source-request>)))
  "Returns md5sum for a message object of type '<set_source-request>"
  "a11e7ea3e225df8a203dc448504ef4dd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'set_source-request)))
  "Returns md5sum for a message object of type 'set_source-request"
  "a11e7ea3e225df8a203dc448504ef4dd")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<set_source-request>)))
  "Returns full string definition for message of type '<set_source-request>"
  (cl:format cl:nil "int64 source~%int64 sensor~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'set_source-request)))
  "Returns full string definition for message of type 'set_source-request"
  (cl:format cl:nil "int64 source~%int64 sensor~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <set_source-request>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <set_source-request>))
  "Converts a ROS message object to a list"
  (cl:list 'set_source-request
    (cl:cons ':source (source msg))
    (cl:cons ':sensor (sensor msg))
))
;//! \htmlinclude set_source-response.msg.html

(cl:defclass <set_source-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass set_source-response (<set_source-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <set_source-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'set_source-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name polhemus_ros_driver-srv:<set_source-response> is deprecated: use polhemus_ros_driver-srv:set_source-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <set_source-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader polhemus_ros_driver-srv:success-val is deprecated.  Use polhemus_ros_driver-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <set_source-response>) ostream)
  "Serializes a message object of type '<set_source-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <set_source-response>) istream)
  "Deserializes a message object of type '<set_source-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<set_source-response>)))
  "Returns string type for a service object of type '<set_source-response>"
  "polhemus_ros_driver/set_sourceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'set_source-response)))
  "Returns string type for a service object of type 'set_source-response"
  "polhemus_ros_driver/set_sourceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<set_source-response>)))
  "Returns md5sum for a message object of type '<set_source-response>"
  "a11e7ea3e225df8a203dc448504ef4dd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'set_source-response)))
  "Returns md5sum for a message object of type 'set_source-response"
  "a11e7ea3e225df8a203dc448504ef4dd")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<set_source-response>)))
  "Returns full string definition for message of type '<set_source-response>"
  (cl:format cl:nil "~%bool success   # indicate successful run of setting source for a sensor~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'set_source-response)))
  "Returns full string definition for message of type 'set_source-response"
  (cl:format cl:nil "~%bool success   # indicate successful run of setting source for a sensor~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <set_source-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <set_source-response>))
  "Converts a ROS message object to a list"
  (cl:list 'set_source-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'set_source)))
  'set_source-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'set_source)))
  'set_source-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'set_source)))
  "Returns string type for a service object of type '<set_source>"
  "polhemus_ros_driver/set_source")