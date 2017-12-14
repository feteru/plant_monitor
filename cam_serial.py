#!/usr/bin/python27all

import serial
import picamera
import time
import json

camera = picamera.PiCamera()
ser = serial.Serial('/dev/ttyACM0',9600)
s = [0]

time.sleep(5)
#Read serial values from arduino
while True:
  read_serial = ser.readline()
  read_list = read_serial.split(",")
  if (len(read_list) ==4):
    moist1 = int(read_list[0]) - 900  #scale moisture reading down
    moist2 = int(read_list[1]) - 900
    temp1 = int(read_list[2])
    temp2 = int(read_list[3])
    avgtemp = (temp1 + temp2) / 2
    data = {"moisture1":moist1, "moisture2":moist2, "temperature":avgtemp }
    json_string = json.dumps(data, indent=2)
    with open('/var/www/html/plant_data.txt', 'w+') as f:
      json.dump(json_string, f)
    print json_string
  #capture image from camera
  camera.resolution = (640, 480)
  camera.capture('/var/www/html/image.jpg')
  time.sleep(5)
