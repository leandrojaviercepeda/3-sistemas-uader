#define pinServo 5
#include <Servo.h>
Servo servo;
int contador = 0;
int tiempo = 1000;

void setup() {
   Serial.begin(9600);
   servo.attach(pinServo);     
}

void loop(){
  int angulo = random(0, 181);
  servo.write(angulo); 
  delay(tiempo);
  contador++;

  if (contador == 3) {
    Serial.print("Último ángulo: ");
    Serial.println(angulo);
    servo.write(0); 
    delay(tiempo);
    servo.write(90); 
    delay(tiempo);
    servo.write(180); 
    delay(tiempo);
    contador = 0;
  }
}
