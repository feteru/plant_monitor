#!/usr/bin/python27all

import serial

ser = serial.Serial('/dev/ttyACM0',9600)
s = [0]

print "Content-type:text/html\n\n"
print '<html> <body><font color="red">'

#while True:
read_serial = ser.readline()
read_list = read_serial.split(",")
print read_list

print '</body> </html>'


#  s[0] = str(int (ser.readline(),16))

 # print s[0]
  #print read_serial
