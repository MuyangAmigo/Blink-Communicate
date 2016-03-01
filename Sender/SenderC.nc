#include "Timer.h"
#include "Message.h"
#include "stdint.h"

#define TIMER_PERIOD 2000 //temp



module SenderC {
  uses interface Boot;
  uses interface Timer<TMilli> as Timer;
  uses interface Timer<TMilli> as Timer1;
  uses interface Timer<TMilli> as Timer2;
  uses interface Leds;
  uses interface Read<uint16_t> as ReadT;
  uses interface Read<uint16_t> as ReadL;
  uses interface Packet;
  uses interface AMSend;
  uses interface SplitControl as RadioControl;
}

implementation {
  bool busy;
  message_t pkt;

  event void Boot.booted() {
    call Timer1.startPeriodic(2000);
    call Timer2.startPeriodic(1000);

    busy = FALSE;
    call RadioControl.start();
  }

  event void RadioControl.startDone(error_t err) {
   if (err == SUCCESS) {
     call Timer.startPeriodic(TIMER_PERIOD);
   }
   else {
     call RadioControl.start();
   }
 }

  event void RadioControl.stopDone(error_t err) {}

  event void Timer.fired() {

  }

  event void Timer1.fired() {
    //call Leds.led0Toggle();
    call ReadT.read();
  }

  event void Timer2.fired() {
    //call Leds.led0Toggle();
    call ReadL.read();
  }

  event void ReadT.readDone(error_t result, uint16_t val) {
    Temperature_Msg* payload;
    if (result == SUCCESS) {
      if (busy == FALSE) {
        payload = (Temperature_Msg*)(call Packet.getPayload(&pkt,sizeof(Temperature_Msg)));
        if (payload == NULL){
          return;
        }
      }
    }
  }

  event void ReadL.readDone(error_t result, uint16_t val) {
    Light_Msg* payload;
    if (result == SUCCESS) {
      if (busy == FALSE) {
        payload = (Light_Msg*)(call Packet.getPayload(&pkt,sizeof(Light_Msg)));
        if (payload == NULL){
          return;
        }
      }
    }
  }

  event void AMSend.sendDone(message_t* msg, error_t err) {

  }

}
