import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:smart_irrigation/const.dart';
import 'package:smart_irrigation/faqs.dart';
import 'package:smart_irrigation/irrigation.dart';
import 'package:smart_irrigation/main.dart';
import 'package:smart_irrigation/profile.dart';
import 'package:smart_irrigation/setting.dart';
import 'package:smart_irrigation/soilinfo.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:weather/weather.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}



class _HomepageState extends State<Homepage> {
  String _currentTime = "";
  final user = FirebaseAuth.instance.currentUser!;
  final WeatherFactory wf = WeatherFactory(API_KEY);
  Weather? _weather;
  int hour = 0;
  int minute = 0;
  String time = '';
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  Widget customButton({
    required VoidCallback onPressed,
    required String imagePath,
    required String buttonText,
    required double screenHeight,
    required double screenWidth,
    required double textScaleFactor,
  }) {
    return Container(
      height: 0.168 * screenHeight,
      width: 0.378 * screenWidth,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(50, 97, 92, 75),
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(38, 255, 255, 255),
          foregroundColor: const Color.fromARGB(76, 255, 255, 255),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                20), // Ensure the button shape matches the container
          ),
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth * 0.16,
              height: screenHeight * 0.10,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              buttonText,
              style: TextStyle(
                fontSize: 16 * textScaleFactor,
                color: const Color(0xff5C7744),
                fontWeight: FontWeight.w700,
                fontFamily: "Outfit",
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    wf.currentWeatherByLocation(3.457523, 77.026344).then((w) {
      setState(() {
        _weather = w;
        DateTime _currentTime = DateTime.now();
        hour = _currentTime.hour;
        minute = _currentTime.minute;
        time = "$hour:$minute";
        print("now : $hour:$minute");
      });
    });
  }

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = ScaleSize.textScaleFactor(context);

