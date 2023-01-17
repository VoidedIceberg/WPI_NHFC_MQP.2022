// Generated by gencpp from file polhemus_ros_driver/persist.msg
// DO NOT EDIT!


#ifndef POLHEMUS_ROS_DRIVER_MESSAGE_PERSIST_H
#define POLHEMUS_ROS_DRIVER_MESSAGE_PERSIST_H

#include <ros/service_traits.h>


#include <polhemus_ros_driver/persistRequest.h>
#include <polhemus_ros_driver/persistResponse.h>


namespace polhemus_ros_driver
{

struct persist
{

typedef persistRequest Request;
typedef persistResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct persist
} // namespace polhemus_ros_driver


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::polhemus_ros_driver::persist > {
  static const char* value()
  {
    return "358e233cde0c8a8bcfea4ce193f8fc15";
  }

  static const char* value(const ::polhemus_ros_driver::persist&) { return value(); }
};

template<>
struct DataType< ::polhemus_ros_driver::persist > {
  static const char* value()
  {
    return "polhemus_ros_driver/persist";
  }

  static const char* value(const ::polhemus_ros_driver::persist&) { return value(); }
};


// service_traits::MD5Sum< ::polhemus_ros_driver::persistRequest> should match
// service_traits::MD5Sum< ::polhemus_ros_driver::persist >
template<>
struct MD5Sum< ::polhemus_ros_driver::persistRequest>
{
  static const char* value()
  {
    return MD5Sum< ::polhemus_ros_driver::persist >::value();
  }
  static const char* value(const ::polhemus_ros_driver::persistRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::polhemus_ros_driver::persistRequest> should match
// service_traits::DataType< ::polhemus_ros_driver::persist >
template<>
struct DataType< ::polhemus_ros_driver::persistRequest>
{
  static const char* value()
  {
    return DataType< ::polhemus_ros_driver::persist >::value();
  }
  static const char* value(const ::polhemus_ros_driver::persistRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::polhemus_ros_driver::persistResponse> should match
// service_traits::MD5Sum< ::polhemus_ros_driver::persist >
template<>
struct MD5Sum< ::polhemus_ros_driver::persistResponse>
{
  static const char* value()
  {
    return MD5Sum< ::polhemus_ros_driver::persist >::value();
  }
  static const char* value(const ::polhemus_ros_driver::persistResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::polhemus_ros_driver::persistResponse> should match
// service_traits::DataType< ::polhemus_ros_driver::persist >
template<>
struct DataType< ::polhemus_ros_driver::persistResponse>
{
  static const char* value()
  {
    return DataType< ::polhemus_ros_driver::persist >::value();
  }
  static const char* value(const ::polhemus_ros_driver::persistResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // POLHEMUS_ROS_DRIVER_MESSAGE_PERSIST_H