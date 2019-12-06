#define led1 12
#define led2 11
#define led3 10

int tiempo = 6;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(led3, OUTPUT);
}

void loop() {
  int numero_aleatorio = random(0,11);
  Serial.println(numero_aleatorio);

  if (numero_aleatorio == 1 || numero_aleatorio == 3 || numero_aleatorio == 7)
    prender_y_esperar(led1, tiempo);
  else if (numero_aleatorio == 0 || numero_aleatorio == 2 || numero_aleatorio == 8)
    prender_y_esperar(led3, tiempo);
  else if (numero_aleatorio == 4 || numero_aleatorio == 5 || numero_aleatorio == 9 || numero_aleatorio == 6)
    prender_y_esperar(led2, tiempo);
    
}

void prender_y_esperar(int led, int segundos) {
    digitalWrite(led, HIGH);
    delay(1000 * segundos);
    digitalWrite(led, LOW);
}
