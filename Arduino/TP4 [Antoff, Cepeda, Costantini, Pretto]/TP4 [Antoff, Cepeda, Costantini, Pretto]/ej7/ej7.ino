#define led 12
#define sensorTilt 3

int cantidadParpadeos = 0;

void setup() {
  Serial.begin(9600);
  pinMode(sensorTilt, INPUT);
  pinMode(led, OUTPUT);
  attachInterrupt(digitalPinToInterrupt(sensorTilt), detectarMovimiento, RISING);
}

void loop() {
  if (cantidadParpadeos > 0) {
    parpadearLed();
    cantidadParpadeos--;
  }
}

void parpadearLed() {
  digitalWrite(led, HIGH);
  delay(500);
  digitalWrite(led, LOW);
  delay(500);
}

void detectarMovimiento() {
  if (cantidadParpadeos == 10) {
    cantidadParpadeos = 0;
  } else {
    cantidadParpadeos++;
  }
}
