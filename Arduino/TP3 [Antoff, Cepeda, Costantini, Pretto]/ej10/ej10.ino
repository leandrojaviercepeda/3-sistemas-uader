#include <Servo.h>

#define pinServo 5
#define echoPin  10
#define trigPin  12
#define pinLaser 13

int angulo = 0;
int movimiento = 5;
long duration, cm, inches;
Servo servo;

void setup() {
  Serial.begin (9600);
  //Define inputs and outputs
  pinMode(trigPin, OUTPUT);
  pinMode(pinLaser, OUTPUT);
  pinMode(echoPin, INPUT);
  servo.attach(pinServo); 
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

  if (cm < 30) {
    prenderLaser();
  } else {
    apagarLaser();
    moverServo();
  }
  
  Serial.print("Distance: ");
  Serial.print(cm);
  Serial.println(" cm");
  
  delay(100);
}

void moverServo() {
  if ((angulo > 180) || (angulo < 0)) {
    movimiento = -movimiento;
  }
  
  angulo += movimiento;
  servo.write(angulo); 
}

void prenderLaser() {
  digitalWrite(pinLaser, HIGH);
}

void apagarLaser() {
  digitalWrite(pinLaser, LOW);
}
