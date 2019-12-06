#include <EEPROM.h>

// start reading from the first byte (address 0) of the EEPROM
int address = 0;
byte value;

void setup() {
  Serial.begin(9600);
}

void loop() {
  value = EEPROM.read(address);
  Serial.println(value, DEC);
  delay(1000);
}
