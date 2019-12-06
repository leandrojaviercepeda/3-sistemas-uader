int dataIn = 5;
int load = 6;
int clock = 7;
const int tiempo = 1000;
 
int maxInUse = 2;    //change this variable to set how many MAX7219's you'll use
 
int e = 0;           // just a variable
 
// define max7219 registers
byte max7219_reg_noop        = 0x00;
byte max7219_reg_digit0      = 0x01;
byte max7219_reg_digit1      = 0x02;
byte max7219_reg_digit2      = 0x03;
byte max7219_reg_digit3      = 0x04;
byte max7219_reg_digit4      = 0x05;
byte max7219_reg_digit5      = 0x06;
byte max7219_reg_digit6      = 0x07;
byte max7219_reg_digit7      = 0x08;
byte max7219_reg_decodeMode  = 0x09;
byte max7219_reg_intensity   = 0x0a;
byte max7219_reg_scanLimit   = 0x0b;
byte max7219_reg_shutdown    = 0x0c;
byte max7219_reg_displayTest = 0x0f;
 
void putByte(byte data) {
  byte i = 8;
  byte mask;
  while(i > 0) {
    mask = 0x01 << (i - 1);      // get bitmask
    digitalWrite( clock, LOW);   // tick
    if (data & mask){            // choose bit
      digitalWrite(dataIn, HIGH);// send 1
    }else{
      digitalWrite(dataIn, LOW); // send 0
    }
      digitalWrite(clock, HIGH);   // tock
      --i;                         // move to lesser bit
  }
}
 
void maxSingle( byte reg, byte col) {    
//maxSingle is the "easy"  function to use for a single max7219
 
  digitalWrite(load, LOW);       // begin    
  putByte(reg);                  // specify register
  putByte(col);//((data & 0x01) * 256) + data >> 1); // put data  
  digitalWrite(load, LOW);       // and load da stuff
  digitalWrite(load,HIGH);
}
 
void maxAll (byte reg, byte col) {    // initialize  all  MAX7219's in the system
  int c = 0;
  digitalWrite(load, LOW);  // begin    
  for ( c =1; c<= maxInUse; c++) {
  putByte(reg);  // specify register
  putByte(col);//((data & 0x01) * 256) + data >> 1); // put data
  }
  digitalWrite(load, LOW);
  digitalWrite(load,HIGH);
}
 
void maxOne(byte maxNr, byte reg, byte col) {    
//maxOne is for addressing different MAX7219's,
//while having a couple of them cascaded
 
  int c = 0;
  digitalWrite(load, LOW);  // begin    
 
  for ( c = maxInUse; c > maxNr; c--) {
    putByte(0);    // means no operation
    putByte(0);    // means no operation
  }
 
  putByte(reg);  // specify register
  putByte(col);//((data & 0x01) * 256) + data >> 1); // put data
 
  for ( c =maxNr-1; c >= 1; c--) {
    putByte(0);    // means no operation
    putByte(0);    // means no operation
  }
 
  digitalWrite(load, LOW); // and load da stuff
  digitalWrite(load,HIGH);
}
 
 
void setup () {
  Serial.begin(9600);
  pinMode(dataIn, OUTPUT);
  pinMode(clock,  OUTPUT);
  pinMode(load,   OUTPUT);
 
  digitalWrite(13, HIGH);  
 
  //initiation of the max 7219
  maxAll(max7219_reg_scanLimit, 0x07);      
  maxAll(max7219_reg_decodeMode, 0x00);  // using an led matrix (not digits)
  maxAll(max7219_reg_shutdown, 0x01);    // not in shutdown mode
  maxAll(max7219_reg_displayTest, 0x00); // no display test
  for (e=1; e<=8; e++) {    // empty registers, turn all LEDs off
    maxAll(e,0);
  }
  maxAll(max7219_reg_intensity, 0x0f & 0x0f);    // the first 0x0f is the value you can set
                                                  // range: 0x00 to 0x0f
} 

