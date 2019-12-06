
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  
  
  Serial.println(getMensaje());
  delay(1000);
}

String getMensaje() {
  if (Serial.available() > 0 )
    return Serial.readStringUntil('.');
  else return "";
}
