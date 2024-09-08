#include <Arduino.h>
#include <WiFi.h>
#include <Wire.h>
#include <FirebaseESP32.h> //the second
#include <WiFiManager.h> 
#include "EmonLib.h"
#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"
#define DEVICE_UID "1X"
#include <Adafruit_Sensor.h>
#include <MPU6050_tockn.h>
#include "DHT.h"
#include <driver/adc.h>
#include <WebServer.h>
#include <DNSServer.h>
#include <ESP32Servo.h>

#define DHTPIN 4
#define DHTTYPE DHT22 
DHT dht(DHTPIN, DHTTYPE);

#define WIFI_SSID "Akash"
#define WIFI_PASSWORD "akash786"

#define API_KEY "xyz"
#define DATABASE_URL "https://smart-irrigation-fcb24-default-rtdb.asia-southeast1.firebasedatabase.app/"

FirebaseData fbdo;
FirebaseAuth fb_auth;
FirebaseConfig config;

int servoPin = 13;
int rain=0,motor = 0;

#define POWER_PIN 32  // ESP32's pin GPIO32 that provides the power to the rain sensor
#define DO_PIN 14     

String device_location = "Living Room"; 
String databasePath = ""; 
String email_name = "akash@gmail.com"; 
String password_name = "akash1"; 
String fuid = "";
unsigned long elapsedMillis = 0; 
unsigned long update_interval = 10000; 
bool isAuthenticated = false;


int _moisture, sensor_analog;
const int sensor_pin = A0;
int pos=0;

Servo myservo;

FirebaseJson humidity_json;
FirebaseJson temp_json;
FirebaseJson heatindex_json;
FirebaseJson moisture_json;
FirebaseJson user_json;

FirebaseJson motor_json;
FirebaseJson rain_json;

void Wifi_Init() {
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(300);
  }

  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();
}

void firebase_init() {
  config.api_key = API_KEY;
  fb_auth.user.password = password_name.c_str();
  fb_auth.user.email = email_name.c_str();
  config.database_url = DATABASE_URL;
  Firebase.reconnectWiFi(true);
  Serial.println("------------------------------------");
  Serial.println("Sign up new user...");

  if (Firebase.signUp(&config, &fb_auth, "", "")) {
    Serial.println("Success");
    isAuthenticated = true;
    databasePath = "/users/123"; 
    fuid = fb_auth.token.uid.c_str();
  } else {
    Serial.printf("Failed, %s\n", config.signer.signupError.message.c_str());
    isAuthenticated = false;
  }

  config.token_status_callback = tokenStatusCallback;

  Firebase.begin(&config, &fb_auth);

  while (!Firebase.ready()) {
    Serial.println("Firebase is not ready");
    delay(1000);
  }
}

void setup() {
  Serial.begin(115200);
  myservo.attach(servoPin, 500, 2400);
  myservo.write(pos); 
  Wifi_Init();
  firebase_init();
  Wire.begin();
  Serial.println(F("DHTxx test!"));
  dht.begin();
  pinMode(POWER_PIN, OUTPUT);  // configure the power pin pin as an OUTPUT
  pinMode(DO_PIN, INPUT);
}

void updateSensorReadings() {
  digitalWrite(POWER_PIN, HIGH);
  delay(10);
   int rain_state = digitalRead(DO_PIN);
   digitalWrite(POWER_PIN, LOW);

   if (rain_state == HIGH)
    rain=0;
  else
    rain=1;

  Serial.println("------------------------------------");
  Serial.println("Reading Sensor data ...");
  float h = dht.readHumidity();
  float t = dht.readTemperature();
  if (isnan(h) || isnan(t)) {
    Serial.println(F("Failed to read from DHT sensor!"));
    return;
  }
  
  float hic = dht.computeHeatIndex(t, h, false);

  Serial.print(F("Humidity: "));
  Serial.print(h);
  Serial.print(F("%  Temperature: "));
  Serial.print(t);
  Serial.print(F("°C "));
  Serial.print(F("°F  Heat index: "));
  Serial.print(hic);
  Serial.print(F("°C "));
  

  sensor_analog = analogRead(sensor_pin);
  _moisture = (100 - ((sensor_analog / 4095.00) * 100));
  Serial.print("Moisture = ");
  Serial.print(_moisture);  
  Serial.println("%");

  humidity_json.set("value", h);
  temp_json.set("value", t);
  heatindex_json.set("value", hic);
  moisture_json.set("value", _moisture);
  user_json.set("value", 123);
  rain_json.set("value", rain);
  motor_json.set("value",motor);
}

