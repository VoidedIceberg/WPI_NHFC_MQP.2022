import serial

rotation = 0
distance = 0


def seperateData(data):
    # Parse the data
    # ...
    global rotation, distance

    split = data.split(' ')
    rotation = split[1]
    distance = split[2]

    return rotation, distance


def initPyserial():
    # Initialize the serial port
    # ...
    serial = PySerial.Serial('COM3', 9600)


initPyserial();

while True:
    # Read the data from the serial port
    data = PySerial.read()
    seperateData(data)
    # Parse the data
    # ...
    # Send the data to the server
    # ...
