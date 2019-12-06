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
  
  
  if(humedad >= 1000) {
   Serial.println("Meté el sensor en la yerba o conectalo porfis");
  }
  if(humedad < 1000 && humedad >= 600) { 
   Serial.println("Yerba bastante seca");
  }
  if(humedad < 600 && humedad >= 370) {
   Serial.println("Yerba mojada"); 
  }
  if(humedad < 370) {
   Serial.println("Yerba muy mojada");
  }

  analogWrite(led, valorMapeado);
  delay(1000);
}
