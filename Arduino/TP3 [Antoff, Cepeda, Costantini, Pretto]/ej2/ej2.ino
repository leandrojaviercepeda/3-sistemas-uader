#define pinServo 5
#define potenciometro A1
#include <Servo.h>
Servo servo;

void setup() {
   Serial.begin(9600);
   servo.attach(pinServo);     
}

void loop(){
  int lecturaPotenciometro = analogRead(potenciometro);
  int angulo = map(lecturaPotenciometro, 0, 1023, 0, 180);
  servo.write(angulo); 
}
