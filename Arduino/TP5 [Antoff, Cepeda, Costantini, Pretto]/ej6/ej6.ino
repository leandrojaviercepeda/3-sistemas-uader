#define pinServo 5
#define pinSwitch 3
#include <Servo.h>
#include <LowPower.h>

Servo servo;

void setup() {
   Serial.begin(9600);
   servo.attach(pinServo);  
}

void loop(){
  attachInterrupt(digitalPinToInterrupt(pinSwitch), moverServo, RISING);
  LowPower.powerDown(SLEEP_FOREVER, ADC_OFF, BOD_OFF);
  
  Serial.println(digitalRead(pinSwitch));
  delay(2000);
  servo.write(0);

  detachInterrupt(digitalPinToInterrupt(pinSwitch));
}

void moverServo() { servo.write(90); }
