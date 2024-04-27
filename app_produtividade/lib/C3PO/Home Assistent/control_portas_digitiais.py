import serial.tools.list_ports
import serial


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
            if port.startswith(f"COM{com}"):
                return port
        print("Tente outra porta USB. Please try again.")


def main():
    use = select_com_port()
    serialInst = serial.Serial(use, 9600)
    print("Arduino Connected")

    while True:
        command = input("Arduino Command (ON/OFF/SAIR): ").upper()
        serialInst.write(command.encode("utf-8"))

        if command == "SAIR":
            serialInst.close()
            break


main()