const int DADO_GANADOR = 3;

void loop () { 
  Serial.println("Comenzando nuevo juego...");
  
  int ganador = jugar();
  Serial.print("El jugador nro ");
  Serial.print(ganador);
  Serial.println(" sacó el numero ganador!");

  delay(5000);
}
int jugar() {
  
  while(true) {
    int tiradaJugador1 = elegirRandom(1);
    if (tiradaJugador1 == DADO_GANADOR)
      return 1;
      
    Serial.print("Dado jugador1: ");
    Serial.println(tiradaJugador1);
    
    delay(3000);
    int tiradaJugador2 = elegirRandom(2);
    if (tiradaJugador2 == DADO_GANADOR)
      return 2;

    Serial.print("Dado jugador2: ");
    Serial.println(tiradaJugador2);
    delay(3000);
  }
}


  
int elegirRandom(int numeroDisplay) {
  int eleccion = random(1,7);

  switch (eleccion) {
    case 1:
      espada(numeroDisplay);
      break;
    case 2:
      escudo(numeroDisplay);
      break;
    case 3:
      casco(numeroDisplay);
      break;
    case 4:
      mover(numeroDisplay);
      break;
    case 5:
      pierde_turno(numeroDisplay);
      break;
    case 6:
      power_up(numeroDisplay);
      break;
  } 

  return eleccion;
}

void espada(int numeroDisplay) { 
  maxOne(numeroDisplay,1,3);
  maxOne(numeroDisplay,2,7);
  maxOne(numeroDisplay,3,78);
  maxOne(numeroDisplay,4,60);
  maxOne(numeroDisplay,5,56);
  maxOne(numeroDisplay,6,120);
  maxOne(numeroDisplay,7,228);
  maxOne(numeroDisplay,8,192);
}
void escudo(int numeroDisplay) { 
  maxOne(numeroDisplay,1,129);
  maxOne(numeroDisplay,2,255);
  maxOne(numeroDisplay,3,255);
  maxOne(numeroDisplay,4,255);
  maxOne(numeroDisplay,5,255);
  maxOne(numeroDisplay,6,126);
  maxOne(numeroDisplay,7,60);
  maxOne(numeroDisplay,8,24);
}
void casco(int numeroDisplay) { 
  maxOne(numeroDisplay,1,60);
  maxOne(numeroDisplay,2,126);
  maxOne(numeroDisplay,3,255);
  maxOne(numeroDisplay,4,255);
  maxOne(numeroDisplay,5,219);
  maxOne(numeroDisplay,6,219);
  maxOne(numeroDisplay,7,195);
  maxOne(numeroDisplay,8,195);
}
void mover(int numeroDisplay) { 
  maxOne(numeroDisplay,1,15);
  maxOne(numeroDisplay,2,7);
  maxOne(numeroDisplay,3,7);
  maxOne(numeroDisplay,4,9);
  maxOne(numeroDisplay,5,16);
  maxOne(numeroDisplay,6,32);
  maxOne(numeroDisplay,7,64);
  maxOne(numeroDisplay,8,128);
}
void pierde_turno(int numeroDisplay) { 
  maxOne(numeroDisplay,1,129);
  maxOne(numeroDisplay,2,66);
  maxOne(numeroDisplay,3,36);
  maxOne(numeroDisplay,4,24);
  maxOne(numeroDisplay,5,24);
  maxOne(numeroDisplay,6,36);
  maxOne(numeroDisplay,7,66);
  maxOne(numeroDisplay,8,129);
}
void power_up(int numeroDisplay) { 
  maxOne(numeroDisplay,1,24);
  maxOne(numeroDisplay,2,60);
  maxOne(numeroDisplay,3,126);
  maxOne(numeroDisplay,4,219);
  maxOne(numeroDisplay,5,24);
  maxOne(numeroDisplay,6,24);
  maxOne(numeroDisplay,7,24);
  maxOne(numeroDisplay,8,24);
}
