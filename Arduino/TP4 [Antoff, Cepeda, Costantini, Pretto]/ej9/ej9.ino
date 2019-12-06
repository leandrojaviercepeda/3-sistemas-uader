#define relay 12
#define sensorHumedad 3

void setup() {
  Serial.begin(9600);
  pinMode(sensorHumedad, INPUT);
  pinMode(relay, OUTPUT);
  attachInterrupt(digitalPinToInterrupt(sensorHumedad), detectarSequia, FALLING);
}

void loop() {
}

void detectarSequia() {
  digitalWrite(relay, HIGH);
  detachInterrupt(digitalPinToInterrupt(sensorHumedad));
  attachInterrupt(digitalPinToInterrupt(sensorHumedad), detectarHumedad, RISING);
}

void detectarHumedad() {
  digitalWrite(relay, LOW);
  detachInterrupt(digitalPinToInterrupt(sensorHumedad));
  attachInterrupt(digitalPinToInterrupt(sensorHumedad), detectarSequia, FALLING);
}
