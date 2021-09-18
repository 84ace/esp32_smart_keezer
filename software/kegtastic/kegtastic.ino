// Import required libraries
#ifdef ESP32
#include <WiFi.h>
#include <ESPAsyncWebServer.h>
#include <SPIFFS.h>
#else
#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <Hash.h>
#include <ESPAsyncTCP.h>
#include <ESPAsyncWebServer.h>
#include <FS.h>
#endif
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BME280.h>

// Replace with your network credentials
const char *ssid = "ShelveNET";
const char *password = "buttpiratry";

const char *PARAM_INPUT_0 = "numberofbeers";
const char *PARAM_INPUT_1 = "beer1name";
const char *PARAM_INPUT_2 = "beer2name";
const char *PARAM_INPUT_3 = "beer3name";
const char *PARAM_INPUT_4 = "beer4name";
const char *PARAM_INPUT_5 = "beer5name";
const char *PARAM_INPUT_6 = "beer6name";
const char *PARAM_INPUT_7 = "beer7name";
const char *PARAM_INPUT_8 = "beer8name";
const char *PARAM_INPUT_9 = "beer9name";
const char *PARAM_INPUT_10 = "beer10name";

float t = 15.00;
float h = 90.00;
float p = 24.00;

// Create AsyncWebServer object on port 80
AsyncWebServer server(80);

void notFound(AsyncWebServerRequest *request)
{
  request->send(404, "text/plain", "Not found");
}

void setup()
{
  // Serial port for debugging purposes
  Serial.begin(115200);

  bool status;

  // Initialize SPIFFS
  if (!SPIFFS.begin())
  {
    Serial.println("An Error has occurred while mounting SPIFFS");
    return;
  }

  // Connect to Wi-Fi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(1000);
    Serial.println("Connecting to WiFi..");
  }

  // Print ESP32 Local IP Address
  Serial.println(WiFi.localIP());

  // Route for root / web page
  server.on("/", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send(SPIFFS, "/index.html"); });
  server.on("/stats", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send_P(200, "text/plain", "11.0"); });
  
  // Beer naming form
  server.on("/settings", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send(SPIFFS, "/settings.html"); });

  // Send a GET request to <ESP_IP>/get?beerxname=<inputMessage>
  server.on("/get", HTTP_GET, [](AsyncWebServerRequest *request)
            {
              String inputMessage;
              String inputParam;
              // GET input1 value on <ESP_IP>/get?input1=<inputMessage>
              if (request->hasParam(PARAM_INPUT_0))
              {
                inputMessage = request->getParam(PARAM_INPUT_0)->value();
                inputParam = PARAM_INPUT_0;
              }
              else if (request->hasParam(PARAM_INPUT_1))
              {
                inputMessage = request->getParam(PARAM_INPUT_1)->value();
                inputParam = PARAM_INPUT_1;
              }
              else if (request->hasParam(PARAM_INPUT_2))
              {
                inputMessage = request->getParam(PARAM_INPUT_2)->value();
                inputParam = PARAM_INPUT_2;
              }
              else if (request->hasParam(PARAM_INPUT_3))
              {
                inputMessage = request->getParam(PARAM_INPUT_3)->value();
                inputParam = PARAM_INPUT_3;
              }
              else if (request->hasParam(PARAM_INPUT_4))
              {
                inputMessage = request->getParam(PARAM_INPUT_4)->value();
                inputParam = PARAM_INPUT_4;
              }
              else if (request->hasParam(PARAM_INPUT_5))
              {
                inputMessage = request->getParam(PARAM_INPUT_5)->value();
                inputParam = PARAM_INPUT_5;
              }
              else if (request->hasParam(PARAM_INPUT_6))
              {
                inputMessage = request->getParam(PARAM_INPUT_6)->value();
                inputParam = PARAM_INPUT_6;
              }
              else if (request->hasParam(PARAM_INPUT_7))
              {
                inputMessage = request->getParam(PARAM_INPUT_7)->value();
                inputParam = PARAM_INPUT_7;
              }
              else if (request->hasParam(PARAM_INPUT_8))
              {
                inputMessage = request->getParam(PARAM_INPUT_8)->value();
                inputParam = PARAM_INPUT_8;
              }
              else if (request->hasParam(PARAM_INPUT_9))
              {
                inputMessage = request->getParam(PARAM_INPUT_9)->value();
                inputParam = PARAM_INPUT_9;
              }
              else if (request->hasParam(PARAM_INPUT_10))
              {
                inputMessage = request->getParam(PARAM_INPUT_10)->value();
                inputParam = PARAM_INPUT_10;
              }
              else
              {
                inputMessage = "No message sent";
                inputParam = "none";
              }
              Serial.println(inputMessage);
              request->send(200, "text/html", "HTTP GET request sent to your ESP on input field (" + inputParam + ") with value: " + inputMessage + "<br><a href=\"/\">Return to Home Page</a>");
            });
  server.onNotFound(notFound);

  // Start server
  server.begin();
}

void loop()
{
}
