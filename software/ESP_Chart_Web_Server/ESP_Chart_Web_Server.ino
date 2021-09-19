// Import required libraries

#include <WiFi.h>
#include <ESPAsyncWebServer.h>
#include <SPIFFS.h>
#include <AsyncElegantOTA.h>
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BME280.h>
#include <Preferences.h>

#define REV1 // PCB REV 1

#ifdef REV1
#define LED_BUILTIN 18
#define SENSOR1 4   // beer1
#define SENSOR2 13  // beer2
#define SENSOR3 14  // beer3
#define SENSOR4 15  // beer4
#define SENSOR5 25  // beer5
#define SENSOR6 16  // beer6 26
#define SENSOR7 17  // beer7 27
#define SENSOR8 27  // beer8 32
#define SENSOR9 32  // beer9 16
#define SENSOR10 26 // beer10 17
#endif

// ToDo: use STA_AP mode to allow initial setup over WiFi - done 18/09/21
// ToDo: create OTA for .bin firmware updates - done 18/09/21
// ToDo: create OTA for SPIFFS partition updates - done 18/09/21
// ToDo: create beer volume set from in settings - done 18/09/21
// ToDo: add a flow calibration/modifier in settings
// ToDo: save beer names to flash so they are persitent - done 19/09/21
// ToDo: save beer volumes to flash so they are persitent - done 19/09/21
// ToDo: validate beer volumes and name input field data < this probably won't happen ;)
// ToDo: configure overview chart to dynamically update
// ToDo: configure charts to dynamically update beer names and volumes
// ToDo: implement a mode press button to wipe WiFi creds and trigger WiFi AP for setup
// ToDo: test/build CSS HTML layouts for different sized screens/mobile < this probably won't happen ;)

// Replace with your network credentials
Preferences preferences;

String pwifiSSID;
String pwifiPassword;

const char *wifiSSID = "ShelveNET";
const char *wifiPassword = "buttpiratry";

void (*resetFunc)(void) = 0; // declare reset fuction at address 0

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
const char *PARAM_INPUT_11 = "beer1Volume";
const char *PARAM_INPUT_12 = "beer2Volume";
const char *PARAM_INPUT_13 = "beer3Volume";
const char *PARAM_INPUT_14 = "beer4Volume";
const char *PARAM_INPUT_15 = "beer5Volume";
const char *PARAM_INPUT_16 = "beer6Volume";
const char *PARAM_INPUT_17 = "beer7Volume";
const char *PARAM_INPUT_18 = "beer8Volume";
const char *PARAM_INPUT_19 = "beer9Volume";
const char *PARAM_INPUT_20 = "beer10Volume";
const char *PARAM_INPUT_21 = "wifiSSID";
const char *PARAM_INPUT_22 = "wifiPassword";
const char *PARAM_INPUT_23 = "reset";

String beer1Name = "beer1Name";
String beer2Name = "beer2Name";
String beer3Name = "beer3Name";
String beer4Name = "beer4Name";
String beer5Name = "beer5Name";
String beer6Name = "beer6Name";
String beer7Name = "beer7Name";
String beer8Name = "beer8Name";
String beer9Name = "beer9Name";
String beer10Name = "beer10Name";

int numberOfBeers;
int beer1Volume;
int beer2Volume;
int beer3Volume;
int beer4Volume;
int beer5Volume;
int beer6Volume;
int beer7Volume;
int beer8Volume;
int beer9Volume;
int beer10Volume;

bool status;
char promBytes[32];

int pulse1 = 0;
long currentMillis1 = 0;
long previousMillis1 = 0;
int flowMilliLitres1;
int totalMilliLitres1;
byte pulseSec1 = 0;
volatile byte pulseCount1;
int beer1Litres = 0;
char beer1LitresChar[6] = "";
float flowRate1;

void IRAM_ATTR pulseCount1er()
{
  pulseCount1++;
}

int pulse2 = 0;
long currentMillis2 = 0;
long previousMillis2 = 0;
int flowMilliLitres2;
int totalMilliLitres2;
byte pulseSec2 = 0;
volatile byte pulseCount2;
int beer2Litres = 0;
char beer2LitresChar[6] = "";
float flowRate2;

void IRAM_ATTR pulseCount2er()
{
  pulseCount2++;
}

int pulse3 = 0;
long currentMillis3 = 0;
long previousMillis3 = 0;
int flowMilliLitres3;
int totalMilliLitres3;
byte pulseSec3 = 0;
volatile byte pulseCount3;
int beer3Litres = 0;
char beer3LitresChar[6] = "";
float flowRate3;

void IRAM_ATTR pulseCount3er()
{
  pulseCount3++;
}

int pulse4 = 0;
long currentMillis4 = 0;
long previousMillis4 = 0;
int flowMilliLitres4;
int totalMilliLitres4;
byte pulseSec4 = 0;
volatile byte pulseCount4;
int beer4Litres = 0;
char beer4LitresChar[6] = "";
float flowRate4;

void IRAM_ATTR pulseCount4er()
{
  pulseCount4++;
}

int pulse5 = 0;
long currentMillis5 = 0;
long previousMillis5 = 0;
int flowMilliLitres5;
int totalMilliLitres5;
byte pulseSec5 = 0;
volatile byte pulseCount5;
int beer5Litres = 0;
char beer5LitresChar[6] = "";
float flowRate5;

void IRAM_ATTR pulseCount5er()
{
  pulseCount5++;
}

