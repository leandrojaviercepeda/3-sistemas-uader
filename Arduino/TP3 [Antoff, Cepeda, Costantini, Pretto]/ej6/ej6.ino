#define trigPin  12
#define echoPin  10
#define buzzer 11
long duration, cm, inches;
int valorBuzzer = 20;
void setup() {
  Serial.begin (9600);
  //Define inputs and outputs
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(buzzer, OUTPUT);
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

  if (cm > 30) {
    analogWrite(buzzer, 0);
  } else if ((cm <= 30) && (cm >= 20)) {
    delay(1500);
    analogWrite(buzzer, valorBuzzer);
    delay(1500);
    analogWrite(buzzer, 0);
  } else if (cm >= 12) {
    delay(1000);
    analogWrite(buzzer, valorBuzzer);
    delay(1000);
    analogWrite(buzzer, 0);
  } else if (cm >= 6) {
    delay(500);
    analogWrite(buzzer, valorBuzzer);
    delay(500);
    analogWrite(buzzer, 0);
  } else if (cm >= 2) {
    delay(250);
    analogWrite(buzzer, valorBuzzer);
    delay(250);
    analogWrite(buzzer, 0);
  } else { analogWrite(buzzer, 0); }
  
  
  Serial.print("Distance: ");
  Serial.print(cm);
  Serial.println(" cm");
}
