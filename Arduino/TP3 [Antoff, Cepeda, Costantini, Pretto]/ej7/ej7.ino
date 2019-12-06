#define trigPin  12
#define echoPin  10
#include <Wire.h>
#include "rgb_lcd.h"

rgb_lcd lcd;

long duration, cm, inches;
const int colorR = 255;
const int colorG = 0;
const int colorB = 0;
 
void setup() {
  Serial.begin (9600);
  //Define inputs and outputs
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  lcd.begin(16, 2);
  lcd.setRGB(colorR, colorG, colorB);
}
 
void loop()
{
  digitalWrite(trigPin, LOW);
  delayMicroseconds(5);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
 
  duration = pulseIn(echoPin, HIGH);
 
  // Calculating the distance
  cm = duration*0.034/2;

  Serial.print("Distance: ");
  Serial.print(cm);
  Serial.println(" cm");
  
  lcd.print(cm);
  lcd.setCursor(0, 0);
  
  delay(1000);
  lcd.clear();
}
