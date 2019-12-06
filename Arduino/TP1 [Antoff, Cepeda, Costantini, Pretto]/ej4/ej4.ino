#define led 11
#define potenciometro A1

int tiempo = 4;

void setup() {
  Serial.begin(9600);
  pinMode(led, OUTPUT);
}

void loop() {
    int lecturaPotenciometro = analogRead(potenciometro);
    int valorMapeado = map(lecturaPotenciometro, 0, 1023, 0, 255);
    analogWrite(led, valorMapeado);
}
