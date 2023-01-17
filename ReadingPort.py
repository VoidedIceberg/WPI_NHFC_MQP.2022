import serial.tools.list_ports

ports = serial.tools.list_ports.comports()
serialInst = serial.Serial()

portsList = []

for onePort in ports:
    portsList.append(str(onePort))
    print(str(onePort))

port = input("Select Port: COM")
defaultPort = 3

for x in range(0,len(portsList)):
    if portsList[x].startswith("COM" + str(port)):
        portVar = "COM" + str(defaultPort)
        print(portVar)

serialInst.baudrate = 9600
serialInst.port = portVar
serialInst.open()

while True:
	if serialInst.in_waiting:
		packet = serialInst.readline()
		print(packet.decode('utf').rstrip('\n'))