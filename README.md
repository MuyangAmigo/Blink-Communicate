#Coupling Two TelosB Motes
##General Description
For this project, your main task is to extend the work done in the first project, and develop a TinyOS application to run on two TelosB motes, such that
...1. Each of them will sense the corresponding values using their built-in light and temperature and humidity sensors, and
...2. You will program them so that they communicate in a manner that enables a basic form of networked-based collaborative task execution of the two motes.
#Specifications
An assumption for this project is that you already have a “dedicated” source-node from Project#1, which combines sampling of the values and LED-based notification. For this project, there are a few slight modifications (sampling of the temperature sensor):
###Sampling:
...1. the light sensor at 1 Hz (i.e., every second);
...2. the temperature and humidity sensors at 0.5 HZ (i.e., once every two seconds, or twelve times per minute);
###Notification:
...1. the blue LED of the node should light up (on) when it is “dark” outside, and off otherwise.
...2. the green LED of the node should light up (on) whenever the temperature is above 85 degrees (Fahrenheit), and off otherwise.
