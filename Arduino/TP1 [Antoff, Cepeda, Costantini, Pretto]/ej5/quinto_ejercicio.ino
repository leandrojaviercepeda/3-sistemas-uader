#define R 12
#define G 11
#define B 10
#define potenciometroR A1
#define potenciometroG A2
#define potenciometroB A3


int tiempo = 4;

void setup() {
  
  Serial.begin(9600);
  pinMode(R, OUTPUT);
  pinMode(G, OUTPUT);
  pinMode(B, OUTPUT);
}

void loop() {
    int lecturaPotenciometroR = analogRead(potenciometroR);
    int lecturaPotenciometroG = analogRead(potenciometroG);
    int lecturaPotenciometroB = analogRead(potenciometroB);
    
    int valorMapeadoR = map(lecturaPotenciometroR, 0, 1023, 0, 255);
    int valorMapeadoG = map(lecturaPotenciometroG, 0, 1023, 0, 255);
    int valorMapeadoB = map(lecturaPotenciometroB, 0, 1023, 0, 255);
    
    analogWrite(R, valorMapeadoR);
    analogWrite(G, valorMapeadoG);
    analogWrite(B, valorMapeadoB);
}
