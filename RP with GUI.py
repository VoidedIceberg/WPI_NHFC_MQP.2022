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
serialSend = None
serialRecieve = None

rotationControl = False

def initSerial():
    global serialSend, serialRecieve

    ports = serial.tools.list_ports.comports()
    portsList = []
    for onePort in ports:
        portsList.append(str(onePort))
        print(str(ports.index(onePort)+1) + " " + str(onePort))

    port = input("Serial Send Select Port: ")
    port = portsList[int(port)-1].split(" ")[0]
    print("chosen: " + port)

    serialSend = serial.Serial(port=port, baudrate=9600, timeout=.001)
    serialSend.close()

    serialSend.open()

    ports = serial.tools.list_ports.comports()
    portsList = []
    for onePort in ports:
        portsList.append(str(onePort))
        print(str(ports.index(onePort)+1) + " " + str(onePort))

    port = input("Serial Send Select Port: ")
    port = portsList[int(port)-1].split(" ")[0]
    print("chosen: " + port)

    serialRecieve = serial.Serial(port=port, baudrate=9600, timeout=.001)
    serialRecieve.close()

    serialRecieve.open()

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
    global serialSend
    send = "V R" + str(w1.get()) + " L" + str(w2.get()) + "\r\n"
    print(send)
    serialSend.write(send.encode())

enaleSine = False

def turnonSin():
    global enaleSine
    if enaleSine:
        enaleSine = False
    else:
        enaleSine = True

linSin = 0
rotSin = 0
lastTime = 0

def runSin():
    global linSin, rotSin, lastTime
    if time.time() - lastTime > 0.125:
        send = "V R" + str(round(math.sin(rotSin)*0.5, 4)) + \
            " L" + str(round(math.sin(linSin)*1.0, 4)) + "\n"
        print(send)
        serialSend.write(send.encode())
        linSin = linSin + 0.1
        rotSin = rotSin + 0.1
        lastTime = time.time()

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
    pb1 = ttk.Progressbar(
        master,
        orient='horizontal',
        mode='determinate',
        length=400
        )
    pb.pack()
    pb1.pack()


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
    lin = 0.01
    rot = 0.01
    index = 0
    maxLin = 1
    minLin = -1

    minRot = -1
    maxRot = 1

    pb['value'] = ((maxLin-lin) / (maxLin+ abs(minLin))) * 100
    pb1['value'] = (((minRot-rot) / (maxRot + abs(minRot))) * 100) + 50

    pb.start()


    while True:
        master.update()
        pb['value'] = ((maxLin-lin) / (maxLin+ abs(minLin))) * 100
        pb1['value'] = 50 - (((minRot-rot) / (maxRot + abs(minRot))) * 100)

        pb.step()
        pb1.step()

        if rotationControl:
            # calRot = (rot * 0.05) if (rot < 2.0) else 2.0
            calLin = (rot * 0.05) if (rot < 2.0) else 2.0
            send = "V R" + str(0.0) + " L" + str(round(calLin, 3))
            print(send)
            serialSend.write(send.encode())
            # time.sleep(0.1)

        if enaleSine:
            runSin()
            # time.sleep(0.05)
    
        try:
            if serialRecieve.in_waiting:
                packet = serialRecieve.readline()
                output = packet.decode('utf').split(' ')
                if isOutputLegal(output):
                    R_part = output[1]
                    R_part = re.sub("R", " ", R_part)
                    L_part = output[2]
                    L_part = re.sub("L", " ", L_part)
                    try:
                        rot = float(R_part)
                        if rot > maxRot:
                            maxRot = rot
                        if rot < minRot:
                            minRot = rot
                        lin = float(L_part)
                        if lin > maxLin:
                            maxLin = lin
                        if lin < minLin:
                            minLin = lin
                    except Exception as e:
                        continue
                    print(str(rot) + " " + str(lin))
                else:
                    print("unavailable in " + str(index))
                    continue
        except Exception as e:
            print(e)
            continue
        serialRecieve.flushInput()
        serialRecieve.flushOutput()

