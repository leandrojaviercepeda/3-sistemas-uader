#define lecturaLuz A1
#define led 11

void setup() {
  Serial.begin(9600);  
  pinMode(led, OUTPUT);
}

void loop() {
  int valorLuz = analogRead(lecturaLuz);        
  int valorMapeado = map(valorLuz, 300, 900, 255, 0);
  analogWrite(led, valorMapeado);

 
  Serial.print("valormapeado = " );              
  Serial.println(valorMapeado);                

}
