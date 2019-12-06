#define pin 12

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(pin, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  delay(1000);
  
  if (Serial.available() > 0){
    String valor = Serial.readStringUntil('.');
    Serial.println(valor);
    
    if (valor == "ivan") {
      Serial.println("prendi3");
      digitalWrite(pin, HIGH);
    } else if (valor == "maxi") {
      Serial.println("apaga2");
      digitalWrite(pin, LOW);
    } else { Serial.println("tirame un comando amiguero"); }
  }
  
  
}
