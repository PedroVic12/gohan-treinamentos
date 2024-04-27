import serial

# Inicializa a porta serial
serialPortName = "/dev/" + "ttyUSB1"
ser = serial.Serial(port=serialPortName, baudrate=9600)


# Verifica se a porta serial está aberta
if ser.isOpen():
    print("Porta serial aberta: " + ser)

    ser.write(b"test")

# Fecha a porta serial
ser.close()
