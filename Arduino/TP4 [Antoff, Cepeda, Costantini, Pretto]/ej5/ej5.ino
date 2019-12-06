#define pinServo 5
#define pinFuego 2
#include <Servo.h>
Servo servo;

void setup() {
   Serial.begin(9600);
   servo.attach(pinServo);  
   attachInterrupt(digitalPinToInterrupt(pinFuego), moverServo97, FALLING);
}

void loop(){}

void moverServo97() { 
  Serial.println(97);
  servo.write(97); 
  detachInterrupt(digitalPinToInterrupt(pinFuego));
  attachInterrupt(digitalPinToInterrupt(pinFuego), moverServo0, RISING);
}
void moverServo0()  { 
  Serial.println(0);
  servo.write(0);
  detachInterrupt(digitalPinToInterrupt(pinFuego));
  attachInterrupt(digitalPinToInterrupt(pinFuego), moverServo97, FALLING);
}