int pulse6 = 0;
long currentMillis6 = 0;
long previousMillis6 = 0;
int flowMilliLitres6;
int totalMilliLitres6;
byte pulseSec6 = 0;
volatile byte pulseCount6;
int beer6Litres = 0;
char beer6LitresChar[6] = "";
float flowRate6;

void IRAM_ATTR pulseCount6er()
{
  pulseCount6++;
}

int pulse7 = 0;
long currentMillis7 = 0;
long previousMillis7 = 0;
int flowMilliLitres7;
int totalMilliLitres7;
byte pulseSec7 = 0;
volatile byte pulseCount7;
int beer7Litres = 0;
char beer7LitresChar[6] = "";
float flowRate7;

void IRAM_ATTR pulseCount7er()
{
  pulseCount7++;
}

int pulse8 = 0;
long currentMillis8 = 0;
long previousMillis8 = 0;
int flowMilliLitres8;
int totalMilliLitres8;
byte pulseSec8 = 0;
volatile byte pulseCount8;
int beer8Litres = 0;
char beer8LitresChar[6] = "";
float flowRate8;

void IRAM_ATTR pulseCount8er()
{
  pulseCount8++;
}

int pulse9 = 0;
long currentMillis9 = 0;
long previousMillis9 = 0;
int flowMilliLitres9;
int totalMilliLitres9;
byte pulseSec9 = 0;
volatile byte pulseCount9;
int beer9Litres = 0;
char beer9LitresChar[6] = "";
float flowRate9;

void IRAM_ATTR pulseCount9er()
{
  pulseCount9++;
}

int pulse10 = 0;
long currentMillis10 = 0;
long previousMillis10 = 0;
int flowMilliLitres10;
int totalMilliLitres10;
byte pulseSec10 = 0;
volatile byte pulseCount10;
int beer10Litres = 0;
char beer10LitresChar[6] = "";
float flowRate10;

void IRAM_ATTR pulseCount10er()
{
  pulseCount10++;
}

int interval = 1000;
int ledLoop = 1;
float calibrationFactor = 98;

boolean ledState = LOW;

char stats[] = "[20, 18, 16, 14, 12, 10, 8, 6, 4, 0]";

// Create AsyncWebServer object on port 80
AsyncWebServer server(80);
AsyncWebSocket ws("/ws");

void notifyClients()
{
  ws.textAll(String(ledState));
}

void handleWebSocketMessage(void *arg, uint8_t *data, size_t len)
{
  AwsFrameInfo *info = (AwsFrameInfo *)arg;
  if (info->final && info->index == 0 && info->len == len && info->opcode == WS_TEXT)
  {
    data[len] = 0;
    if (strcmp((char *)data, "toggle") == 0)
    {
      ledState = !ledState;
      notifyClients();
    }
  }
}

void onEvent(AsyncWebSocket *server, AsyncWebSocketClient *client, AwsEventType type,
             void *arg, uint8_t *data, size_t len)
{
  switch (type)
  {
  case WS_EVT_CONNECT:
    Serial.printf("WebSocket client #%u connected from %s\n", client->id(), client->remoteIP().toString().c_str());
    break;
  case WS_EVT_DISCONNECT:
    Serial.printf("WebSocket client #%u disconnected\n", client->id());
    break;
  case WS_EVT_DATA:
    handleWebSocketMessage(arg, data, len);
    break;
  case WS_EVT_PONG:
  case WS_EVT_ERROR:
    break;
  }
}

void initWebSocket()
{
  ws.onEvent(onEvent);
  server.addHandler(&ws);
}

void notFound(AsyncWebServerRequest *request)
{
  request->send(404, "text/plain", "Not found");
}

