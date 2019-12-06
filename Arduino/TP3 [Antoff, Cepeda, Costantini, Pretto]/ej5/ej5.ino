// Definimos los pines donde tenemos conectadas las bobinas
#define IN1  8
#define IN2  9
#define IN3  10
#define IN4  11
 
// Secuencia de pasos (par máximo)
int pasoDerecha [4][4] =
{
  {1, 1, 0, 0},
  {0, 1, 1, 0},
  {0, 0, 1, 1},
  {1, 0, 0, 1}
};

int pasoIzquierda [4][4] =
{
  {1, 0, 0, 1},
  {0, 0, 1, 1},
  {0, 1, 1, 0},
  {1, 1, 0, 0}
};
void setup()
{
  Serial.begin(9600);
  // Todos los pines en modo salida
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(IN3, OUTPUT);
  pinMode(IN4, OUTPUT);
}
 
 
 
void loop()
{ 
    int pasos = random(100, 300);
    Serial.print("Pasos derecha: ");
    Serial.println(pasos);
    for (int j = 0; j < pasos; j++) {
      for (int i = 0; i < 4; i++) {
        digitalWrite(IN1, pasoDerecha[i][0]);
        digitalWrite(IN2, pasoDerecha[i][1]);
        digitalWrite(IN3, pasoDerecha[i][2]);
        digitalWrite(IN4, pasoDerecha[i][3]);
        delay(10);
      }
    }
    pasos = random(100, 300);
    Serial.print("Pasos izquierda: ");
    Serial.println(pasos);
    for (int j = 0; j < pasos; j++) {
      for (int i = 0; i < 4; i++) {
        digitalWrite(IN1, pasoIzquierda[i][0]);
        digitalWrite(IN2, pasoIzquierda[i][1]);
        digitalWrite(IN3, pasoIzquierda[i][2]);
        digitalWrite(IN4, pasoIzquierda[i][3]);
        delay(10);
      }
    }
}