    return Scaffold(
      key: _globalKey,
      drawer: Drawer(
        width: 0.55 * screenWidth,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 0.08 * screenHeight,
            ),
            Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.06,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff79B343),
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.person_2_outlined),
                    iconSize: textScaleFactor * 30,
                    color: Color(0xffEDF5F4),
                    onPressed: () {
                      _globalKey.currentState!.openDrawer();
                    },
                  ),
                ),
                SizedBox(
                  width: 0.05 * screenWidth,
                ),
                Text(
                  language==0? "Akash" : "आकाश",
                  style: TextStyle(
                    fontFamily: "Outfit",
                    fontSize: textScaleFactor * 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            Divider(
              color: const Color.fromRGBO(158, 158, 158, 0.8),
              height: 0.1 * screenHeight,
              thickness: 2.5,
            ),
            SizedBox(
              width: screenWidth * 0.8,
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                size: textScaleFactor * 30,
                color: Colors.green[300],
              ),
              title: Text(
                language==0? 'Home' : "मुखपृष्ठ",
                style: TextStyle(
                  fontFamily: "Outfit",
                  fontSize: textScaleFactor * 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: textScaleFactor * 30,
                color: Colors.green[300],
              ),
              title: Text(
                language==0? 'Profile' : "आपके बारे में",
                style: TextStyle(
                  fontFamily: "Outfit",
                  fontSize: textScaleFactor * 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
                // Handle navigation to Profile
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                size: textScaleFactor * 30,
                color: Colors.green[300],
              ),
              title: Text(
                language==0? 'Settings' : "समायोजन",
                style: TextStyle(
                  fontFamily: "Outfit",
                  fontSize: textScaleFactor * 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
                // Handle navigation to Settings
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                size: textScaleFactor * 30,
                color: Colors.green[300],
              ),
              title: Text(
                language==0? 'Logout' : "बहार निकले",
                style: TextStyle(
                  fontFamily: "Outfit",
                  fontSize: textScaleFactor * 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/homepagebg.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.060,
            ),
            Row(
              children: [
                SizedBox(
                  width: 0.04 * screenWidth,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff79B343),
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.person_2_outlined),
                    iconSize: textScaleFactor * 30,
                    color: Color(0xffEDF5F4),
                    onPressed: () {
                      _globalKey.currentState!.openDrawer();
                    },
                  ),
                ),
                SizedBox(
                  width: 0.4 * screenWidth,
                ),
                ToggleSwitch(
                  minWidth: screenWidth*0.18,
                  minHeight: screenHeight*0.04,
              initialLabelIndex: 0,
              totalSwitches: 2,
              labels: ["English","हिंदी"],
              // activeFgColor: Colors.green[200],
              // inactiveFgColor: Colors.grey,
              
      activeFgColor: Colors.white, // Active text color
  inactiveFgColor: Colors.black, // Inactive text color
  activeBgColor: [Colors.green], // Green for the active toggle
  inactiveBgColor: Color(0xFFF5F5DC),

              onToggle: (newlanguage) {
                print('switched to: $language');
                setState(() {
                  language = newlanguage!;
                });
                
              },
            ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.048,
            ),
            GestureDetector(
              onTap: okay,
              child: Container(
                  height: screenHeight * 0.24,
                  width: screenWidth * 0.88,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 224, 228, 229),
                      Colors.white70
                    ], stops: [
                      0,
                      50
                    ]),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              language==0? 'WEATHER STATION' : "मौसम विभाग",
                              style: TextStyle(
                                color: Color(0xFF7A7B7A),
                                fontWeight: FontWeight.bold,
                                fontSize: 18 * textScaleFactor,
                                fontFamily: 'Outfit',
                              ),
                            ),
                            SizedBox(height: 0.01 * screenHeight),
                            // Text(_weather?.areaName ?? "",
                            //     style: TextStyle(
                            //       color: Color(0xFF515251),
                            //       fontSize: 16,
                            //     )),
                            // _location(),
                            Text(language==0? "Gurugram" : "गुरूग्राम",
                                style: TextStyle(
                                  color: Color(0xFF515251),
                                  fontSize: 18 * textScaleFactor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Outfit',
                                )),
                            SizedBox(height: 0.01 * screenHeight),
                            Row(
                              children: [
                                if (_weather != null)
                                  weather_icon(
                                    _weather!.weatherConditionCode!,
                                  ),
                                if (_weather == null)
                                  Text(
                                    language==0
                                        ? "Loading weather..."
                                        : "मौसम लोड हो रहा है...",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16 * textScaleFactor,
                                    ),
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.green[300],
                        thickness: 1,
                        width: 0.08 * screenWidth,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _datetimeInfo(),
                            SizedBox(height: 0.005 * screenHeight),
                            Text(
                              _weather?.weatherDescription ?? "",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15 * textScaleFactor,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 0.01 * screenHeight),
                            Text(
                              "${_weather?.temperature?.celsius?.toStringAsFixed(0)}°",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 32 * textScaleFactor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 0.008 * screenHeight),
                            Text(
                              "$time",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14 * textScaleFactor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: screenHeight * 0.052,
            ),
            Container(
                height: screenHeight * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        customButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const SoilInfo()));
                            },
                            imagePath: "assets/icons/soilinfo.png",
                            buttonText:
                                language==0? "Soil Info" : "मिट्टी की जानकारी",
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            textScaleFactor: textScaleFactor),
                        customButton(
                            onPressed: () async {
                              try {
                                dynamic conversationObject = {
                                  'appId':
                                      '25033bf7c73423981075770d5e2ba704a', // Obtain your App ID from Kommunicate dashboard
                                };

                                KommunicateFlutterPlugin.buildConversation(
                                        conversationObject)
                                    .then((clientConversationId) {
                                  print("Conversation builder success : " +
                                      clientConversationId.toString());
                                }).catchError((error) {
                                  print(
                                      "Conversation builder error occurred : " +
                                          error.toString());
                                });
                              } catch (e) {
                                print("Error: " + e.toString());
                              }
                            },
                            imagePath: "assets/icons/kakaji.png",
                            buttonText: language==0? "Kaka Ji" : "काका जी",
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            textScaleFactor: textScaleFactor),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        customButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => IrrigationPage()));
                            },
                            imagePath: "assets/icons/irrigation.png",
                            buttonText: language==0? "Irrigation" : "सिंचाई",
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            textScaleFactor: textScaleFactor),
                        customButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FaqPage()));
                            },
                            imagePath: "assets/icons/faqs.png",
                            buttonText:
                                language==0? "FAQS" : "सामान्य प्रश्नोत्तर",
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            textScaleFactor: textScaleFactor),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void okay() {
    print("okay");
  }

  Widget _location() {
    return Text(_weather?.areaName ?? "",
        style: TextStyle(
          color: Color(0xFF515251),
          fontSize: 16,
        ));
  }

  Widget _datetimeInfo() {
    DateTime now = _weather?.date ?? DateTime.now();

    return Text(DateFormat("EEEE").format(now),
        style: TextStyle(
          color: Colors.black54,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ));
  }

  Widget weather_icon(int code) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    print("code : $code");

    if (code > 200 && code <= 300) {
      return Image.asset(
        'assets/weather_images/thunder_storm.png', // replace with your asset path
        width: screenWidth * 0.3,
        height: screenHeight * 0.10,
      );
    } else if (code > 300 && code <= 500) {
      return Image.asset(
        'assets/weather_images/drizzling.png', // replace with your asset path
        width: screenWidth * 0.3,
        height: screenHeight * 0.10,
      );
    } else if (code > 500 && code <= 600) {
      return Image.asset(
        'assets/weather_images/raining.png', // replace with your asset path
        width: screenWidth * 0.3,
        height: screenHeight * 0.10,
      );
    } else if (code > 700 && code < 800) {
      return Image.asset(
        'assets/weather_images/mist.png', // replace with your asset path
        width: screenWidth * 0.3,
        height: screenHeight * 0.10,
      );
    } else if (code == 800) {
      return Image.asset(
        'assets/weather_images/sunny.png', // replace with your asset path
        width: screenWidth * 0.3,
        height: screenHeight * 0.10,
      );
    } else if (code > 800 && code <= 884) {
      return Image.asset(
        'assets/weather_images/cloudy.png', // replace with your asset path
        width: screenWidth * 0.3,
        height: screenHeight * 0.10,
      );
    } else if (code == 800 && int.parse(_currentTime) > 18) {
      return Image.asset(
        'assets/weather_images/sunny.png', // replace with your asset path
        width: screenWidth * 0.3,
        height: screenHeight * 0.10,
      );
    } else if (code > 800 && code <= 884 && int.parse(_currentTime) > 18) {
      return Image.asset(
        'assets/weather_images/cloudy.png', // replace with your asset path
        width: screenWidth * 0.3,
        height: screenHeight * 0.10,
      );
    } else {
      return Image.asset(
        'assets/weather_images/cloudy.png', // replace with your asset path
        width: screenWidth * 0.3,
        height: screenHeight * 0.10,
      );
    }
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
