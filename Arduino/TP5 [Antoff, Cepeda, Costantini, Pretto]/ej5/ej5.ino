#include "LowPower.h"
#define ldr A1


void setup() {
  Serial.begin(9600);  
}

void loop() {
  Serial.println("Leyendo valor de luz..");
  int valorLuz = analogRead(ldr);
  Serial.println(valorLuz);
  Serial.println("Durmiendo por 8seg..");
  LowPower.powerDown(SLEEP_8S, ADC_OFF, BOD_OFF);
}
