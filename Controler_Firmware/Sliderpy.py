from tkinter import *
import time
import serial


cntrler = serial.Serial('COM6', 9600, timeout=.1)

def show_values():
    global cntrler
    print(w1.get(), w2.get())
    send = "V R" + str(w1.get()) + " L" + str(w2.get()) + "\n"
    print(send)
    cntrler.write(send.encode())

master = Tk()
w1 = Scale(master, from_=-2.0, to=2.0, resolution=0.01)
w1.set(0)
w1.pack()
w2 = Scale(master, from_=-2.0, to=2.0, orient=HORIZONTAL, resolution=0.01)
w2.set(0)
w2.pack()
Button(master, text='Show', command=show_values).pack()

mainloop()
