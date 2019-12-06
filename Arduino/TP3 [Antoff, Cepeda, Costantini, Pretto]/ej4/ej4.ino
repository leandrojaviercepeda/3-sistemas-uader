#define potenciometro A1
#define dc 11
#include <Servo.h>


void setup() {
   Serial.begin(9600); 
}

void loop(){
  int lecturaPotenciometro = analogRead(potenciometro);
  int valorMapeado = map(lecturaPotenciometro, 0, 1023, 0, 254);
  analogWrite(dc, valorMapeado); 
  Serial.println(valorMapeado);
}
