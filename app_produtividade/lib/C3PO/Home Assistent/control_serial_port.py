import serial
import serial.tools.list_ports_linux


# sudo chmod a+rw /dev/ttyUSB0


def select_com_port():
    ports = serial.tools.list_ports.comports()
    portsList = [str(port) for port in ports]

    print("Available COM Ports:")
    for port in portsList:
        if "n/a" not in port:
            print(port)

    while True:
        com = input("\nSelect the COM port that the Arduino is connected to: ")
        for port in portsList:
            print("porta conectada: ", port)
            return com
        print("Tente outra porta USB. Please try again.")


def main():
    use_port = select_com_port()
    # use_port = "/dev/ttyUSB0"  # default value, just to avoid errors

    serialInst = serial.Serial(use_port, 9600)
    print("Arduino Connected")

    while True:
        command = input("Arduino Command (ON/OFF/SAIR): ").upper()
        serialInst.write(command.encode("utf-8"))

        if command == "SAIR":
            serialInst.close()
            break


main()
