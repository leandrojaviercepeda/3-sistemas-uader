#define sensor 2
bool mojado = false;
int cantidadMatesCebados = 0;
void setup()
{
  Serial.begin(9600);
  //pinMode(sensor, INPUT);
  
}

void loop()
{
  delay(3000);
  interrupts();
  if (!mojado) {
    attachInterrupt(digitalPinToInterrupt(sensor), sensorMojado, CHANGE);
  } 
  else {
    attachInterrupt(digitalPinToInterrupt(sensor), sensorSeco, CHANGE);
  }
}

void sensorMojado() {
  cantidadMatesCebados++;
  Serial.println("Mate cebado!");
  Serial.print("Cantidad mates cebados: ");
  Serial.println(cantidadMatesCebados);
  detachInterrupt(0);
  noInterrupts();
  mojado=true;
}

void sensorSeco() {
  //noInterrupts();
  Serial.println("Mate tomado!");
  detachInterrupt(0);
  attachInterrupt(digitalPinToInterrupt(sensor), sensorMojado, CHANGE);
  noInterrupts();
  mojado=false;
}

void activar() {
 
  
  
}
