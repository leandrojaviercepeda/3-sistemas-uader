#include <DHT.h>

#define DHTPIN 10
#define DHTTYPE DHT11   // DHT 11

DHT dht(DHTPIN, DHTTYPE);

void setup() {
  Serial.begin(9600);
  dht.begin();
}

void loop() {
  
  // Sensor readings may also be up to 2 seconds 'old' (its a very slow sensor)
  float h = dht.readHumidity();
  // Read temperature as Celsius (the default)
  float t = dht.readTemperature();

  // Check if any reads failed and exit early (to try again).
  if (isnan(h) || isnan(t)) {
    Serial.println("Failed to read from DHT sensor!");
    return;
  }

  if (h < 30) {
    Serial.println("Humedad baja: ");
  } else if (h < 60) {
    Serial.println("Humedad media: ");
  } else {
    Serial.println("Humedad alta: ");
  }
  
  Serial.print(h);
  Serial.println(" %");

  
  if (t < 15) {
    Serial.println("Temperatura baja: ");
  } else if (t < 30) {
    Serial.println("Temperatura media: ");
  } else {
    Serial.println("Temperatura alta: ");
  }
  Serial.print(t);
  Serial.println(" °C");
  delay(2000);
}
