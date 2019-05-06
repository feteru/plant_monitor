import serial
import time
ser = serial.Serial('/dev/ttyACM0',9600)
s = [0]

while True:
  read_serial = ser.readline()
  if read_serial is not None:
    legible = read_serial.strip()
    print(read_serial)

