// Generated by gencpp from file polhemus_ros_driver/persistResponse.msg
// DO NOT EDIT!


#ifndef POLHEMUS_ROS_DRIVER_MESSAGE_PERSISTRESPONSE_H
#define POLHEMUS_ROS_DRIVER_MESSAGE_PERSISTRESPONSE_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace polhemus_ros_driver
{
template <class ContainerAllocator>
struct persistResponse_
{
  typedef persistResponse_<ContainerAllocator> Type;

  persistResponse_()
    : success(false)  {
    }
  persistResponse_(const ContainerAllocator& _alloc)
    : success(false)  {
  (void)_alloc;
    }



   typedef uint8_t _success_type;
  _success_type success;





  typedef boost::shared_ptr< ::polhemus_ros_driver::persistResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::polhemus_ros_driver::persistResponse_<ContainerAllocator> const> ConstPtr;

}; // struct persistResponse_

typedef ::polhemus_ros_driver::persistResponse_<std::allocator<void> > persistResponse;

typedef boost::shared_ptr< ::polhemus_ros_driver::persistResponse > persistResponsePtr;
typedef boost::shared_ptr< ::polhemus_ros_driver::persistResponse const> persistResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::polhemus_ros_driver::persistResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::polhemus_ros_driver::persistResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::polhemus_ros_driver::persistResponse_<ContainerAllocator1> & lhs, const ::polhemus_ros_driver::persistResponse_<ContainerAllocator2> & rhs)
{
  return lhs.success == rhs.success;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::polhemus_ros_driver::persistResponse_<ContainerAllocator1> & lhs, const ::polhemus_ros_driver::persistResponse_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace polhemus_ros_driver

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::polhemus_ros_driver::persistResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::polhemus_ros_driver::persistResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::polhemus_ros_driver::persistResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::polhemus_ros_driver::persistResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::polhemus_ros_driver::persistResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::polhemus_ros_driver::persistResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::polhemus_ros_driver::persistResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "358e233cde0c8a8bcfea4ce193f8fc15";
  }

  static const char* value(const ::polhemus_ros_driver::persistResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x358e233cde0c8a8bULL;
  static const uint64_t static_value2 = 0xcfea4ce193f8fc15ULL;
};

template<class ContainerAllocator>
struct DataType< ::polhemus_ros_driver::persistResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "polhemus_ros_driver/persistResponse";
  }

  static const char* value(const ::polhemus_ros_driver::persistResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::polhemus_ros_driver::persistResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n"
"bool success   # indicate successful run of calibration\n"
;
  }

  static const char* value(const ::polhemus_ros_driver::persistResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::polhemus_ros_driver::persistResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.success);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct persistResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::polhemus_ros_driver::persistResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::polhemus_ros_driver::persistResponse_<ContainerAllocator>& v)
  {
    s << indent << "success: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.success);
  }
};

} // namespace message_operations
} // namespace ros

#endif // POLHEMUS_ROS_DRIVER_MESSAGE_PERSISTRESPONSE_H
