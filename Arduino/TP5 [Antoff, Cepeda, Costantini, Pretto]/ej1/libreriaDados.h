#ifndef libreriaDados_h
#define libreriaDados_h


#include "Arduino.h"


class Dados
{
  public:
    Dados(int dadoGanador);
    void jugar();
  private:
    int _dadoGanador = 3;
    
    const int dataIn = 5;
    const int load = 6;
    const int clock = 7;
    
    const int tiempo = 1000;
    const int maxInUse = 2;
    const byte max7219_reg_noop = 0x00;
    const byte max7219_reg_digit0 = 0x01;
    const byte max7219_reg_digit1 = 0x02;
    const byte max7219_reg_digit2 = 0x03;
    const byte max7219_reg_digit3 = 0x04;
    const byte max7219_reg_digit4 = 0x05;
    const byte max7219_reg_digit5 = 0x06;
    const byte max7219_reg_digit6 = 0x07;
    const byte max7219_reg_digit7 = 0x08;
    const byte max7219_reg_decodeMode = 0x09;
    const byte max7219_reg_intensity = 0x0a;
    const byte max7219_reg_scanLimit = 0x0b;
    const byte max7219_reg_shutdown = 0x0c;
    const byte max7219_reg_displayTest = 0x0f;
    void putByte(byte data);
    void maxSingle(byte data);
    void maxAll(byte reg, byte col);
    void maxOne(byte maxNr, byte reg, byte col);
    int elegirRandom(int numeroDisplay);
    void espada(int numeroDisplay);
    void escudo(int numeroDisplay);
    void casco(int numeroDisplay);
    void mover(int numeroDisplay);
    void pierde_turno(int numeroDisplay);
    void power_up(int numeroDisplay);
};
#endif
