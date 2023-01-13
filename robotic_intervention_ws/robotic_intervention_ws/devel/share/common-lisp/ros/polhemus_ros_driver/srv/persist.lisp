; Auto-generated. Do not edit!


(cl:in-package polhemus_ros_driver-srv)


;//! \htmlinclude persist-request.msg.html

(cl:defclass <persist-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass persist-request (<persist-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <persist-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'persist-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name polhemus_ros_driver-srv:<persist-request> is deprecated: use polhemus_ros_driver-srv:persist-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <persist-request>) ostream)
  "Serializes a message object of type '<persist-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <persist-request>) istream)
  "Deserializes a message object of type '<persist-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<persist-request>)))
  "Returns string type for a service object of type '<persist-request>"
  "polhemus_ros_driver/persistRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'persist-request)))
  "Returns string type for a service object of type 'persist-request"
  "polhemus_ros_driver/persistRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<persist-request>)))
  "Returns md5sum for a message object of type '<persist-request>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'persist-request)))
  "Returns md5sum for a message object of type 'persist-request"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<persist-request>)))
  "Returns full string definition for message of type '<persist-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'persist-request)))
  "Returns full string definition for message of type 'persist-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <persist-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <persist-request>))
  "Converts a ROS message object to a list"
  (cl:list 'persist-request
))
;//! \htmlinclude persist-response.msg.html

(cl:defclass <persist-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass persist-response (<persist-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <persist-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'persist-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name polhemus_ros_driver-srv:<persist-response> is deprecated: use polhemus_ros_driver-srv:persist-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <persist-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader polhemus_ros_driver-srv:success-val is deprecated.  Use polhemus_ros_driver-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <persist-response>) ostream)
  "Serializes a message object of type '<persist-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <persist-response>) istream)
  "Deserializes a message object of type '<persist-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<persist-response>)))
  "Returns string type for a service object of type '<persist-response>"
  "polhemus_ros_driver/persistResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'persist-response)))
  "Returns string type for a service object of type 'persist-response"
  "polhemus_ros_driver/persistResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<persist-response>)))
  "Returns md5sum for a message object of type '<persist-response>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'persist-response)))
  "Returns md5sum for a message object of type 'persist-response"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<persist-response>)))
  "Returns full string definition for message of type '<persist-response>"
  (cl:format cl:nil "~%bool success   # indicate successful run of calibration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'persist-response)))
  "Returns full string definition for message of type 'persist-response"
  (cl:format cl:nil "~%bool success   # indicate successful run of calibration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <persist-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <persist-response>))
  "Converts a ROS message object to a list"
  (cl:list 'persist-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'persist)))
  'persist-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'persist)))
  'persist-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'persist)))
  "Returns string type for a service object of type '<persist>"
  "polhemus_ros_driver/persist")