#define canalRojo 12
#define canalVerde 11
#define canalAzul 10

int tiempo = 4;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(canalRojo, OUTPUT);
  pinMode(canalVerde, OUTPUT);
  pinMode(canalAzul, OUTPUT);
}

void loop() {

  if (Serial.available() > 0){
    String valor = Serial.readString();
    Serial.println(valor);

    colorRGB(valor.toInt(), tiempo);
  }
    
}

void colorRGB(int opcion, int segundos) {

    switch (opcion) {
      case 1:
        prender(canalRojo);
        break;
      case 2:
        prender(canalVerde);
        break;
      case 3:
        prender(canalAzul);
        break;
      case 4:
        prender(canalRojo);
        prender(canalVerde);
        break;
      case 5:
        prender(canalRojo);
        prender(canalAzul);
        break;
      case 6:
        prender(canalVerde);
        prender(canalAzul);
        break;
      case 7:
        prender(canalVerde);
        prender(canalRojo);
        prender(canalAzul);
        break;
    }
    
    delay(1000 * segundos);
    digitalWrite(canalRojo, LOW);
    digitalWrite(canalVerde, LOW);
    digitalWrite(canalAzul, LOW);
}

void prender(int led){
  digitalWrite(led, HIGH);
}
  
