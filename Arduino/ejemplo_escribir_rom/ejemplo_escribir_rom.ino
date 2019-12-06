#include <EEPROM.h>

/** the current address in the EEPROM (i.e. which byte we're going to write to next) **/
int addr = 0;

void setup() {
  /** Empty setup. **/
}

void loop() {

  int val = 23;

  EEPROM.write(addr, val);
  delay(5000);
  
}
