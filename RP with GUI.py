import serial.tools.list_ports
import serial
import re
from tkinter import *
import tkinter as tk
from tkinter import ttk
import time
import math

# global variables
prevRot = None  # current rotation
prevLin = None  # current linear
serialHandler = None
rotationControl = False

def initSerial():
    global serialHandler
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

def isOutputLegal(output):  # check if the output is legal
    if len(output) < 2:  # check if the output is completed
        return 0
    return 1


def error(x, ref):  # compare the data
    return abs(x - ref)


def isDataAvailable(rot, lin):  # check if the data is continous
    global prevLin, prevRot
    print("debugging\t", (prevRot, prevLin), (rot, lin))
    # time.sleep(2)
    if error(rot, prevRot) >= 1 or error(lin, prevLin) >= 1:
        return 0
    return 1


def show_values():
    global serialHandler
    send = "V R" + str(w1.get()) + " L" + str(w2.get()) + "\n"
    print(send)
    serialHandler.write(send.encode())

enaleSine = False

def turnonSin():
    global enaleSine
    if enaleSine:
        enaleSine = False
    else:
        enaleSine = True

linSin = 0
rotSin = 0
def runSin():
    global linSin, rotSin
    time.sleep(0.1)
    send = "V R" + str(round(math.sin(rotSin), 4)) + \
        " L" + str(round(math.sin(linSin), 4)) + "\n"
    print(send)
    serialHandler.write(send.encode())
    linSin = linSin + 0.1
    rotSin = rotSin + 0.1

def rotControledLin():
    global rotationControl
    if rotationControl:
        rotationControl = False
    else:
        rotationControl = True

if __name__ == "__main__":
    rotationControl = False

    initSerial()
    master = Tk()
    master.geometry('500x620')

    pb = ttk.Progressbar(
        master,
        orient='horizontal',
        mode='determinate',
        length=400
    )
    pb.pack()

    w1 = Scale(master, from_=-1.0, to=1.0, resolution=0.01)
    w1.set(0)
    w1.pack()
    w2 = Scale(master, from_=-1.0, to=1.0, orient=HORIZONTAL, resolution=0.01)
    w2.set(0)
    w2.pack()

    Button(master, text='Show', command=show_values).pack()
    Button(master, text='Sin', command=turnonSin).pack()
    Button(master, text='Rotation Controlled Force',
           command=rotControledLin).pack()



    # continuously grabbing the data
    index = 0
    maxLin = 1.0

    while True:
        lin = 0.01

        master.update()
        pb['value'] = ((lin + 0.001) / maxLin * 400)
        if rotationControl:
            calRot = (rot * 0.5) if (rot < 2.0) else 2.0
            calLin = (rot * 0.125) if (rot < 2.0) else 2.0
            send = "V R" + str(calRot) + " L" + str(calLin) + "\n"
            print(send)
            serialHandler.write(send.encode())
        if enaleSine:
            runSin()
        try:
            if serialHandler.in_waiting:
                packet = serialHandler.readline()
                output = packet.decode('utf').split(' ')
                # output = packet.decode('ascii').split('\t')
                # print(output)
                if isOutputLegal(output):
                    R_part = output[1]
                    R_part = re.sub("R", " ", R_part)
                    L_part = output[2]
                    L_part = re.sub("L", " ", L_part)
                    try:
                        rot = float(R_part)
                        lin = float(L_part)
                        if lin > maxLin:
                            maxLin = lin
                    except Exception as e:
                        continue
                    print(str(rot) + " " + str(lin))
                else:
                    # print("unavailable in " + str(index))
                    continue
                # time.sleep(3)
        except Exception as e:
            continue
