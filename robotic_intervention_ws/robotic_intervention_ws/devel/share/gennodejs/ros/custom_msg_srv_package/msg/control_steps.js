// Auto-generated. Do not edit!

// (in-package custom_msg_srv_package.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class control_steps {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.linear_steps = null;
      this.angular_steps = null;
    }
    else {
      if (initObj.hasOwnProperty('linear_steps')) {
        this.linear_steps = initObj.linear_steps
      }
      else {
        this.linear_steps = 0;
      }
      if (initObj.hasOwnProperty('angular_steps')) {
        this.angular_steps = initObj.angular_steps
      }
      else {
        this.angular_steps = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type control_steps
    // Serialize message field [linear_steps]
    bufferOffset = _serializer.int64(obj.linear_steps, buffer, bufferOffset);
    // Serialize message field [angular_steps]
    bufferOffset = _serializer.int64(obj.angular_steps, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type control_steps
    let len;
    let data = new control_steps(null);
    // Deserialize message field [linear_steps]
    data.linear_steps = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [angular_steps]
    data.angular_steps = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'custom_msg_srv_package/control_steps';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '51d557b1f317b489bd121f68c2b0a5e9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int64 linear_steps
    int64 angular_steps
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new control_steps(null);
    if (msg.linear_steps !== undefined) {
      resolved.linear_steps = msg.linear_steps;
    }
    else {
      resolved.linear_steps = 0
    }

    if (msg.angular_steps !== undefined) {
      resolved.angular_steps = msg.angular_steps;
    }
    else {
      resolved.angular_steps = 0
    }

    return resolved;
    }
};

module.exports = control_steps;
