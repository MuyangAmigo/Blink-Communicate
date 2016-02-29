#Coupling Two TelosB Motes
##General Description
For this project, your main task is to extend the work done in the first project, and develop a TinyOS application to run on two TelosB motes, such that
1. Each of them will sense the corresponding values using their built-in light and temperature and humidity sensors, and
2. You will program them so that they communicate in a manner that enables a basic form of networked-based collaborative task execution of the two motes.
##Specifications
An assumption for this project is that you already have a “dedicated” source-node from Project#1, which combines sampling of the values and LED-based notification. For this project, there are a few slight modifications (sampling of the temperature sensor):
###Sampling:
1. the light sensor at 1 Hz (i.e., every second);
2. the temperature and humidity sensors at 0.5 HZ (i.e., once every two seconds, or twelve times per minute);
###Notification:
1. the blue LED of the node should light up (on) when it is “dark” outside, and off otherwise.
2. the green LED of the node should light up (on) whenever the temperature is above 85 degrees (Fahrenheit), and off otherwise.

Recall that the red LED can be used at your discretion (for example, you could toggle it on/off to indicate that both events (“dark and hot”) have been detected or not...

The specific extension for this assignment is that you will need to incorporate a 2 nd mote (“sink” ) that will receive packets from the first mote with the frequency of 0.25Hz (i.e., every four seconds), reporting what is the current (threshold-based) value of the light and humidity sensors at the source node at that time. The sink, in a sense, will be “mimicking” the source notifications (blue LED on when “dark”; green LED on when “hot”). You can use the red LED at the sink similarly to the one at the source.

##EXTRA CREDIT:
You can receive up to 25% extra credit if you make the role of each of the nodes “dual” in the following sense:
1. The node sampling temperature will be the source for that particular value, and will send notification to the other mote (acting like a temperature_sink);
2. The (other) node will be sampling light will act as the source for that particular value, and will send notification to the first mote (which, conversely, will be acting like a light_sink);
