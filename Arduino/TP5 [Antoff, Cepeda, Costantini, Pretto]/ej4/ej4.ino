#include <SoftwareSerial.h>
#define pinRelay 10

/*
NOMBRE: BLUE4 (V)
PIN: 4444
*/

SoftwareSerial BT(2, 3); //2 TX, 3 RX.


void setup()
{
  BT.begin(9600);
  Serial.begin(9600);
  pinMode(pinRelay, OUTPUT);
}

void loop()
{
  //Cuando haya datos disponibles
  if (BT.available())
  {
    String valor = BT.readString();
    Serial.println(valor);
    BT.write("recibido.");

    if (valor == "1") {
      digitalWrite(pinRelay, HIGH);
      Serial.println("PRENDIDO");
    } else if (valor == "0") {
      digitalWrite(pinRelay, LOW);
      Serial.println("APAGADO");
    }
  }
  
}
