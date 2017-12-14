from picamera import PiCamera
from time import sleep

camera = PiCamera()
camera.resolution=(640, 480)
camera.capture('image.jpeg')
