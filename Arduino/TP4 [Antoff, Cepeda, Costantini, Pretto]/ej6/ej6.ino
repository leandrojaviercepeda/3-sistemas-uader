#define led 12
#define sensorMovimiento 3

bool movimientoDetectado = false;

void setup() {
  Serial.begin(9600);
  pinMode(sensorMovimiento, INPUT);
  pinMode(led, OUTPUT);
  attachInterrupt(digitalPinToInterrupt(sensorMovimiento), detectarMovimiento, RISING);
}

void loop() {
  if (movimientoDetectado) {
    parpadearLed();
  }
}

void parpadearLed() {
  digitalWrite(led, HIGH);
  delay(100);
  digitalWrite(led, LOW);
  delay(100);
}

void detectarMovimiento() {
  movimientoDetectado = true;
  detachInterrupt(digitalPinToInterrupt(sensorMovimiento));
  attachInterrupt(digitalPinToInterrupt(sensorMovimiento), detectarQuietud, FALLING);
}

void detectarQuietud() {
  movimientoDetectado = false;
  detachInterrupt(digitalPinToInterrupt(sensorMovimiento));
  attachInterrupt(digitalPinToInterrupt(sensorMovimiento), detectarMovimiento, RISING);
}
