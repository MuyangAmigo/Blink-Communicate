#ifndef MESSAGE_H
#define MESSAGE_H

typedef nx_struct Temperature_Msg{
  nx_uint16_t temperature;
} Temperature_Msg;

typedef nx_struct Light_Msg{
  nx_uint16_t Light;
} Light_Msg;

enum {AM_TEMPERATURE_MSG = 6, AM_LIGHT_MSG = 8};

#endif
