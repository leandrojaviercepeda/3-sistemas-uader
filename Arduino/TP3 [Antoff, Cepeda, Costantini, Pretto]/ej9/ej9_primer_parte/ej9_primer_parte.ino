#define din 5 
#define cs 6
#define clk 7
#include <LedControl.h>

LedControl lc = LedControl(din, clk, cs, 0);
void printByte(byte character [])

{
  int i = 0;
  for(i=0;i<8;i++)
  {
    lc.setRow(0,i,character[i]);
  }
}

const byte carita[8] {
  B00100100,
  B00100100,
  B00100100,
  B00100100,
  B10000001,
  B10000001,
  B01000010,
  B00111100
};

const byte uno[8] = {
  B00001000,
  B00011000,
  B00101000,
  B00001000,
  B00001000,
  B00001000,
  B00001000,
  B00111110
};

const byte dos[8] = {
  B00011100,
  B00100010,
  B00000010,
  B00000100,
  B00001000,
  B00010000,
  B00100000,
  B00111110
};

const byte tres[8] = {
  B00000000,
  B00011000,
  B00100100,
  B00000100,
  B00011000,
  B00000100,
  B00100100,
  B00011000
};

const byte cuatro[8] = {
  B00000000,
  B00100100,
  B00100100,
  B00100100,
  B00111100,
  B00000100,
  B00000100,
  B00000100
};

const byte cinco[8] = {
  B01111100,
  B01000000,
  B01000000,
  B01111000,
  B00000100,
  B00000100,
  B00000100,
  B01111000
};

const byte seis[8] = {
  B00011000,
  B00100100,
  B01000000,
  B01011000,
  B01100100,
  B01000100,
  B00100100,
  B00011000
};

void setup() {
  Serial.begin (9600);
  lc.shutdown(0, false);
  lc.setIntensity(0, 15);
  lc.clearDisplay(0);

  Serial.println(lc.getDeviceCount());
}

void loop() {
  int eleccion = random(7);
  
  switch (eleccion) {
  case 1:
    printByte(uno);
    break;
  case 2:
    printByte(dos);
    break;
  case 3:
    printByte(tres);
    break;
  case 4:
    printByte(cuatro);
    break;
  case 5:
    printByte(cinco);
    break;
  case 6:
    printByte(seis);
    break;
  }

  delay(1000);
}
