#define pinServo 5
#include <Servo.h>
Servo servo;

void setup() {
   Serial.begin(9600);
   servo.attach(pinServo);     
}

void loop(){
  int angulo = random(0, 181);
  servo.write(angulo); 
  delay(100);
}
