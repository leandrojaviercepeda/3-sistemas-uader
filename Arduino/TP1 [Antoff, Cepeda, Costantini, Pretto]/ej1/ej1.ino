#define led1 12

int tiempo = 1000;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(led1, OUTPUT);
}

void loop() {
  digitalWrite(led1, HIGH);
  delay(tiempo);
  digitalWrite(led1, LOW);
  delay(tiempo);
}
