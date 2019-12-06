#define pinRelay 10
String valor;

void setup() {
  Serial.begin (9600);
  pinMode(pinRelay, OUTPUT);
}
 
void loop()
{ 
  
  if (Serial.available() > 0){
    valor = Serial.readStringUntil('.');
    Serial.println(valor);
  } 

  if (valor == "1") {
    digitalWrite(pinRelay, HIGH);
  } else if (valor == "0") {
    digitalWrite(pinRelay, LOW);
  } 
}
