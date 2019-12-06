#define trigPin  12
#define echoPin  10
#include <Wire.h>
#include "RTClib.h"
// #include "rgb_lcd.h"

RTC_DS3231 rtc;
// rgb_lcd lcd;

String fecha;
String distancia;
String cercania;
String loggeo;
String daysOfTheWeek[7] = { "Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado" };
String monthsNames[12] = { "Enero", "Febrero", "Marzo", "Abril", "Mayo",  "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" };

long duration, cm, inches;
// const int colorR = 255;
// const int colorG = 0;
// const int colorB = 0;

void setup() {
  Serial.begin (9600);
  delay(1000);
  if (!rtc.begin()) {
    Serial.println(F("Couldn't find RTC"));
    while (1);
  }

  // Si se ha perdido la corriente, fijar fecha y hora
  if (rtc.lostPower()) {
    // Fijar a fecha y hora de compilacion
    rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));

    // Fijar a fecha y hora específica
    rtc.adjust(DateTime(2019, 10, 10, 18, 50, 0));
  }
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  // lcd.begin(16, 2);
  // lcd.setRGB(colorR, colorG, colorB);
}


void loop() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(5);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  duration = pulseIn(echoPin, HIGH);
  
  // Calculating the distance
  float distanciaFloat = duration * 0.034 / 2;

  cercania = "(Nada cerca)";
  
  if (distanciaFloat < 5)
    cercania = "(Muy cerca)";
  else if (distanciaFloat < 10)
    cercania = "(Cerca)";
  else if (distanciaFloat < 25)
    cercania = "(Próximo)";
  

  distancia = String(distanciaFloat) + "cm ";
  // lcd.print(cm);
  // lcd.setCursor(0, 0);

  delay(1000);
  // lcd.clear();

  // Obtener fecha actual y mostrar por Serial
  DateTime now = rtc.now();
  fecha = getDate(now);
  loggeo = fecha + distancia + cercania;
  Serial.println(loggeo);
}


String getDate(DateTime date)
{
  String fecha = String(date.year()) + "/" + String(date.month()) + "/" + String(date.day()) + " - " + String(date.hour()) + ":" + String(date.minute()) + ":" + String(date.second()) + " ";
  return fecha;
}
