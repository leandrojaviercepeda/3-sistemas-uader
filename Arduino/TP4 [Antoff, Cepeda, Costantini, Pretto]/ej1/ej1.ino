#define botonPrender 2
#define botonApagar 3
#define led1 9
#define led2 10
#define led3 11
#define led4 12
#define led5 13

int ledActual = 9;

void setup()
{
  Serial.begin(9600);
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(led3, OUTPUT);
  pinMode(botonPrender, INPUT_PULLUP);
  pinMode(botonApagar, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(botonPrender), prenderLed, FALLING);
  attachInterrupt(digitalPinToInterrupt(botonApagar), apagarLed, FALLING);
}

void loop()
{
  
}

void prenderLed() {
    Serial.println(ledActual);
    digitalWrite(ledActual, HIGH);

    if (ledActual < 13)
      ledActual++;
}

void apagarLed() {
    Serial.println(ledActual);
    digitalWrite(ledActual, LOW);

    if (ledActual > 9)
      ledActual--;
}
