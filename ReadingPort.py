import serial.tools.list_ports, serial
import time
import os, fcntl, termios, sys

# global variables
prevRot = None # current rotation
prevD = None # current distance
pth = None # current voltage
pV = None

ports = serial.tools.list_ports.comports()
portsList = []
for onePort in ports:
    portsList.append(str(onePort))
    print(str(ports.index(onePort)+1) + " " + str(onePort))

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

# def isOutputLegal(output): # check if the output is legal
#     if len(output) < 3: # check if the output is completed
#         return 0
#     return 1

def isOutputLegal(output): # check if the output is legal
    if len(output) < 2: # check if the output is completed
        return 0
    return 1

def error(x, ref): # compare the data
    return abs(x - ref)

# def isDataAvailable(rot, d): # check if the data is continous
#     global prevD, prevRot
#     print("debugging\t", (prevRot, prevD), (rot, d))
#     # time.sleep(2)
#     if error(rot,prevRot)>=2 or error(d,prevD)>=100:
#         return 0
#     return 1

def isDataAvailable(th, V): # check if the data is continous
    global pth, pV
    print("debugging\t", (pth, pV), (th, V))
    # time.sleep(2)
    if error(pth, th)>=100 or error(pV, V)>=1:
        return 0
    return 1

# continuously grabbing the data
index = 0
while True:
    index += 1
    try:
        if serialHandler.in_waiting:
            packet = serialHandler.readline()
            # output = packet.decode('utf').split(' ')
            output = packet.decode('ascii').split('\t')
            # print(output)
            if isOutputLegal(output):
                # rot = float(output[1])
                # d = float(output[2])
                theta = float(output[0])
                V = float(output[1])
                # print("legal in " + str(index))
            else:
                print("illegal in" + str(index))
            if prevD == prevRot == None or isDataAvailable(theta, V):
                # prevRot = rot
                # prevD = d
                pth = theta
                pV = V
                # print("available in " + str(index))
                # print(rot, d)
                print(theta, V)
            else:
                print("unavailable in " + str(index))
            # time.sleep(3)
    except Exception as e:
        print(e)
        continue
