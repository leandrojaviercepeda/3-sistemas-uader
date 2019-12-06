#include <SFE_BMP180.h>
#define verde 20
#define rojo 21

SFE_BMP180 bmp180;

void setup()
{
  Serial.begin(9600);

  if (bmp180.begin())
    Serial.println("BMP180 iniciado correctamenten");
  else
  {
    Serial.println("Error al iniciar el BMP180");
    while(1); // bucle infinito
  }
}

void loop()
{
  char status;
  double T,P;

  status = bmp180.startTemperature();//Inicio de lectura de temperatura
  if (status != 0)
  {   
    delay(status); //Pausa para que finalice la lectura
    status = bmp180.getTemperature(T); //Obtener la temperatura
    if (status != 0)
    {
      status = bmp180.startPressure(3); //Inicio lectura de presión
      if (status != 0)
      {        
        delay(status);//Pausa para que finalice la lectura        
        status = bmp180.getPressure(P,T); //Obtenemos la presión
        if (status != 0)
        {                  
          Serial.print("Temperatura: ");
          Serial.print(T,2);
          Serial.print(" °C , ");
          Serial.print("Presion: ");
          Serial.print(P,2);
          Serial.println(" mb");  
          
          
          
          if (P < 1025)
          {
            analogWrite(verde, 250);
            Serial.println("Presión baja");
            delay(2150);
            digitalWrite(verde, LOW);
            delay(2150);
          } else
          {
            analogWrite(rojo, 250);
            Serial.println("Presión alta");
            delay(1000);
            digitalWrite(rojo, LOW);
            delay(1000);
          }
        }      
      }      
    }   
  } 
  delay(1000);
}
