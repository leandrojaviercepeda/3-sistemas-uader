#define trigPin  12
#define echoPin  10
#define led 11
long duration, cm, inches;
 
void setup() {
  Serial.begin (9600);
  //Define inputs and outputs
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(led, OUTPUT);
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
    digitalWrite(led, LOW);
  } else {
    int valorMapeado = map(cm, 0, 30, 0, 255);
    analogWrite(led, valorMapeado);
  }
  Serial.print("Distance: ");
  Serial.print(cm);
  Serial.println(" cm");
  
  delay(100);
}
