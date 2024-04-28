import serial
import serial.tools.list_ports
import requests
import pyttsx3
import speech_recognition as sr


class ArduinoControl:
    def __init__(self, port, baudrate=9600):
        self.serialInst = serial.Serial(port, baudrate)
        print("Arduino Connected")

    def send_command(self, command):
        self.serialInst.write(command.encode("utf-8"))

    def close_connection(self):
        self.serialInst.close()


class InternetControl:
    def __init__(self, url):
        self.url = url

    def send_command(self, command):
        response = requests.post(self.url, data=command)
        print(response.text)


class VoiceControl:
    def __init__(self):
        self.recognizer = sr.Recognizer()
        self.microphone = sr.Microphone()

    def recognize_command(self):
        with self.microphone as source:
            print("Say something...")
            audio = self.recognizer.listen(source)

        try:
            command = self.recognizer.recognize_google(audio).upper()
            print("You said:", command)
            return command
        except sr.UnknownValueError:
            print("Could not understand audio")
            return None
        except sr.RequestError as e:
            print("Error:", e)
            return None

    def execute_command(self, command, arduino):
        if command == "LIGAR":
            arduino.send_command("ON")
        elif command == "DESLIGAR":
            arduino.send_command("OFF")
        else:
            print("Unknown command")


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
    com_port = select_com_port()
    arduino = ArduinoControl(com_port)

    # internet_control = InternetControl("http://your-fastapi-url")
    voice_control = VoiceControl()

    while True:
        command = input("Select mode: [Internet/Voice] ").upper()
        if command == "INTERNET":
            internet_command = input("Enter command (ON/OFF/SAIR): ").upper()
            if internet_command == "SAIR":
                break
            # internet_control.send_command(internet_command)
        elif command == "VOICE":
            voice_command = voice_control.recognize_command()
            if voice_command == "SAIR":
                break
            voice_control.execute_command(voice_command, arduino)

    arduino.close_connection()


if __name__ == "__main__":
    main()
