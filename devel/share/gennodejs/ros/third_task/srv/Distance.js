// Auto-generated. Do not edit!

// (in-package third_task.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class DistanceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.x1 = null;
      this.y1 = null;
      this.x2 = null;
      this.y2 = null;
    }
    else {
      if (initObj.hasOwnProperty('x1')) {
        this.x1 = initObj.x1
      }
      else {
        this.x1 = 0.0;
      }
      if (initObj.hasOwnProperty('y1')) {
        this.y1 = initObj.y1
      }
      else {
        this.y1 = 0.0;
      }
      if (initObj.hasOwnProperty('x2')) {
        this.x2 = initObj.x2
      }
      else {
        this.x2 = 0.0;
      }
      if (initObj.hasOwnProperty('y2')) {
        this.y2 = initObj.y2
      }
      else {
        this.y2 = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DistanceRequest
    // Serialize message field [x1]
    bufferOffset = _serializer.float64(obj.x1, buffer, bufferOffset);
    // Serialize message field [y1]
    bufferOffset = _serializer.float64(obj.y1, buffer, bufferOffset);
    // Serialize message field [x2]
    bufferOffset = _serializer.float64(obj.x2, buffer, bufferOffset);
    // Serialize message field [y2]
    bufferOffset = _serializer.float64(obj.y2, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DistanceRequest
    let len;
    let data = new DistanceRequest(null);
    // Deserialize message field [x1]
    data.x1 = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [y1]
    data.y1 = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [x2]
    data.x2 = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [y2]
    data.y2 = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 32;
  }

  static datatype() {
    // Returns string type for a service object
    return 'third_task/DistanceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3010fad09b09b8d3fdecdd94d144f7a1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # third_task/srv/Distance.srv
    float64 x1
    float64 y1
    float64 x2
    float64 y2
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new DistanceRequest(null);
    if (msg.x1 !== undefined) {
      resolved.x1 = msg.x1;
    }
    else {
      resolved.x1 = 0.0
    }

    if (msg.y1 !== undefined) {
      resolved.y1 = msg.y1;
    }
    else {
      resolved.y1 = 0.0
    }

    if (msg.x2 !== undefined) {
      resolved.x2 = msg.x2;
    }
    else {
      resolved.x2 = 0.0
    }

    if (msg.y2 !== undefined) {
      resolved.y2 = msg.y2;
    }
    else {
      resolved.y2 = 0.0
    }

    return resolved;
    }
};

class DistanceResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.distance = null;
    }
    else {
      if (initObj.hasOwnProperty('distance')) {
        this.distance = initObj.distance
      }
      else {
        this.distance = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DistanceResponse
    // Serialize message field [distance]
    bufferOffset = _serializer.float64(obj.distance, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DistanceResponse
    let len;
    let data = new DistanceResponse(null);
    // Deserialize message field [distance]
    data.distance = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'third_task/DistanceResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'acff7fda0c683c872875f5c4b069f124';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 distance
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new DistanceResponse(null);
    if (msg.distance !== undefined) {
      resolved.distance = msg.distance;
    }
    else {
      resolved.distance = 0.0
    }

    return resolved;
    }
};

module.exports = {
  Request: DistanceRequest,
  Response: DistanceResponse,
  md5sum() { return 'a7986c87b5a540f05187a6ffc4756d6c'; },
  datatype() { return 'third_task/Distance'; }
};
