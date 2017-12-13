#!/usr/bin/python27all

import serial
import picamera
import time


camera = picamera.PiCamera()
ser = serial.Serial('/dev/ttyACM0',9600)
s = [0]

print "Content-type:text/html\n\n"
print '<html> <body><font color="red">'

time.sleep(1)
#Read serial values from arduino
#while True:
read_serial = ser.readline()
read_list = read_serial.split(",")
if (len(read_list) ==4):
  moist1 = int(read_list[0]) - 917  #scale moisture reading down
  moist2 = int(read_list[1]) - 917

  print moist1

#capture image from camera
camera.resolution = (1280, 960)
camera.capture('/var/www/html/image.jpg')

print '<img src="/var/www/html/image.jpg">'


print '</body> </html>'
