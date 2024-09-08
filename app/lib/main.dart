import 'dart:async';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_irrigation/api/firebase_api.dart';
import 'package:smart_irrigation/api/notificationservice.dart';
import 'package:smart_irrigation/main_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

// import 'package:schedule_local_notification/notificationservice.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService();
  await FirebaseApi().initNotifications();

  runApp(const MyApp());
}

  int language=1;

Future<void> _showSoilNotification(double soilMoisture) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'soil_channel_id',
    'Soil Notifications',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
  );

  await notificationsPlugin.show(
    0, // Notification ID
    'Soil Moisture Alert', // Notification title
    'Soil moisture is less than 25! Current level: $soilMoisture',
    notificationDetails,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmeasy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "Farming made eay"),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const mainPage())));

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = ScaleSize.textScaleFactor(context);
  

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xff9FC784),
            Color(0xff599522),
          ],
          stops: [0, 90],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Column(
          children: [
            SizedBox(
              height: 0.3 * screenHeight,
            ),
            Image.asset(
              "assets/images/logo.png",
              width: screenWidth * 0.4,
              height: screenHeight * 0.2,
            ),
            Text(
              language==0?"FARMEASY":"फार्म ईज़ी",
              style: TextStyle(
                fontFamily: "Impact",
                fontSize: textScaleFactor * 40,
                // fontWeight:FontWeight.w900,
                color: const Color(0xffF5F5F5),
                letterSpacing: 1,
              ),
            ),
            Text(
              language==0?"Farming Made Easy":"खेती करना हुआ आसान",
              style: TextStyle(
                fontFamily: "Mulish",
                fontSize: textScaleFactor * 20,
                fontWeight: FontWeight.w400,
                color: const Color(0xff599522),
                // color: Colors.white
              ),
            ),
            SizedBox(
              height: 0.05 * screenHeight,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image(
                alignment: Alignment.bottomCenter,
                image: const AssetImage(
                  "assets/images/splashplants.png",
                ),
                width: screenWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Directionality(
          textDirection: TextDirection.ltr,
          child: Text(text),
        ),
      ),
    );
  }
}
