#define lecturaLuz A1
#define led 11

void setup() {
  Serial.begin(9600);  
  pinMode(led, OUTPUT);
}

void loop() {
  int valorLuz = analogRead(lecturaLuz);

  
  digitalWrite(led, LOW );
  delay(733);
  
  if (valorLuz > 900)      { Serial.println("Luminosidad maxima");                                       } 
  else if (valorLuz > 700) { Serial.println("Luminosidad alta");                                         } 
  else if (valorLuz > 500) { Serial.println("Luminosidad media");    analogWrite(led, 10 );  delay(733); } 
  else if (valorLuz > 300) { Serial.println("Luminosidad baja");     analogWrite(led, 100);  delay(733); } 
  else                     { Serial.println("Luminosidad muy baja"); analogWrite(led, 255);  delay(733); }

  
}
