#define SensorValue A0
#define led 11

void setup()
{
  Serial.begin(9600);
  //pinMode(A0, INPUT);
}

void loop()
{
  int humedad = analogRead(SensorValue);
  Serial.print(humedad); Serial.print(" - ");
  float valorMapeado = map(humedad, 0, 1023, 255, 0);
  
  
  if(humedad >= 800) {
   Serial.println("Llovizna");
  }
  if(humedad < 800 && humedad >= 500) { 
   Serial.println("Lluvia débil");
  }
  if(humedad < 500) {
   Serial.println("Lluvia fuerte");
  }

  analogWrite(led, valorMapeado);
  delay(250);
}
