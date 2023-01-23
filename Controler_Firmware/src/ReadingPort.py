import serial.tools.list_ports, serial
import os, fcntl, termios, sys

# global variables
currRot = None # current rotation
currD = None # current distance

# display the ports on the current device
ports = serial.tools.list_ports.comports()
portsList = []
for onePort in ports:
    portsList.append(str(onePort))
    print(str(onePort))

# type the number of the port ex. 1 as the first 2 as the second
port = input("Select Port: ")
defaultPort = 3
port = portsList[int(port)-1].split(" ")[0]
print("chosen: " + port)

serialHandler = serial.Serial(port=port, baudrate=9600, timeout=.001)
serialHandler.close()

# serialPath = '/dev/cu.usbmodem2049303352421'
# ser= os.open(serialPath, 0)
# [iflag, oflag, cflag, lflag, ispeed, ospeed, cc] = range(7)
# settings = termios.tcgetattr(ser)
# settings[ospeed] = termios.B9600
# settings[ispeed] = termios.B0

serialHandler.open()

def isOutputLegal(output): # check if the output is legal
    if len(output) < 3: # check if the output is completed
        return 0
    return 1

def error(x, ref): # compare the data
    return abs(x - ref)

def isDataAvailable(rot, d): # check if the data is continous
    global currD, currRot
    if error(rot,currRot)>10 or error(d,currD)>100:
        return 0
    return 1

# continuously grabbing the data
while True:
    try:
        if serialHandler.in_waiting:
            packet = serialHandler.readline()
            output = packet.decode('utf').split(' ')
            if isOutputLegal(output):
                rot = float(output[1])
                currRot = rot
                d = float(output[2])
                currD = d
            if isDataAvailable(rot, d):
                print(rot, d)
    except Exception as e:
        print(e)
        continue
