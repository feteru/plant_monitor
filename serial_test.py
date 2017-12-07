import serial

ser = serial.Serial('/dev/cu.usbmodem1411',9600)
s = [0]

while True:
  read_serial = ser.readline()
  read_list = read_serial.split(",")
  print read_list

#  s[0] = str(int (ser.readline(),16))
 
 # print s[0]
  #print read_serial