void setupFlowData()
{
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(SENSOR1, INPUT_PULLUP);
  pinMode(SENSOR2, INPUT_PULLUP);
  pinMode(SENSOR3, INPUT_PULLUP);
  pinMode(SENSOR4, INPUT_PULLUP);
  pinMode(SENSOR5, INPUT_PULLUP);
  pinMode(SENSOR6, INPUT_PULLUP);
  pinMode(SENSOR7, INPUT_PULLUP);
  pinMode(SENSOR8, INPUT_PULLUP);
  pinMode(SENSOR9, INPUT_PULLUP);
  pinMode(SENSOR10, INPUT_PULLUP);

  pulseCount1 = 0;
  flowRate1 = 0.0;
  flowMilliLitres1 = 0;
  totalMilliLitres1 = 0;
  previousMillis1 = 0;

  pulseCount2 = 0;
  flowRate2 = 0.0;
  flowMilliLitres2 = 0;
  totalMilliLitres2 = 0;
  previousMillis2 = 0;

  pulseCount3 = 0;
  flowRate3 = 0.0;
  flowMilliLitres3 = 0;
  totalMilliLitres3 = 0;
  previousMillis3 = 0;

  pulseCount4 = 0;
  flowRate4 = 0.0;
  flowMilliLitres4 = 0;
  totalMilliLitres4 = 0;
  previousMillis4 = 0;

  pulseCount5 = 0;
  flowRate5 = 0.0;
  flowMilliLitres5 = 0;
  totalMilliLitres5 = 0;
  previousMillis5 = 0;

  pulseCount6 = 0;
  flowRate6 = 0.0;
  flowMilliLitres6 = 0;
  totalMilliLitres6 = 0;
  previousMillis6 = 0;

  pulseCount7 = 0;
  flowRate7 = 0.0;
  flowMilliLitres7 = 0;
  totalMilliLitres7 = 0;
  previousMillis7 = 0;

  pulseCount8 = 0;
  flowRate8 = 0.0;
  flowMilliLitres8 = 0;
  totalMilliLitres8 = 0;
  previousMillis8 = 0;

  pulseCount9 = 0;
  flowRate9 = 0.0;
  flowMilliLitres9 = 0;
  totalMilliLitres9 = 0;
  previousMillis9 = 0;

  pulseCount10 = 0;
  flowRate10 = 0.0;
  flowMilliLitres10 = 0;
  totalMilliLitres10 = 0;
  previousMillis10 = 0;

  attachInterrupt(digitalPinToInterrupt(SENSOR1), pulseCount1er, FALLING);
  attachInterrupt(digitalPinToInterrupt(SENSOR2), pulseCount2er, FALLING);
  attachInterrupt(digitalPinToInterrupt(SENSOR3), pulseCount3er, FALLING);
  attachInterrupt(digitalPinToInterrupt(SENSOR4), pulseCount4er, FALLING);
  attachInterrupt(digitalPinToInterrupt(SENSOR5), pulseCount5er, FALLING);
  attachInterrupt(digitalPinToInterrupt(SENSOR6), pulseCount6er, FALLING);
  attachInterrupt(digitalPinToInterrupt(SENSOR7), pulseCount7er, FALLING);
  attachInterrupt(digitalPinToInterrupt(SENSOR8), pulseCount8er, FALLING);
  attachInterrupt(digitalPinToInterrupt(SENSOR9), pulseCount9er, FALLING);
  attachInterrupt(digitalPinToInterrupt(SENSOR10), pulseCount10er, FALLING);
}

