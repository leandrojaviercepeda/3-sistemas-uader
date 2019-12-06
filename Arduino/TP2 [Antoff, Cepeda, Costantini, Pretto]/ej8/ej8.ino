#define SensorValue A0
#define ledContacto 11
#define ledNoContacto 10

void setup()
{
  Serial.begin(9600);
  //pinMode(A0, INPUT);
}

void loop()
{
  int contacto = analogRead(SensorValue);

  // pasamos la lectura analogica a digital
  if (contacto > 0) { contacto = 1; }
  
  Serial.print("Conctacto: ");
  Serial.println(contacto);

  if (contacto == 1){
    analogWrite(ledContacto, 200);
    analogWrite(ledNoContacto, 0);
  } else {
    analogWrite(ledNoContacto, 200);
    analogWrite(ledContacto, 0);
  }
  
  delay(100);
}
