#include <ESP8266WiFi.h>
#include <PubSubClient.h>


const char* ssid = "PuertoViejo";
const char* password =  "g4tPghJr0y";

const char* mqttServer = "postman.cloudmqtt.com";
const int mqttPort = 16525;
const char* mqttUser = "bjirkdcw";
const char* mqttPassword = "5o-xAF1XrS7S";

WiFiClient espClient;
PubSubClient client(espClient);


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
  
  // Nos suscribimos al tópico chat_arduino
  client.subscribe("/chat_arduino");
}

void loop() {
  client.loop();
}

void callback(char* topic, byte* payload, unsigned int length) {
  String mensaje = "";
 
  Serial.println("Llegó un mensaje en el topic " + String(topic) + ".");
  
  for (int i = 0; i < length; i++) { mensaje += (char)payload[i]; } // Construimos el mensaje caracter por caracter

  Serial.print("Mensaje: " + mensaje);
}
