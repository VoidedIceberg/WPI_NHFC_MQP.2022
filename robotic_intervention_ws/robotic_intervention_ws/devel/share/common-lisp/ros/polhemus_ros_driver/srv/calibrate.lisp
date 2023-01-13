; Auto-generated. Do not edit!


(cl:in-package polhemus_ros_driver-srv)


;//! \htmlinclude calibrate-request.msg.html

(cl:defclass <calibrate-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass calibrate-request (<calibrate-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <calibrate-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'calibrate-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name polhemus_ros_driver-srv:<calibrate-request> is deprecated: use polhemus_ros_driver-srv:calibrate-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <calibrate-request>) ostream)
  "Serializes a message object of type '<calibrate-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <calibrate-request>) istream)
  "Deserializes a message object of type '<calibrate-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<calibrate-request>)))
  "Returns string type for a service object of type '<calibrate-request>"
  "polhemus_ros_driver/calibrateRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'calibrate-request)))
  "Returns string type for a service object of type 'calibrate-request"
  "polhemus_ros_driver/calibrateRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<calibrate-request>)))
  "Returns md5sum for a message object of type '<calibrate-request>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'calibrate-request)))
  "Returns md5sum for a message object of type 'calibrate-request"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<calibrate-request>)))
  "Returns full string definition for message of type '<calibrate-request>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'calibrate-request)))
  "Returns full string definition for message of type 'calibrate-request"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <calibrate-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <calibrate-request>))
  "Converts a ROS message object to a list"
  (cl:list 'calibrate-request
))
;//! \htmlinclude calibrate-response.msg.html

(cl:defclass <calibrate-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass calibrate-response (<calibrate-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <calibrate-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'calibrate-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name polhemus_ros_driver-srv:<calibrate-response> is deprecated: use polhemus_ros_driver-srv:calibrate-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <calibrate-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader polhemus_ros_driver-srv:success-val is deprecated.  Use polhemus_ros_driver-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <calibrate-response>) ostream)
  "Serializes a message object of type '<calibrate-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <calibrate-response>) istream)
  "Deserializes a message object of type '<calibrate-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<calibrate-response>)))
  "Returns string type for a service object of type '<calibrate-response>"
  "polhemus_ros_driver/calibrateResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'calibrate-response)))
  "Returns string type for a service object of type 'calibrate-response"
  "polhemus_ros_driver/calibrateResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<calibrate-response>)))
  "Returns md5sum for a message object of type '<calibrate-response>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'calibrate-response)))
  "Returns md5sum for a message object of type 'calibrate-response"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<calibrate-response>)))
  "Returns full string definition for message of type '<calibrate-response>"
  (cl:format cl:nil "~%bool success   # indicate successful run of making settings persistent~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'calibrate-response)))
  "Returns full string definition for message of type 'calibrate-response"
  (cl:format cl:nil "~%bool success   # indicate successful run of making settings persistent~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <calibrate-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <calibrate-response>))
  "Converts a ROS message object to a list"
  (cl:list 'calibrate-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'calibrate)))
  'calibrate-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'calibrate)))
  'calibrate-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'calibrate)))
  "Returns string type for a service object of type '<calibrate>"
  "polhemus_ros_driver/calibrate")