#define boton 2
#define ledRojo 11
#define ledVerde 10
#define ledAzul 9

void setup()
{
  Serial.begin(9600);
  pinMode(boton, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(boton), contacto, CHANGE);

}

//en vez de usar un RGB usamos 3 leds diferentes
void loop()
{

}

void contacto (){
  int contacto = digitalRead(boton);
  Serial.print("Conctacto: ");
  Serial.println(contacto);
    if (contacto == 0){
    int decision = random(0, 3);
    leds(decision);
    Serial.print("Decision: ");
    Serial.println(decision);
    } else {
    analogWrite(ledVerde, 0);
    analogWrite(ledRojo, 0);
    analogWrite(ledAzul, 0);
  }
}


void leds (int decision){
    if (decision == 1){
      analogWrite(ledVerde, 200);
      analogWrite(ledRojo, 0);
      analogWrite(ledAzul, 0);
    } else if (decision == 2) {
      analogWrite(ledRojo, 200);
      analogWrite(ledVerde, 0);
      analogWrite(ledAzul, 0);
    } else {
      analogWrite(ledAzul, 200);
      analogWrite(ledVerde, 0);
      analogWrite(ledRojo, 0);
    }
}