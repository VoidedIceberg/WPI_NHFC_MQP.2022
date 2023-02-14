# from tkinter import *
# import serial.tools.list_ports
# import functools

# ports = serial.tools.list_ports.comports()
# serialObj = serial.Serial()

# root = Tk()
# root.config(bg='grey')

# def initComPort(index):
#     currentPort = str(ports[index])
#     comPortVar = str(currentPort.split(' ')[0])
#     print(comPortVar)
#     serialObj.port = comPortVar
#     serialObj.baudrate = 9600
#     serialObj.open()

# for onePort in ports:
#     comButton = Button(root, text=onePort, font=('Calibri', '13'), height=1, width=45, command = functools.partial(initComPort, index = ports.index(onePort)))
#     comButton.grid(row=ports.index(onePort), column=0)

# dataCanvas = Canvas(root, width=600, height=400, bg='white')
# dataCanvas.grid(row=0, column=1, rowspan=100)

# vsb = Scrollbar(root, orient='vertical', command=dataCanvas.yview)
# vsb.grid(row=0, column=2, rowspan=100, sticky='ns')

# dataCanvas.config(yscrollcommand = vsb.set)

# dataFrame = Frame(dataCanvas, bg="white")
# dataCanvas.create_window((10,0),window=dataFrame,anchor='nw')

# def checkSerialPort():
#     if serialObj.isOpen() and serialObj.in_waiting:
#         recentPacket = serialObj.readline()
#         recentPacketString = recentPacket.decode('utf').rstrip('\n')
#         Label(dataFrame, text=recentPacketString)

# while True:
#     root.update()
#     checkSerialPort()
#     dataCanvas.config(scrollregion=dataCanvas.bbox("all"))

import serial.tools.list_ports
import tkinter as tk
import serial

ser1 = None
ser2 = None

def initSerial():
    global serialHandler
    ports = serial.tools.list_ports.comports()
    portsList = []
    for onePort in ports:
        portsList.append(str(onePort))
        print(str(ports.index(onePort)+1) + " " + str(onePort))

    port = input("Select Port1: ")
    port = portsList[int(port)-1].split(" ")[0]
    print("chosen1: " + port)

    ser1 = serial.Serial(port=port, baudrate=57600, timeout=.001)
    
    ser1.close()
    ser1.open()

    port = input("Select Port2: ")
    port = portsList[int(port)-1].split(" ")[0]
    print("chosen2: " + port)
    ser2 = serial.Serial(port=port, baudrate=57600, timeout=.001)
    
    ser2.close()
    ser2.open()

class Scroller:
    def __init__(self, master):
        self.master = master
        master.title("Serial Data")

        self.label1 = tk.Label(master, text="Data 1:")
        self.label1.pack()

        self.label2 = tk.Label(master, text="Data 2:")
        self.label2.pack()

        self.update_labels()

    def update_labels(self):
        try:
            data1 = ser1.readline().decode('ascii')
            data2 = ser2.readline().decode('ascii')
            self.label1.configure(text="Data 1: " + data1)
            self.label2.configure(text="Data 2: " + data2)
        except:
            pass

        self.master.after(100, self.update_labels)


if __name__ == '__main__':
    initSerial()
    root = tk.Tk()
    my_app = Scroller(root)
    root.mainloop()
