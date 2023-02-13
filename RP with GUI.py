import math
import serial
import time
import serial.tools.list_ports, serial
import re
from tkinter import *


# global variables
prevRot = None # current rotation
prevLin = None # current linear

ports = serial.tools.list_ports.comports()
portsList = []
for onePort in ports:
    portsList.append(str(onePort))
    print(str(ports.index(onePort)+1) + " " + str(onePort))

port = input("Select Port: ")
port = portsList[int(port)-1].split(" ")[0]
print("chosen: " + port)

serialHandler = serial.Serial(port=port, baudrate=9600, timeout=.001)
serialHandler.close()

serialHandler.open()

def isOutputLegal(output): # check if the output is legal
    if len(output) < 3: # check if the output is completed
        return 0
    return 1

def isOutputLegal(output): # check if the output is legal
    if len(output) < 2: # check if the output is completed
        return 0
    return 1

def error(x, ref): # compare the data
    return abs(x - ref)

def isDataAvailable(rot, lin): # check if the data is continous
    global prevLin, prevRot
    print("debugging\t", (prevRot, prevLin), (rot, lin))
    # time.sleep(2)
    if error(rot,prevRot)>=1 or error(lin, prevLin)>=1:
        return 0
    return 1


def show_values():
    global serialHandler
    print(w1.get(), w2.get())
    send = "V R" + str(w1.get()) + " L" + str(w2.get()) + "\n"
    print(send)
    serialHandler.write(send.encode())


def runSin():
    linSin = 0
    rotSin = 0
    global serialHandler

    while True:
        time.sleep(0.1)
        send = "V R" + str(round(math.sin(rotSin), 4)) + \
            " L" + str(round(math.sin(linSin), 4)) + "\n"
        print(send)
        serialHandler.write(send.encode())
        linSin = linSin + 0.1
        rotSin = rotSin + 0.1


master = Tk()
w1 = Scale(master, from_=-1.0, to=1.0, resolution=0.01)
w1.set(0)
w1.pack()
w2 = Scale(master, from_=-1.0, to=1.0, orient=HORIZONTAL, resolution=0.01)
w2.set(0)
w2.pack()

Button(master, text='Show', command=show_values).pack()
Button(master, text='Sin', command=runSin).pack()
mainloop()

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
                R_part = output[1]
                re.sub("\D", "", R_part)
                L_part = output[2]
                re.sub("\D" "", L_part)
                rot = float(R_part)
                lin = float(L_part)
            else:
                print("illegal in" + str(index))
            if prevD == prevRot == None or isDataAvailable(rot, lin):
                prevRot = rot
                prevD = lin
                print(rot, lin)
            else:
                print("unavailable in " + str(index))
            # time.sleep(3)
    except Exception as e:
        print(e)
        continue