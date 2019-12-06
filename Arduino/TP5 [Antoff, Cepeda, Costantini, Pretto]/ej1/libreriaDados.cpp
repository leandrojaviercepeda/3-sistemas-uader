#include "Arduino.h"
#include "libreriaDados.h"
#include <stdio.h>

Dados::Dados(int dadoGanador)
{
  _dadoGanador = dadoGanador;
  
  pinMode(dataIn, OUTPUT);
  pinMode(load, OUTPUT);
  pinMode(clock, OUTPUT);
}

void Dados::jugar() {

  while (true) {
    int tiradaJugador1 = elegirRandom(1);
    if (tiradaJugador1 == _dadoGanador) {
      Serial.println("Gana el jugador 1!");
    } else {
      Serial.print("Dado jugador1: ");
      Serial.println(tiradaJugador1);
    }
    delay(3000);
    
    int tiradaJugador2 = elegirRandom(2);
    if (tiradaJugador2 == _dadoGanador) {
      Serial.println("Gana el jugador 2!");
    } else {
      Serial.print("Dado jugador2: ");
      Serial.println(tiradaJugador2);
    }
    delay(3000);
    
  }
}

int Dados::elegirRandom(int numeroDisplay) {
  int eleccion = random(1, 7);

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

void Dados::putByte(byte data) {
  byte i = 8;
  byte mask;
  while (i > 0) {
    mask = 0x01 << (i - 1);      // get bitmask
    digitalWrite( clock, LOW);   // tick
    if (data & mask) {           // choose bit
      digitalWrite(dataIn, HIGH);// send 1
    } else {
      digitalWrite(dataIn, LOW); // send 0
    }
    digitalWrite(clock, HIGH);   // tock
    --i;                         // move to lesser bit
  }
}

void Dados::maxAll (byte reg, byte col) {    // initialize  all  MAX7219's in the system
  int c = 0;
  digitalWrite(load, LOW);  // begin
  for (c = 1; c <= maxInUse; c++) {
    putByte(reg);  // specify register
    putByte(col);//((data & 0x01) * 256) + data >> 1); // put data
  }
  digitalWrite(load, LOW);
  digitalWrite(load, HIGH);
}

void Dados::maxOne(byte maxNr, byte reg, byte col) {
  //maxOne is for addressing different MAX7219's,
  //while having a couple of them cascaded

  int c = 0;
  digitalWrite(load, LOW);  // begin

  for (c = maxInUse; c > maxNr; c--) {
    putByte(0);    // means no operation
    putByte(0);    // means no operation
  }

  putByte(reg);  // specify register
  putByte(col);//((data & 0x01) * 256) + data >> 1); // put data

  for (c = maxNr - 1; c >= 1; c--) {
    putByte(0);    // means no operation
    putByte(0);    // means no operation
  }

  digitalWrite(load, LOW); // and load da stuff
  digitalWrite(load, HIGH);
}

void Dados::espada(int numeroDisplay) {
  maxOne(numeroDisplay, 1, 3);
  maxOne(numeroDisplay, 2, 7);
  maxOne(numeroDisplay, 3, 78);
  maxOne(numeroDisplay, 4, 60);
  maxOne(numeroDisplay, 5, 56);
  maxOne(numeroDisplay, 6, 120);
  maxOne(numeroDisplay, 7, 228);
  maxOne(numeroDisplay, 8, 192);
}

void Dados::escudo(int numeroDisplay) {
  maxOne(numeroDisplay, 1, 129);
  maxOne(numeroDisplay, 2, 255);
  maxOne(numeroDisplay, 3, 255);
  maxOne(numeroDisplay, 4, 255);
  maxOne(numeroDisplay, 5, 255);
  maxOne(numeroDisplay, 6, 126);
  maxOne(numeroDisplay, 7, 60);
  maxOne(numeroDisplay, 8, 24);
}

void Dados::casco(int numeroDisplay) {
  maxOne(numeroDisplay, 1, 60);
  maxOne(numeroDisplay, 2, 126);
  maxOne(numeroDisplay, 3, 255);
  maxOne(numeroDisplay, 4, 255);
  maxOne(numeroDisplay, 5, 219);
  maxOne(numeroDisplay, 6, 219);
  maxOne(numeroDisplay, 7, 195);
  maxOne(numeroDisplay, 8, 195);
}

void Dados::mover(int numeroDisplay) {
  maxOne(numeroDisplay, 1, 15);
  maxOne(numeroDisplay, 2, 7);
  maxOne(numeroDisplay, 3, 7);
  maxOne(numeroDisplay, 4, 9);
  maxOne(numeroDisplay, 5, 16);
  maxOne(numeroDisplay, 6, 32);
  maxOne(numeroDisplay, 7, 64);
  maxOne(numeroDisplay, 8, 128);
}

void Dados::pierde_turno(int numeroDisplay) {
  maxOne(numeroDisplay, 1, 129);
  maxOne(numeroDisplay, 2, 66);
  maxOne(numeroDisplay, 3, 36);
  maxOne(numeroDisplay, 4, 24);
  maxOne(numeroDisplay, 5, 24);
  maxOne(numeroDisplay, 6, 36);
  maxOne(numeroDisplay, 7, 66);
  maxOne(numeroDisplay, 8, 129);
}

void Dados::power_up(int numeroDisplay) {
  maxOne(numeroDisplay, 1, 24);
  maxOne(numeroDisplay, 2, 60);
  maxOne(numeroDisplay, 3, 126);
  maxOne(numeroDisplay, 4, 219);
  maxOne(numeroDisplay, 5, 24);
  maxOne(numeroDisplay, 6, 24);
  maxOne(numeroDisplay, 7, 24);
  maxOne(numeroDisplay, 8, 24);
}
