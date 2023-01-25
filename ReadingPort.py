import serial.tools.list_ports, serial
import time
import os, fcntl, termios, sys

# global variables
prevRot = None # current rotation
prevD = None # current distance

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
    global prevD, prevRot
    print("debugging\t", (prevRot, prevD), (rot, d))
    # time.sleep(2)
    if error(rot,prevRot)>=2 or error(d,prevD)>=100:
        return 0
    return 1

# continuously grabbing the data
index = 0
while True:
    index+=1
    try:
        if serialHandler.in_waiting:
            packet = serialHandler.readline()
            output = packet.decode('utf').split(' ')
            if isOutputLegal(output):
                rot = float(output[1])
                d = float(output[2])
                # print("legal in " + str(index))
            else:
                print("illegal in" + str(index))
            if prevD == prevRot == None or isDataAvailable(rot, d):
                prevRot = rot
                prevD = d
                # print("available in " + str(index))
                print(rot, d)
            else:
                print("unavailable in " + str(index))
            # time.sleep(3)
    except Exception as e:
        print(e)
        continue
