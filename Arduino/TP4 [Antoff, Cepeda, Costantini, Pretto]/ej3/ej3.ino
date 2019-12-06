#define pinServo 5
#define pinSwitch 3
#include <Servo.h>
Servo servo;

void setup() {
   Serial.begin(9600);
   servo.attach(pinServo);  
   attachInterrupt(digitalPinToInterrupt(pinSwitch), moverServo, RISING);
}

void loop(){
  Serial.println(digitalRead(pinSwitch));
  delay(2000);
  servo.write(0);
}

void moverServo() { servo.write(90); }