void setupServer()
{

  // Route to load style.css file
  server.on("/style.css", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send(SPIFFS, "/style.css", "text/css"); });

  // Route to load style.css file
  server.on("/css.css", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send(SPIFFS, "/css.css", "text/css"); });

  // Route for root / web page
  server.on("/", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send(SPIFFS, "/index.html"); });
  server.on("/stats", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send_P(200, "text/plain", stats); });
  server.on("/beer1", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send_P(200, "text/plain", beer1LitresChar); });
  server.on("/beer2", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send_P(200, "text/plain", beer2LitresChar); });
  server.on("/beer3", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send_P(200, "text/plain", beer3LitresChar); });
  server.on("/beer4", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send_P(200, "text/plain", beer4LitresChar); });
  server.on("/beer5", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send_P(200, "text/plain", beer5LitresChar); });
  server.on("/beer6", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send_P(200, "text/plain", beer6LitresChar); });
  server.on("/beer7", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send_P(200, "text/plain", beer7LitresChar); });
  server.on("/beer8", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send_P(200, "text/plain", beer8LitresChar); });
  server.on("/beer9", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send_P(200, "text/plain", beer9LitresChar); });
  server.on("/beer10", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send_P(200, "text/plain", beer10LitresChar); });

  // Beer naming form
  server.on("/settings", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send(SPIFFS, "/settings.html"); });

  // Beer consumption over time
  server.on("/consumption", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send(SPIFFS, "/consumption.html"); });

  // Send a GET request to <ESP_IP>/get?beerxname=<inputMessage>
  server.on("/get", HTTP_GET, [](AsyncWebServerRequest *request)
            {
              String inputMessage;
              String inputParam;
              // GET input1 value on <ESP_IP>/get?PARAM_INPUT_0=<formInput>
              if (request->hasParam(PARAM_INPUT_0)) // number of beers to display
              {
                inputMessage = request->getParam(PARAM_INPUT_0)->value();
                inputParam = PARAM_INPUT_0;
                preferences.begin("numberOfBeers", false); // tell preferences there is data coming
                preferences.putInt("beersNumber", inputMessage.toInt());
                numberOfBeers = inputMessage.toInt();
                Serial.println("Number of beers to display saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_1)) // beer 2 name
              {
                inputMessage = request->getParam(PARAM_INPUT_1)->value();
                inputParam = PARAM_INPUT_1;
                preferences.begin("beerNames", false); // tell preferences there is data coming
                preferences.putString("beer1Name", inputMessage);
                beer1Name = inputMessage;
                Serial.println("Beer 1 name saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_2)) // beer 2 name
              {
                inputMessage = request->getParam(PARAM_INPUT_2)->value();
                inputParam = PARAM_INPUT_2;
                preferences.begin("beerNames", false); // tell preferences there is data coming
                preferences.putString("beer2Name", inputMessage);
                beer2Name = inputMessage;
                Serial.println("Beer 2 name saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_3)) // beer 3 name
              {
                inputMessage = request->getParam(PARAM_INPUT_3)->value();
                inputParam = PARAM_INPUT_3;
                preferences.begin("beerNames", false); // tell preferences there is data coming
                preferences.putString("beer3Name", inputMessage);
                beer3Name = inputMessage;
                Serial.println("Beer 3 name saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_4)) // beer 4 name
              {
                inputMessage = request->getParam(PARAM_INPUT_4)->value();
                inputParam = PARAM_INPUT_4;
                preferences.begin("beerNames", false); // tell preferences there is data coming
                preferences.putString("beer4Name", inputMessage);
                beer4Name = inputMessage;
                Serial.println("Beer 4 name saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_5)) // beer 5 name
              {
                inputMessage = request->getParam(PARAM_INPUT_5)->value();
                inputParam = PARAM_INPUT_5;
                preferences.begin("beerNames", false); // tell preferences there is data coming
                preferences.putString("beer5Name", inputMessage);
                beer5Name = inputMessage;
                Serial.println("Beer 5 name saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_6)) // beer 6 name
              {
                inputMessage = request->getParam(PARAM_INPUT_6)->value();
                inputParam = PARAM_INPUT_6;
                preferences.begin("beerNames", false); // tell preferences there is data coming
                preferences.putString("beer6Name", inputMessage);
                beer6Name = inputMessage;
                Serial.println("Beer 6 name saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_7))
              {
                inputMessage = request->getParam(PARAM_INPUT_7)->value();
                inputParam = PARAM_INPUT_7;
                preferences.begin("beerNames", false); // tell preferences there is data coming
                preferences.putString("beer7Name", inputMessage);
                beer7Name = inputMessage;
                Serial.println("Beer 7 name saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_8)) // beer 8 name
              {
                inputMessage = request->getParam(PARAM_INPUT_8)->value();
                inputParam = PARAM_INPUT_8;
                preferences.begin("beerNames", false); // tell preferences there is data coming
                preferences.putString("beer8Name", inputMessage);
                beer8Name = inputMessage;
                Serial.println("Beer 8 name saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_9)) // beer 9 name
              {
                inputMessage = request->getParam(PARAM_INPUT_9)->value();
                inputParam = PARAM_INPUT_9;
                preferences.begin("beerNames", false); // tell preferences there is data coming
                preferences.putString("beer9Name", inputMessage);
                beer9Name = inputMessage;
                Serial.println("Beer 9 name saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_10)) // beer 10 name
              {
                inputMessage = request->getParam(PARAM_INPUT_10)->value();
                inputParam = PARAM_INPUT_10;
                preferences.begin("beerNames", false); // tell preferences there is data coming
                preferences.putString("beer10Name", inputMessage);
                beer10Name = inputMessage;
                Serial.println("Beer 10 name saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_11)) // beer 1 volume
              {
                inputMessage = request->getParam(PARAM_INPUT_11)->value();
                inputParam = PARAM_INPUT_11;
                preferences.begin("beerVolumes", false); // tell preferences there is data coming
                preferences.putInt("beer1Volume", inputMessage.toInt() * 1000);
                beer1Volume = inputMessage.toInt() * 1000;
                Serial.println("Beer 1 volume saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_12)) // beer 2 volume
              {
                inputMessage = request->getParam(PARAM_INPUT_12)->value();
                inputParam = PARAM_INPUT_10;
                preferences.begin("beerVolumes", false); // tell preferences there is data coming
                preferences.putInt("beer2Volume", inputMessage.toInt() * 1000);
                beer2Volume = inputMessage.toInt() * 1000;
                Serial.println("Beer 2 volume saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_13)) // beer 3 volume
              {
                inputMessage = request->getParam(PARAM_INPUT_13)->value();
                inputParam = PARAM_INPUT_13;
                preferences.begin("beerVolumes", false); // tell preferences there is data coming
                preferences.putInt("beer3Volume", inputMessage.toInt() * 1000);
                beer3Volume = inputMessage.toInt() * 1000;
                Serial.println("Beer 3 volume saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_14)) // beer 4 volume
              {
                inputMessage = request->getParam(PARAM_INPUT_14)->value();
                inputParam = PARAM_INPUT_14;
                preferences.begin("beerVolumes", false); // tell preferences there is data coming
                preferences.putInt("beer4Volume", inputMessage.toInt() * 1000);
                beer4Volume = inputMessage.toInt() * 1000;
                Serial.println("Beer 4 volume saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_15)) // beer 5 volume
              {
                inputMessage = request->getParam(PARAM_INPUT_15)->value();
                inputParam = PARAM_INPUT_15;
                preferences.begin("beerVolumes", false); // tell preferences there is data coming
                preferences.putInt("beer5Volume", inputMessage.toInt() * 1000);
                beer5Volume = inputMessage.toInt() * 1000;
                Serial.println("Beer 5 volume saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_16)) // beer 6 volume
              {
                inputMessage = request->getParam(PARAM_INPUT_16)->value();
                inputParam = PARAM_INPUT_16;
                preferences.begin("beerVolumes", false); // tell preferences there is data coming
                preferences.putInt("beer6Volume", inputMessage.toInt() * 1000);
                beer6Volume = inputMessage.toInt() * 1000;
                Serial.println("Beer 6 volume saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_17)) // beer 7 volume
              {
                inputMessage = request->getParam(PARAM_INPUT_17)->value();
                inputParam = PARAM_INPUT_17;
                preferences.begin("beerVolumes", false); // tell preferences there is data coming
                preferences.putInt("beer7Volume", inputMessage.toInt() * 1000);
                beer7Volume = inputMessage.toInt() * 1000;
                Serial.println("Beer 7 volume saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_18)) // beer 8 volume
              {
                inputMessage = request->getParam(PARAM_INPUT_18)->value();
                inputParam = PARAM_INPUT_18;
                preferences.begin("beerVolumes", false); // tell preferences there is data coming
                preferences.putInt("beer8Volume", inputMessage.toInt() * 1000);
                beer8Volume = inputMessage.toInt() * 1000;
                Serial.println("Beer 8 volume saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_19)) // beer 9 volume
              {
                inputMessage = request->getParam(PARAM_INPUT_19)->value();
                inputParam = PARAM_INPUT_19;
                preferences.begin("beerVolumes", false); // tell preferences there is data coming
                preferences.putInt("beer9Volume", inputMessage.toInt() * 1000);
                beer9Volume = inputMessage.toInt() * 1000;
                Serial.println("Beer 9 volume saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_20)) // beer 10 volume
              {
                inputMessage = request->getParam(PARAM_INPUT_20)->value();
                inputParam = PARAM_INPUT_20;
                preferences.begin("beerVolumes", false); // tell preferences there is data coming
                preferences.putInt("beer10Volume", inputMessage.toInt() * 1000);
                beer10Volume = inputMessage.toInt() * 1000;
                Serial.println("Beer 10 volume saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_21)) // wifi SSID
              {
                inputMessage = request->getParam(PARAM_INPUT_21)->value();
                inputParam = PARAM_INPUT_21;
                preferences.begin("credentials", false); // tell preferences there is data coming
                preferences.putString("pwifiSSID", inputMessage);
                Serial.println("WiFi SSID saved using Preference");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_22)) // wifi password
              {
                inputMessage = request->getParam(PARAM_INPUT_22)->value();
                inputParam = PARAM_INPUT_22;
                preferences.begin("credentials", false); // tell preferences there is data coming
                preferences.putString("pwifiPassword", inputMessage);
                Serial.println("WiFi pasword saved using Preferences");
                preferences.end(); // stop preferences from accepting data
              }
              else if (request->hasParam(PARAM_INPUT_23)) // reset the board
              {
                inputMessage = request->getParam(PARAM_INPUT_23)->value();
                inputParam = PARAM_INPUT_23;
                resetFunc();
              }
              else
              {
                inputMessage = "No message sent";
                inputParam = "none";
              }
              Serial.print("Web form input: ");
              Serial.println(inputMessage);
              request->send(200, "text/html", "HTTP GET request sent to your ESP on input field (" + inputParam + ") with value: " + inputMessage + "<br><a href=\"/settings\">Return to Settings Page</a>");
            });
  server.onNotFound(notFound);
}

void readFlows()
{
  currentMillis1 = millis();
  if (currentMillis1 - previousMillis1 > interval)
  {
    ledLoop++;
    digitalWrite(LED_BUILTIN, HIGH); // turn the LED on (HIGH is the voltage level)

    pulseSec1 = pulseCount1;
    pulseCount1 = 0;

    // Because this loop may not complete in exactly 1 second intervals we calculate
    // the number of milliseconds that have passed since the last execution and use
    // that to scale the output. We also apply the calibrationFactor to scale the output
    // based on the number of pulses per second per units of measure (litres/minute in
    // this case) coming from the sensor.
    flowRate1 = ((1000.0 / (millis() - previousMillis1)) * pulseSec1) / calibrationFactor;
    previousMillis1 = millis();

    // Divide the flow rate in litres/minute by 60 to determine how many litres have
    // passed through the sensor in this 1 second interval, then multiply by 1000 to
    // convert to millilitres.
    flowMilliLitres1 = (flowRate1 / 60) * 1000;

    // Add the millilitres passed in this second to the cumulative total
    totalMilliLitres1 += flowMilliLitres1;

    // Print the flow rate for this second in litres / minute
    //Serial.print("Flow rate: ");
    //Serial.print(int(flowRate1));  // Print the integer part of the variable
    //Serial.print("L/min");
    //Serial.print("\t");       // Print tab space

    // Print the cumulative total of litres flowed since starting
    //Serial.print("Output Liquid Quantity: ");
    //Serial.print(totalMilliLitres);
    //Serial.print("mL / ");

    beer1Litres = beer1Volume - totalMilliLitres1; // need to divide  by 1000 on the receiving side
    dtostrf(beer1Litres, 6, 2, beer1LitresChar);

    if (flowMilliLitres1 > 0)
    {
      Serial.print("Beer 1 millilitres: ");
      Serial.println(beer1LitresChar);
    }
  }

  currentMillis2 = millis();
  if (currentMillis2 - previousMillis2 > interval)
  {
    pulseSec2 = pulseCount2;
    pulseCount2 = 0;

    // Because this loop may not complete in exactly 1 second intervals we calculate
    // the number of milliseconds that have passed since the last execution and use
    // that to scale the output. We also apply the calibrationFactor to scale the output
    // based on the number of pulses per second per units of measure (litres/minute in
    // this case) coming from the sensor.
    flowRate2 = ((1000.0 / (millis() - previousMillis2)) * pulseSec2) / calibrationFactor;
    previousMillis2 = millis();

    // Divide the flow rate in litres/minute by 60 to determine how many litres have
    // passed through the sensor in this 1 second interval, then multiply by 1000 to
    // convert to millilitres.
    flowMilliLitres2 = (flowRate2 / 60) * 1000;

    // Add the millilitres passed in this second to the cumulative total
    totalMilliLitres2 += flowMilliLitres2;

    // Print the flow rate for this second in litres / minute
    //Serial.print("Flow rate: ");
    //Serial.print(int(flowRate1));  // Print the integer part of the variable
    //Serial.print("L/min");
    //Serial.print("\t");       // Print tab space

    // Print the cumulative total of litres flowed since starting
    //Serial.print("Output Liquid Quantity: ");
    //Serial.print(totalMilliLitres);
    //Serial.print("mL / ");
    beer2Litres = beer2Volume - totalMilliLitres1; // need to divide  by 1000 on the receiving side
    dtostrf(beer2Litres, 6, 2, beer2LitresChar);
    if (flowMilliLitres2 > 0)
    {
      Serial.print("Beer 2 millilitres: ");
      Serial.println(beer2LitresChar);
    }
  }

  currentMillis3 = millis();
  if (currentMillis3 - previousMillis3 > interval)
  {
    pulseSec3 = pulseCount3;
    pulseCount3 = 0;

    // Because this loop may not complete in exactly 1 second intervals we calculate
    // the number of milliseconds that have passed since the last execution and use
    // that to scale the output. We also apply the calibrationFactor to scale the output
    // based on the number of pulses per second per units of measure (litres/minute in
    // this case) coming from the sensor.
    flowRate3 = ((1000.0 / (millis() - previousMillis3)) * pulseSec3) / calibrationFactor;
    previousMillis3 = millis();

    // Divide the flow rate in litres/minute by 60 to determine how many litres have
    // passed through the sensor in this 1 second interval, then multiply by 1000 to
    // convert to millilitres.
    flowMilliLitres3 = (flowRate3 / 60) * 1000;

    // Add the millilitres passed in this second to the cumulative total
    totalMilliLitres3 += flowMilliLitres3;

    // Print the flow rate for this second in litres / minute
    //Serial.print("Flow rate: ");
    //Serial.print(int(flowRate1));  // Print the integer part of the variable
    //Serial.print("L/min");
    //Serial.print("\t");       // Print tab space

    // Print the cumulative total of litres flowed since starting
    //Serial.print("Output Liquid Quantity: ");
    //Serial.print(totalMilliLitres);
    //Serial.print("mL / ");
    beer3Litres = beer3Volume - totalMilliLitres3; // need to divide  by 1000 on the receiving side
    dtostrf(beer3Litres, 6, 2, beer3LitresChar);
    if (flowMilliLitres3 > 0)
    {
      Serial.print("Beer 3 millilitres: ");
      Serial.println(beer3LitresChar);
    }
  }

  currentMillis4 = millis();
  if (currentMillis4 - previousMillis4 > interval)
  {
    pulseSec4 = pulseCount4;
    pulseCount4 = 0;

    // Because this loop may not complete in exactly 1 second intervals we calculate
    // the number of milliseconds that have passed since the last execution and use
    // that to scale the output. We also apply the calibrationFactor to scale the output
    // based on the number of pulses per second per units of measure (litres/minute in
    // this case) coming from the sensor.
    flowRate4 = ((1000.0 / (millis() - previousMillis4)) * pulseSec4) / calibrationFactor;
    previousMillis4 = millis();

    // Divide the flow rate in litres/minute by 60 to determine how many litres have
    // passed through the sensor in this 1 second interval, then multiply by 1000 to
    // convert to millilitres.
    flowMilliLitres4 = (flowRate4 / 60) * 1000;

    // Add the millilitres passed in this second to the cumulative total
    totalMilliLitres4 += flowMilliLitres4;

    // Print the flow rate for this second in litres / minute
    //Serial.print("Flow rate: ");
    //Serial.print(int(flowRate1));  // Print the integer part of the variable
    //Serial.print("L/min");
    //Serial.print("\t");       // Print tab space

    // Print the cumulative total of litres flowed since starting
    //Serial.print("Output Liquid Quantity: ");
    //Serial.print(totalMilliLitres);
    //Serial.print("mL / ");
    beer4Litres = beer4Volume - totalMilliLitres4; // need to divide  by 1000 on the receiving side
    dtostrf(beer4Litres, 6, 2, beer4LitresChar);
    if (flowMilliLitres4 > 0)
    {
      Serial.print("Beer 4 millilitres: ");
      Serial.println(beer4LitresChar);
    }
  }

  currentMillis5 = millis();
  if (currentMillis5 - previousMillis5 > interval)
  {
    pulseSec5 = pulseCount5;
    pulseCount5 = 0;

    // Because this loop may not complete in exactly 1 second intervals we calculate
    // the number of milliseconds that have passed since the last execution and use
    // that to scale the output. We also apply the calibrationFactor to scale the output
    // based on the number of pulses per second per units of measure (litres/minute in
    // this case) coming from the sensor.
    flowRate5 = ((1000.0 / (millis() - previousMillis5)) * pulseSec5) / calibrationFactor;
    previousMillis5 = millis();

    // Divide the flow rate in litres/minute by 60 to determine how many litres have
    // passed through the sensor in this 1 second interval, then multiply by 1000 to
    // convert to millilitres.
    flowMilliLitres5 = (flowRate5 / 60) * 1000;

    // Add the millilitres passed in this second to the cumulative total
    totalMilliLitres5 += flowMilliLitres5;

    // Print the flow rate for this second in litres / minute
    //Serial.print("Flow rate: ");
    //Serial.print(int(flowRate1));  // Print the integer part of the variable
    //Serial.print("L/min");
    //Serial.print("\t");       // Print tab space

    // Print the cumulative total of litres flowed since starting
    //Serial.print("Output Liquid Quantity: ");
    //Serial.print(totalMilliLitres);
    //Serial.print("mL / ");
    beer5Litres = beer5Volume - totalMilliLitres5; // need to divide  by 1000 on the receiving side
    dtostrf(beer5Litres, 6, 2, beer5LitresChar);
    if (flowMilliLitres5 > 0)
    {
      Serial.print("Beer 5 millilitres: ");
      Serial.println(beer5LitresChar);
    }
  }

  currentMillis6 = millis();
  if (currentMillis6 - previousMillis6 > interval)
  {
    pulseSec6 = pulseCount6;
    pulseCount6 = 0;

    // Because this loop may not complete in exactly 1 second intervals we calculate
    // the number of milliseconds that have passed since the last execution and use
    // that to scale the output. We also apply the calibrationFactor to scale the output
    // based on the number of pulses per second per units of measure (litres/minute in
    // this case) coming from the sensor.
    flowRate6 = ((1000.0 / (millis() - previousMillis6)) * pulseSec6) / calibrationFactor;
    previousMillis6 = millis();

    // Divide the flow rate in litres/minute by 60 to determine how many litres have
    // passed through the sensor in this 1 second interval, then multiply by 1000 to
    // convert to millilitres.
    flowMilliLitres6 = (flowRate6 / 60) * 1000;

    // Add the millilitres passed in this second to the cumulative total
    totalMilliLitres6 += flowMilliLitres6;

    // Print the flow rate for this second in litres / minute
    //Serial.print("Flow rate: ");
    //Serial.print(int(flowRate1));  // Print the integer part of the variable
    //Serial.print("L/min");
    //Serial.print("\t");       // Print tab space

    // Print the cumulative total of litres flowed since starting
    //Serial.print("Output Liquid Quantity: ");
    //Serial.print(totalMilliLitres);
    //Serial.print("mL / ");
    beer6Litres = beer6Volume - totalMilliLitres6; // need to divide  by 1000 on the receiving side
    dtostrf(beer6Litres, 6, 2, beer6LitresChar);
    if (flowMilliLitres6 > 0)
    {
      Serial.print("Beer 6 millilitres: ");
      Serial.println(beer6LitresChar);
    }
  }

  currentMillis7 = millis();
  if (currentMillis7 - previousMillis7 > interval)
  {
    pulseSec7 = pulseCount7;
    pulseCount7 = 0;

    // Because this loop may not complete in exactly 1 second intervals we calculate
    // the number of milliseconds that have passed since the last execution and use
    // that to scale the output. We also apply the calibrationFactor to scale the output
    // based on the number of pulses per second per units of measure (litres/minute in
    // this case) coming from the sensor.
    flowRate7 = ((1000.0 / (millis() - previousMillis7)) * pulseSec7) / calibrationFactor;
    previousMillis7 = millis();

    // Divide the flow rate in litres/minute by 60 to determine how many litres have
    // passed through the sensor in this 1 second interval, then multiply by 1000 to
    // convert to millilitres.
    flowMilliLitres7 = (flowRate7 / 60) * 1000;

    // Add the millilitres passed in this second to the cumulative total
    totalMilliLitres7 += flowMilliLitres7;

    // Print the flow rate for this second in litres / minute
    //Serial.print("Flow rate: ");
    //Serial.print(int(flowRate1));  // Print the integer part of the variable
    //Serial.print("L/min");
    //Serial.print("\t");       // Print tab space

    // Print the cumulative total of litres flowed since starting
    //Serial.print("Output Liquid Quantity: ");
    //Serial.print(totalMilliLitres);
    //Serial.print("mL / ");
    beer7Litres = beer7Volume - totalMilliLitres7; // need to divide  by 1000 on the receiving side
    dtostrf(beer7Litres, 6, 2, beer7LitresChar);
    if (flowMilliLitres7 > 0)
    {
      Serial.print("Beer 7 millilitres: ");
      Serial.println(beer7LitresChar);
    }
  }

  currentMillis8 = millis();
  if (currentMillis8 - previousMillis8 > interval)
  {
    pulseSec8 = pulseCount8;
    pulseCount8 = 0;

    // Because this loop may not complete in exactly 1 second intervals we calculate
    // the number of milliseconds that have passed since the last execution and use
    // that to scale the output. We also apply the calibrationFactor to scale the output
    // based on the number of pulses per second per units of measure (litres/minute in
    // this case) coming from the sensor.
    flowRate8 = ((1000.0 / (millis() - previousMillis8)) * pulseSec8) / calibrationFactor;
    previousMillis8 = millis();

    // Divide the flow rate in litres/minute by 60 to determine how many litres have
    // passed through the sensor in this 1 second interval, then multiply by 1000 to
    // convert to millilitres.
    flowMilliLitres8 = (flowRate8 / 60) * 1000;

    // Add the millilitres passed in this second to the cumulative total
    totalMilliLitres8 += flowMilliLitres8;

    // Print the flow rate for this second in litres / minute
    //Serial.print("Flow rate: ");
    //Serial.print(int(flowRate1));  // Print the integer part of the variable
    //Serial.print("L/min");
    //Serial.print("\t");       // Print tab space

    // Print the cumulative total of litres flowed since starting
    //Serial.print("Output Liquid Quantity: ");
    //Serial.print(totalMilliLitres);
    //Serial.print("mL / ");
    beer8Litres = beer8Volume - totalMilliLitres8; // need to divide  by 1000 on the receiving side
    dtostrf(beer8Litres, 6, 2, beer8LitresChar);
    if (flowMilliLitres8 > 0)
    {
      Serial.print("Beer 8 millilitres: ");
      Serial.println(beer8LitresChar);
    }
  }

  currentMillis9 = millis();
  if (currentMillis9 - previousMillis9 > interval)
  {
    pulseSec9 = pulseCount9;
    pulseCount9 = 0;

    // Because this loop may not complete in exactly 1 second intervals we calculate
    // the number of milliseconds that have passed since the last execution and use
    // that to scale the output. We also apply the calibrationFactor to scale the output
    // based on the number of pulses per second per units of measure (litres/minute in
    // this case) coming from the sensor.
    flowRate9 = ((1000.0 / (millis() - previousMillis9)) * pulseSec9) / calibrationFactor;
    previousMillis9 = millis();

    // Divide the flow rate in litres/minute by 60 to determine how many litres have
    // passed through the sensor in this 1 second interval, then multiply by 1000 to
    // convert to millilitres.
    flowMilliLitres9 = (flowRate9 / 60) * 1000;

    // Add the millilitres passed in this second to the cumulative total
    totalMilliLitres9 += flowMilliLitres9;

    // Print the flow rate for this second in litres / minute
    //Serial.print("Flow rate: ");
    //Serial.print(int(flowRate1));  // Print the integer part of the variable
    //Serial.print("L/min");
    //Serial.print("\t");       // Print tab space

    // Print the cumulative total of litres flowed since starting
    //Serial.print("Output Liquid Quantity: ");
    //Serial.print(totalMilliLitres);
    //Serial.print("mL / ");
    beer9Litres = beer9Volume - totalMilliLitres9; // need to divide  by 1000 on the receiving side
    dtostrf(beer9Litres, 6, 2, beer9LitresChar);
    if (flowMilliLitres9 > 0)
    {
      Serial.print("Beer 9 millilitres: ");
      Serial.println(beer9LitresChar);
    }
  }

  currentMillis10 = millis();
  if (currentMillis10 - previousMillis10 > interval)
  {
    pulseSec10 = pulseCount10;
    pulseCount10 = 0;

    // Because this loop may not complete in exactly 1 second intervals we calculate
    // the number of milliseconds that have passed since the last execution and use
    // that to scale the output. We also apply the calibrationFactor to scale the output
    // based on the number of pulses per second per units of measure (litres/minute in
    // this case) coming from the sensor.
    flowRate10 = ((1000.0 / (millis() - previousMillis10)) * pulseSec10) / calibrationFactor;
    previousMillis10 = millis();

    // Divide the flow rate in litres/minute by 60 to determine how many litres have
    // passed through the sensor in this 1 second interval, then multiply by 1000 to
    // convert to millilitres.
    flowMilliLitres10 = (flowRate10 / 60) * 1000;

    // Add the millilitres passed in this second to the cumulative total
    totalMilliLitres10 += flowMilliLitres10;

    // Print the flow rate for this second in litres / minute
    //Serial.print("Flow rate: ");
    //Serial.print(int(flowRate1));  // Print the integer part of the variable
    //Serial.print("L/min");
    //Serial.print("\t");       // Print tab space

    // Print the cumulative total of litres flowed since starting
    //Serial.print("Output Liquid Quantity: ");
    //Serial.print(totalMilliLitres);
    //Serial.print("mL / ");
    beer10Litres = beer10Volume - totalMilliLitres10; // need to divide  by 1000 on the receiving side
    dtostrf(beer10Litres, 6, 2, beer10LitresChar);
    if (flowMilliLitres10 > 0)
    {
      Serial.print("Beer 10 millilitres: ");
      Serial.println(beer10LitresChar);
    }
  }
}

void setup()
{
  // Serial port for debugging purposes
  Serial.begin(115200);
  Serial.println("");

  setupFlowData();

  // Initialize SPIFFS
  if (!SPIFFS.begin())
  {
    Serial.println("An Error has occurred while mounting SPIFFS");
    return;
  }

  // Connect to Wi-Fi
  preferences.begin("credentials", false);

  pwifiSSID = preferences.getString("pwifiSSID", "");
  pwifiPassword = preferences.getString("pwifiPassword", "");

  if (pwifiSSID == "" || pwifiPassword == "")
  {
    Serial.println("No values saved for ssid or password");
    WiFi.softAP("BeerTastic", "KegTastic");
    Serial.println();
    Serial.print("IP address: ");
    Serial.println(WiFi.softAPIP());
    Serial.print("SSID: ");
    Serial.println("BeerTastic");
    Serial.print("Password: ");
    Serial.println("KegTastic");
  }
  else
  {
    // Connect to Wi-Fi
    Serial.println("WiFi credentials stored in flash");
    WiFi.mode(WIFI_STA);
    WiFi.begin(pwifiSSID.c_str(), pwifiPassword.c_str());
    Serial.println("Connecting to WiFi ...");
    while (WiFi.status() != WL_CONNECTED)
    {
      Serial.print('.');
      delay(1000);
    }
    Serial.println(WiFi.localIP());
  }

  initWebSocket();

  setupServer();

  // Start web server
  server.begin();
  // Start ElegantOTA
  AsyncElegantOTA.begin(&server);
}

void loop()
{
  readFlows();

  if (ledLoop == 2)
  {
    AsyncElegantOTA.loop();
    ws.cleanupClients();
    digitalWrite(LED_BUILTIN, LOW);
    ledLoop = 0;
  }
}