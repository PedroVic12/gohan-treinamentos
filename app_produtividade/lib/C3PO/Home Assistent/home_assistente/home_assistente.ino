#include <Arduino.h>

const int redPin = 2;
const int greenPin = 4;
const int buzzerPin = 8;
const int ldrPin = A0;
const int threshold = 12; 
int leitura; 
float tom;
int tempo = 10;


String toUpperCase(String str) {
    String result = str;
    for (int i = 0; i < result.length(); i++) {
        result.setCharAt(i, toupper(result.charAt(i)));
    }
    return result;
}


class LEDController {
public:
    LEDController(int redPin, int greenPin) : redPin(redPin), greenPin(greenPin) {
        pinMode(redPin, OUTPUT);
        pinMode(greenPin, OUTPUT);
    }

    void turnOnGreenLED() {
        digitalWrite(greenPin, HIGH);
    }

    void ligarLedVermelho(){
        digitalWrite(redPin, HIGH);

    }

    void turnOffGreenLED() {
        digitalWrite(greenPin, LOW);
    }

    void blinkRedLED() {
        for (int i = 0; i < 5; i++) {
            digitalWrite(redPin, HIGH);
            delay(100);
            digitalWrite(redPin, LOW);
            delay(100);
        }
    }

private:
    int redPin;
    int greenPin;
};

class BuzzerController {
public:
    BuzzerController(int buzzerPin) : buzzerPin(buzzerPin) {
        pinMode(buzzerPin, OUTPUT);
    }

    void tocarSom(int tom, int tempo) { 
        tone(buzzerPin, tom, tempo); 
    }

private:
    int buzzerPin;
};

class LightSensor {
public:
    LightSensor(int ldrPin, int threshold) : ldrPin(ldrPin), threshold(threshold) {
        pinMode(ldrPin, INPUT);
    }

    int isLight() {
        int sensorValue = analogRead(ldrPin);
        if (sensorValue < threshold){
          return 0;
        }
        else {
          return 1;
        }
    }

    int initSensor(){
      leitura = analogRead(ldrPin);
      Serial.print("Sensor LDR: "); // Alteração: Adicionando espaço após a mensagem
      Serial.println(leitura);
      delay(1000);
      return leitura;
    }

private:
    int ldrPin;
    int threshold;
};

LEDController ledController(redPin, greenPin);
BuzzerController buzzerController(buzzerPin);
LightSensor LDR(ldrPin, threshold);

void setup() {
    Serial.begin(9600);
}


void loop() {
      leitura = LDR.initSensor();
      tom = map(leitura, 70, 1000, 30, 2500);
    
    
    if (Serial.available() > 0) {
        String msg = Serial.readString();
        String new_msg = toUpperCase(msg);

        if (new_msg == "ON") {
            Serial.println(new_msg);
            ledController.turnOnGreenLED();
        

            if (leitura > threshold && new_msg == "ON") {
                Serial.println("\nLigando som...");
                Serial.println(tom);
                buzzerController.tocarSom(tom, tempo); 

                // Atualiza a leitura do sensor
                leitura = LDR.initSensor();

          
            }
        } if (new_msg == "OFF") {
            ledController.turnOffGreenLED();
            ledController.ligarLedVermelho();
        } else {
            ledController.blinkRedLED();
        }

        Serial.print("Mensagem via Python: ");
        Serial.println(msg);
    }
}
