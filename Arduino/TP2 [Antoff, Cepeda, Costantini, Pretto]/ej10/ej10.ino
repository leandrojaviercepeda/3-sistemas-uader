#define pinSwitch 3
#define rojo 11
#define verde 10

void setup() {
   Serial.begin(9600);
   pinMode(pinSwitch, INPUT);  
   pinMode(rojo, OUTPUT);
   pinMode(verde, OUTPUT);
      
}

void loop(){
   int estadoSwitch = digitalRead(pinSwitch);
   
   
   if (estadoSwitch == HIGH) {     
       Serial.println("Activado");
       delay(50);
       analogWrite(verde, 0);
       analogWrite(rojo, 200);
       delay(50);
       analogWrite(rojo, 0);
   } 
   else {
       Serial.println("Desactivado");
       analogWrite(verde, 200);
   }
}
