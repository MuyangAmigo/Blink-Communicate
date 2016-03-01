configuration SenderAppC {}

implementation {
  components SenderC as App;
  components MainC, LedsC;
  components new TimerMilliC() as Timer;
  components new TimerMilliC() as Timer1;
  components new TimerMilliC() as Timer2;
  components ActiveMessageC;
  //components new SensirionSht11C() as Sense;
  components new HamamatsuS10871TsrC() as LumSensor;
  components new DemoSensorC() as Sensor;

  App.Boot -> MainC;
  App.Leds -> LedsC;
  App.Timer -> Timer;
  App.Timer1 -> Timer1;
<<<<<<< Updated upstream
  App.Timer2 -> Timer2;
=======
  App.Timer2 -> Timer2；
>>>>>>> Stashed changes
  App.ReadT -> Sensor;
  App.ReadL -> LumSensor;
  App.Packet -> ActiveMessageC;
  App.AMSend -> ActiveMessageC.AMSend[AM_TEMPERATURE_MSG];
  App.RadioControl -> ActiveMessageC;

}
