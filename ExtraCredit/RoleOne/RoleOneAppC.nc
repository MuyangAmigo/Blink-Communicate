configuration RoleOneAppC {}

implementation {
  components RoleOneC as App;
  components MainC, LedsC;
  components new TimerMilliC() as Timer;
  components new TimerMilliC() as Timer1;
  components new TimerMilliC() as Timer2;
  components ActiveMessageC;
  components new HamamatsuS10871TsrC() as LumSensor;
  components new AMSenderC(AM_PROJB_MSG);
  components new AMReceiverC(AM_PROJB_MSG);

  App.Boot -> MainC;
  App.Leds -> LedsC;

  App.Timer -> Timer;
  App.Timer1 -> Timer1;
  App.Timer2 -> Timer2;

  App.ReadL -> LumSensor;

  App.Packet -> AMSenderC;
  App.AMPacket -> AMSenderC;
  App.AMSend -> AMSenderC;
  
  App.RadioControl -> ActiveMessageC;

}
