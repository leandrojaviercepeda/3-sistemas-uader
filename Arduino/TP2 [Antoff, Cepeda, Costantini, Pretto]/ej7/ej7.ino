#define SensorValue A0
#define ledResistencia 11
#define ledIntesidad 10

void setup()
{
  Serial.begin(9600);
  //pinMode(A0, INPUT);
}

void loop()
{
  int rigidez = analogRead(SensorValue);

  Serial.print("Rigidez: ");
  Serial.println(rigidez);
  float resistencia = map(rigidez, 650, 1023, 255, 0);
  float intensidad = map(rigidez, 650, 1023, 0, 255);


  analogWrite(ledResistencia, resistencia);
  analogWrite(ledIntesidad, intensidad);
  
  delay(250);
}
