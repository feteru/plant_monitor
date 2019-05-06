# plant_monitor
A system for monitoring plant health and acting on it. Currently facilitated through a Raspberry Pi w/ an Arduino (for the ADC), soil moisture sensors, humidity & temperature sensors. The web interface is a basic Apache HTML site, this will change.



# Using Plant Monitor
1. Download the files and place htem as described below.
2. Flash your arduino with the supplied Moisture_read.ino script.
3. Ensure that serial communication is on.
4. Do a bunch of server magic I honestly don't know.
5. Run the python script that takes the serial values and actually puts them on the web.
6. None of this works yet.
 7. Well apart from the sensors reading and the files CAN be downloaded.



# File Structure

The file distribution of this is somewhat complicated, considering the html components and python scripts that can be run from anywhere (I believe). 

In /home/pi there must be:
  * html
  * cgi
  * mysql-init 
  
![Image of home pi folder](/pifile.png "pifile")

## Required files in plant_monitor (aka no required location):
 * Moisture_Read.ino
  This needs to be flashed to arduino to report data.
 * moist_graph.pde
  Processing script that draws graphs and reports temperature & moisture
 * moist_graph.js
  Seemingly a deprecated version of the processing script.
 * index.html
  index file that calls "moist_graph.js" script to be body of the webpage. Probably needs to be in same directory as the mosit_graph.js, or at least routed there.
  ### Python Files
  * cam_serial.py
   Scales moisture readings down by 900 units, averates two temperature readings.
   Writes a json string in '/var/www/html/plant_data.txt' of the labeled data of both moisture readings and average temp.
   Finally, captures camera image into '/var/www/html/image.jpg' then sleeps for 5.
  ### CGI files
  * cam_serial_page.cgi
   This is where the magic happens. Uses the camera & serial inputs. This script defines the html document that is the output web page.
   For it to be dynamic, the script itself retrieves values from the serial stream and displays them. Also captures an image and then uses the print command with html script to display that image. One final print command declares the end of the web page.
  
 ## Nonrequired files that are here anyways:
  ### Arduino Test Files
  * Minimal_moisture_read.ino
   Just reads the soil moisture sensor value from analog pin A0, powered by digital Pin 2.
   Returns a value over serial from 0.00-100.00 @9600 baud.
 
  ### Python test files
  * cam_test.py
   Just captures an image to the same directory called 'image.jpg'
  * gpio_test.py
   Assigns a value of 4 to 'valvePin' for the pin a valve is attached to, then turns it to 1 for 0.5 seconds.
  * serial_test.py
   assigns the serial object to the device at '/dev/ttcyACM0' then reads, splits and prints the serial stream.
  
 
