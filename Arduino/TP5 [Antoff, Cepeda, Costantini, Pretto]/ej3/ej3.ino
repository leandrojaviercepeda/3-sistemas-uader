#define pinServo 5
#define ledRojo 10
#define ledVerde 9
#define buzzer 6
#include <Servo.h>
#include <IRremote.h>
Servo servo;

const int valorBuzzer = 20;
int movimiento = 5;
int angulo = 0;

const long int ARRIBA = 16736925;
const long int IZQUIERDA = 16720605;
const long int DERECHA = 16761405;
const long int ABAJO = 16754775;
const long int OK = 16712445;
const long int CERO = 16730805;
const long int UNO = 16738455;
const long int DOS = 16750695;
const long int TRES = 16756815;
const long int CUATRO = 16724175;
const long int CINCO = 16718055;
const long int SEIS = 16743045;
const long int SIETE = 16716015;
const long int OCHO = 16726215;
const long int NUEVE = 16734885;
const long int ASTERISCO = 16728765;
const long int HASHTAG = 16732845;

const int c = 261;
const int d = 294;
const int e = 329;
const int f = 349;
const int g = 391;
const int gS = 415;
const int a = 440;
const int aS = 466;
const int b = 494;
const int cH = 523;
const int cSH = 554;
const int dH = 587;
const int dSH = 622;
const int eH = 659;
const int fH = 698;
const int fSH = 740;
const int gH = 784;
const int gSH = 830;
const int aH = 880;

int RECV_PIN = 11;
IRrecv irrecv(RECV_PIN);
decode_results results;

void setup() {
  Serial.begin(9600);
  servo.attach(pinServo);  
  pinMode(ledRojo, OUTPUT);
  pinMode(ledVerde, OUTPUT);
  pinMode(buzzer, OUTPUT);
  Serial.println("Enabling IRin");
  irrecv.enableIRIn();
  Serial.println("Enabled IRin");   
}

void loop() {

  if (irrecv.decode(&results)) {
    moverRandom(results.value);
    ledYBeep(results.value);
    Serial.println(results.value);
    irrecv.resume(); // Receive the next value
  }
  delay(100);
}

// Parte A
void moverRandom(long int codigo) {
    int valorRandom;
    
    switch (codigo) {
  
    case CERO: 
      valorRandom = random(0, 161);
      break;
    case UNO: 
      valorRandom = random(1, 161);
      break;
    case DOS: 
      valorRandom = random(2, 161);
      break;
    case TRES: 
      valorRandom = random(3, 161);
      break;
    case CUATRO: 
      valorRandom = random(4, 161);
      break;
    case CINCO: 
      valorRandom = random(5, 161);
      break;
    case SEIS: 
      valorRandom = random(6, 161);
      break;
    case SIETE: 
      valorRandom = random(7, 161);
      break;
    case OCHO: 
      valorRandom = random(8, 161);
      break;
    case NUEVE: 
      valorRandom = random(9, 161);
      break;
  }

  servo.write(valorRandom);
}

// Parte B, C y D

void ledYBeep(long int codigo) {
    
    switch (codigo) {
  
      case ARRIBA: 
        digitalWrite(ledRojo, HIGH);
        delay(1000);
        digitalWrite(ledRojo, LOW);
        break;
      case ABAJO:
        digitalWrite(ledVerde, HIGH);
        delay(1000);
        digitalWrite(ledVerde, LOW);
        break;
      case IZQUIERDA:
        analogWrite(buzzer, valorBuzzer);
        delay(2000);
        analogWrite(buzzer, 0);
        break;
      case DERECHA: 
        analogWrite(buzzer, valorBuzzer);
        delay(2000);
        analogWrite(buzzer, 0);
        break;
      case OK:
        Serial.println("Tocando marcha");
        tocarMarcha();
        break;
  }
}

void beep(int note, int duration)
{
  //Play tone on buzzerPin

  // La función tone y noTone tiene conflictos con la librería del recividor.
  // tone(buzzer, note, duration);
  moverServo();
  delay(duration);
  //Stop tone on buzzerPin
  // noTone(buzzer);
  delay(50);
}

void firstSection()
{
  beep(a, 500);
  beep(a, 500);    
  beep(a, 500);
  beep(f, 350);
  beep(cH, 150);  
  beep(a, 500);
  beep(f, 350);
  beep(cH, 150);
  beep(a, 650);
 
  delay(500);
 
  beep(eH, 500);
  beep(eH, 500);
  beep(eH, 500);  
  beep(fH, 350);
  beep(cH, 150);
  beep(gS, 500);
  beep(f, 350);
  beep(cH, 150);
  beep(a, 650);
 
  delay(500);
}
 
void secondSection()
{
  beep(aH, 500);
  beep(a, 300);
  beep(a, 150);
  beep(aH, 500);
  beep(gSH, 325);
  beep(gH, 175);
  beep(fSH, 125);
  beep(fH, 125);    
  beep(fSH, 250);
 
  delay(325);
 
  beep(aS, 250);
  beep(dSH, 500);
  beep(dH, 325);  
  beep(cSH, 175);  
  beep(cH, 125);  
  beep(b, 125);  
  beep(cH, 250);  
 
  delay(350);
}

void tocarMarcha() {
  //Play first section
  firstSection();
 
  //Play second section
  secondSection();
 
  //Variant 1
  beep(f, 250);  
  beep(gS, 500);  
  beep(f, 350);  
  beep(a, 125);
  beep(cH, 500);
  beep(a, 375);  
  beep(cH, 125);
  beep(eH, 650);
 
  delay(500);
 
  //Repeat second section
  secondSection();
 
  //Variant 2
  beep(f, 250);  
  beep(gS, 500);  
  beep(f, 375);  
  beep(cH, 125);
  beep(a, 500);  
  beep(f, 375);  
  beep(cH, 125);
  beep(a, 650);  
 
  delay(650);  
}

void moverServo() {
  if ((angulo > 180) || (angulo < 0)) {
    movimiento = -movimiento;
  }
  
  angulo += movimiento;
  servo.write(angulo); 
}
