#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <DHT.h>

#define DHTPIN 0
#define DHTTYPE DHT11

const char* ssid         = "PuertoViejo";
const char* password     = "g4tPghJr0y";
const char* mqttServer   = "postman.cloudmqtt.com";
const int   mqttPort     = 14675;
const char* mqttUser     = "ArduinoOne";
const char* mqttPassword = "RicardoDarin";

WiFiClient espClient;
PubSubClient client(espClient);
DHT dht(DHTPIN, DHTTYPE);
float temperatura;
char* temperaturaStr;

void setup() {
  Serial.begin(9600);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.println("Connecting to WiFi..");
  }

  Serial.println("Connected to the WiFi network");

  client.setServer(mqttServer, mqttPort);
  client.setCallback(callback);

  while (!client.connected()) {
    Serial.println("Connecting to MQTT...");

    if (client.connect("ESP8266Client", mqttUser, mqttPassword )) {

      Serial.println("connected");

    } else {

      Serial.print("failed with state ");
      Serial.print(client.state());
      delay(2000);
    }
  }
  
  client.subscribe("/casa/+/temperatura");
  client.subscribe("/casa/+/luz");
  dht.begin();
}

void loop() {
  client.loop();

  temperatura = dht.readTemperature();

  if (isnan(temperatura)) {
    Serial.println("Error leyendo la temperatura!");
  }

  Serial.println(temperatura);

  client.publish("casa/cocina/temperatura", "temperatura enviada");
  delay(1000);
}

void callback(String topic, byte* payload, unsigned int length) {
  String mensajeRecibido = "";

  for (int p = 0; p < length; p++) {
    mensajeRecibido += (char)payload[p];
  }
  mensajeRecibido.toUpperCase();

  if (mensajeRecibido == "ENCENDER")            {
    encenderLuz(topic);
  }
  else if (mensajeRecibido == "ENCENDER LUCES") {
    encenderLuces();
  }
  else if (mensajeRecibido == "APAGAR")         {
    apagarLuz(topic);
  }
  else if (mensajeRecibido == "APAGAR LUCES")   {
    apagarLuces();
  }

  Serial.println("Publicando...");
}


void encenderLuz(String topic) {
  if (topic == "/casa/cocina/luz")            {
    (client.publish("/casa/cocina/luz", "Se encendió la luz de la cocina"));
  }
  else if (topic == "/casa/habitacion_1/luz") {
    (client.publish("/casa/habitacion_1/luz", "Se encendió la luz de la habitacion 1"));
  }
  else if (topic == "/casa/habitacion_2/luz") {
    (client.publish("/casa/habitacion_2/luz", "Se encendió la luz de la habitacion 2"));
  }
  else if (topic == "/casa/comedor/luz")      {
    (client.publish("/casa/comedor/luz", "Se encendió la luz del comedor"));
  }
  else if (topic == "/casa/banio/luz")        {
    (client.publish("/casa/banio/luz", "Se encendió la luz del baño"));
  }
}

void encenderLuces() {
  client.publish("/casa/cocina/luz", "Se encendió la luz de la cocina");
  client.publish("/casa/habitacion_1/luz", "Se encendió la luz de la habitacion 1");
  client.publish("/casa/habitacion_2/luz", "Se encendió la luz de la habitacion 2");
  client.publish("/casa/comedor/luz", "Se encendió la luz del comedor");
  client.publish("/casa/banio/luz", "Se encendió la luz del baño");
}

void apagarLuz(String topic) {
  if (topic == "/casa/cocina/luz")            {
    (client.publish("/casa/cocina/luz", "Se apagó la luz de la cocina"));
  }
  else if (topic == "/casa/habitacion_1/luz") {
    (client.publish("/casa/habitacion_1/luz", "Se apagó la luz de la habitacion 1"));
  }
  else if (topic == "/casa/habitacion_2/luz") {
    (client.publish("/casa/habitacion_2/luz", "Se apagó la luz de la habitacion 2"));
  }
  else if (topic == "/casa/comedor/luz")      {
    (client.publish("/casa/comedor/luz", "Se apagó la luz del comedor"));
  }
  else if (topic == "/casa/banio/luz")        {
    (client.publish("/casa/banio/luz", "Se apagó la luz del baño"));
  }
}

void apagarLuces() {
  client.publish("/casa/cocina/luz", "Se apagó la luz de la cocina");
  client.publish("/casa/habitacion_1/luz", "Se apagó la luz de la habitacion 1");
  client.publish("/casa/habitacion_2/luz", "Se apagó la luz de la habitacion 2");
  client.publish("/casa/comedor/luz", "Se apagó la luz del comedor");
  client.publish("/casa/banio/luz", "Se apagó la luz del baño");
}
