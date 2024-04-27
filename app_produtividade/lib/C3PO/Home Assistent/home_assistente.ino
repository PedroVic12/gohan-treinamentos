const int redPin = 2;
const int greenPin = 4;
const int buzzerPin = 6;
const int ldrPin = A0;
const int threshold = 500; // Defina um limite de luminosidade para acionar o buzzer

class LEDController {
public:
    LEDController(int redPin, int greenPin) : redPin(redPin), greenPin(greenPin) {
        pinMode(redPin, OUTPUT);
        pinMode(greenPin, OUTPUT);
    }

    void turnOnGreenLED() {
        digitalWrite(greenPin, HIGH);
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

    void buzz() {
        tone(buzzerPin, 1000); // Emitir um som de 1000Hz
        delay(500); // Manter o som por 500ms
        noTone(buzzerPin); // Parar de emitir som
    }

private:
    int buzzerPin;
};

class LightSensor {
public:
    LightSensor(int ldrPin, int threshold) : ldrPin(ldrPin), threshold(threshold) {
        pinMode(ldrPin, INPUT);
    }

    bool isDark() {
        int sensorValue = analogRead(ldrPin);
        return sensorValue < threshold;
    }

private:
    int ldrPin;
    int threshold;
};

LEDController ledController(redPin, greenPin);
BuzzerController buzzerController(buzzerPin);
LightSensor lightSensor(ldrPin, threshold);

void setup() {
    Serial.begin(9600);
}

void loop() {
    if (Serial.available() > 0) {
        String msg = Serial.readString();

        if (msg == "ON") {
            ledController.turnOnGreenLED();
        } else if (msg == "OFF") {
            ledController.turnOffGreenLED();
        } else {
            if (lightSensor.isDark()) {
                buzzerController.buzz();
            } else {
                ledController.blinkRedLED();
            }
        }
    }
}

