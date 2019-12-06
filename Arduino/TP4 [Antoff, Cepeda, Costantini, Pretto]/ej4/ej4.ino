#define pinSensor 2

void setup()
{
  Serial.begin(9600);
  attachInterrupt(digitalPinToInterrupt(pinSensor), llueve, RISING);
}

void loop()
{
}

void llueve() {
    Serial.println("Llueve.");
    detachInterrupt(digitalPinToInterrupt(pinSensor));
    attachInterrupt(digitalPinToInterrupt(pinSensor), noLlueve, FALLING);
}

void noLlueve() {
    Serial.println("No llueve más.");
    detachInterrupt(digitalPinToInterrupt(pinSensor));
    attachInterrupt(digitalPinToInterrupt(pinSensor), llueve, RISING);
}
