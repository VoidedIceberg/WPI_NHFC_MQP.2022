from tkinter import *
import time
import serial
import math


cntrler = serial.Serial('COM6', 9600, timeout=.1)


def show_values():
    global cntrler
    print(w1.get(), w2.get())
    send = "V R" + str(w1.get()) + " L" + str(w2.get()) + "\n"
    print(send)
    cntrler.write(send.encode())

def runSin():
    linSin = 0
    rotSin = 0

    while True:
        time.sleep(0.1)
        send = "V R" + str(round(math.sin(rotSin), 4)) + " L" + str(round(math.sin(linSin),4)) + "\n"
        print(send)
        cntrler.write(send.encode())
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