void uploadSensorData() {
  if (WiFi.status() != WL_CONNECTED) {
    Serial.println("Wi-Fi connection lost. Reconnecting...");
    Wifi_Init();
  }

  if (millis() - elapsedMillis > update_interval  && isAuthenticated && Firebase.ready()) 
  {
    elapsedMillis = millis();
    updateSensorReadings();
    String humidity_node = databasePath + "/humidity";
    String temp_node = databasePath + "/temp";
    String heatindex_node = databasePath + "/heatindex";
    String moisture_node = databasePath + "/moisture";
    // String motor_node = databasePath  + "/motor";
    String rain_node = databasePath  + "/rain";
    String user_node = databasePath  + "/users";

    if (Firebase.setJSON(fbdo, humidity_node.c_str(), humidity_json)) {
      Serial.println("PASSED");
          Serial.println("PATH: " + fbdo.dataPath());
          Serial.println("TYPE: " + fbdo.dataType());
          Serial.println("ETag: " + fbdo.ETag());
          Serial.print("VALUE: ");
          printResult(fbdo); //see addons/RTDBHelper.h
          Serial.println("------------------------------------");
          Serial.println();

    } else {
      Serial.println("FAILED");
          Serial.println("REASON: " + fbdo.errorReason());
          Serial.println("------------------------------------");
          Serial.println();
    }

    if (Firebase.setJSON(fbdo, temp_node.c_str(), temp_json)) {
      Serial.println("PASSED");
      printResult(fbdo);
    } else {
      Serial.println("FAILED [TEMP]");
      Serial.println("REASON: " + fbdo.errorReason());
    }

    if (Firebase.setJSON(fbdo, heatindex_node.c_str(), heatindex_json)) {
      Serial.println("PASSED");
      printResult(fbdo);
    } else {
      Serial.println("FAILED [HEAT INDEX]");
      Serial.println("REASON: " + fbdo.errorReason());
    }

    if (Firebase.setJSON(fbdo, moisture_node.c_str(), moisture_json)) {
      Serial.println("PASSED");
      printResult(fbdo);
    } else {
      Serial.println("FAILED [MOISTURE]");
      Serial.println("REASON: " + fbdo.errorReason());
    }
     if (Firebase.setJSON(fbdo, rain_node.c_str(), rain_json)) {
      Serial.println("PASSED");
      printResult(fbdo);
    } else {
      Serial.println("FAILED [RAIN]");
      Serial.println("REASON: " + fbdo.errorReason());
    }

    if (Firebase.setJSON(fbdo, user_node.c_str(), user_json)) {
      Serial.println("PASSED");
      printResult(fbdo);
    } else {
      Serial.println("FAILED [USER]");
      Serial.println("REASON: " + fbdo.errorReason());
    }

    if (Firebase.getInt(fbdo, (databasePath  + "/motor/motor"))) {
    motor = fbdo.intData();
    Serial.print("MOTORVALUE: ");
    Serial.println(motor);
    if(motor==0)
  {
    myservo.write(20);
    delay(15);  
  }
  else{
    myservo.write(70); 
    delay(15); 
  }
  } else {
    Serial.print("Failed to get sensor value: ");
    Serial.println(fbdo.errorReason());
  }


    
  }
}

void loop() {
  uploadSensorData();
  
}
