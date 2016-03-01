#include "Timer.h"
#include "Message.h"
#include "stdint.h"

module RoleOneC{
  uses {
    interface Boot;
    interface Leds;
    interface Receive;
    interface SplitControl as RadioControl;
  }
    uses interface Timer<TMilli> as Timer;
    uses interface Timer<TMilli> as Timer1;
    uses interface Timer<TMilli> as Timer2;  //LIGHT SENSOR TIMER
    uses interface Read<uint16_t> as ReadL;

    uses interface Packet;
    uses interface AMPacket;
    uses interface AMSend;
}

implementation{
//Start Send Light
  bool busy;
  message_t pkt;

  uint16_t S_light;

  event void Boot.booted() {
    call Timer2.startPeriodic(1000);//Light

    busy = FALSE;
    call RadioControl.start();
  }

  event void RadioControl.startDone(error_t err) {
   if (err == SUCCESS) {
     call Timer.startPeriodic(2000);
   }
   else {
     call RadioControl.start();
   }
 }

  event void RadioControl.stopDone(error_t err) {}

  event void Timer.fired() {
    if (!busy) {

      ProjB_Msg* sndPayload = (ProjB_Msg*)(call Packet.getPayload(&pkt, sizeof (ProjB_Msg)));

      sndPayload -> Light = S_light;

      if (call AMSend.send(AM_BROADCAST_ADDR, &pkt, sizeof(ProjB_Msg)) == SUCCESS) {
        busy = TRUE;
      }
  }
  }

  event void Timer1.fired() {
  }

  event void Timer2.fired() {
    call ReadL.read();
  }


  event void ReadL.readDone(error_t result, uint16_t val) {

      if (result == SUCCESS){
        if (val < 0x0080) {
          call Leds.led2On();
        }
        else {
          call Leds.led2Off();
        }

        if (busy == FALSE) {
          S_light = val;
        }
      }

  }


//Start Receive Temperature
event message_t * Receive.receive(message_t* msg, void* payload, uint8_t len){


  if(len != sizeof(ProjB_Msg)) {
    return NULL;
  }

  else {
    ProjB_Msg* rcvPayload = (ProjB_Msg*) payload;

    uint8_t myTemperature = rcvPayload -> Temperature;

    if (myTemperature > 0x0055) {
      call Leds.led1On();
    }
    else {
      call Leds.led1Off();
    }

  return msg;
  }
}

event void AMSend.sendDone(message_t* msg, error_t err) {
  if(&pkt == msg){
    busy = FALSE;
  }
}

}
