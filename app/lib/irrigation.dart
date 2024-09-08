import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smart_irrigation/main.dart';
import 'package:toggle_switch/toggle_switch.dart';

class IrrigationPage extends StatefulWidget {
  const IrrigationPage({super.key});

  @override
  State<IrrigationPage> createState() => _IrrigationPageState();
}

int motor=0;

class _IrrigationPageState extends State<IrrigationPage> {
  Map<String, dynamic>? soilData;
  bool isLoading = true; // Initially true to show the loading spinner

  @override
  void initState() {
    super.initState();
    // Start reading data as soon as the widget is initialized
    readData();
  }

  // Function to continuously listen for data changes from Firebase
  void readData() {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/123");

    // Listen to data changes in real-time
    ref.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          soilData = data.map((key, value) => MapEntry(key.toString(), value));
          isLoading = false; // Data has been loaded, stop the loading spinner
        });
      } else {
        setState(() {
          soilData = null; // Set null if no data is available
          isLoading = false;
        });
      }
    });
  }

  void writeMotorData(int? a) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/123/motor");

    // Write only "motor" data to Firebase
    await ref.update({
      "motor": a, // Update this with the actual motor state (true/false)
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = ScaleSize.textScaleFactor(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.005,
            ),
            Text(
              language == 0 ? "Irrigation" : "सिंचाई",
              style: TextStyle(
                  fontFamily: "Mulish", fontSize: textScaleFactor * 24),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 140, 187, 88),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/soilinfo.png",
            ),
            fit:BoxFit.cover,
          ),
          
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.1,
            ),
            // Loading indicator while fetching data

            SizedBox(
              height: screenHeight * 0.1,
            ),

            ToggleSwitch(
              initialLabelIndex: 0,
              totalSwitches: 2,
              activeFgColor: Colors.white, // Active text color
  inactiveFgColor: Colors.black, // Inactive text color
  activeBgColor: [Colors.green], // Green for the active toggle
  inactiveBgColor: Color(0xFFF5F5DC),
              labels: [
                language == 0 ? "OFF" : "बंद",
                language == 0 ? "ON" : "चालू"
                
              ],
              onToggle: (newmotor) {

                setState(() {
                  motor=newmotor!;
                });
                writeMotorData(motor);
                print('switched to: $motor');
              },
            ),

            // Show message if no data is available
            if (soilData == null && !isLoading)
              Text(
                language == 0 ? "No data available" : "कोई डेटा मौजूद नहीं",
                style: TextStyle(
                  fontSize: textScaleFactor * 18,
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox(
      String title, String value, double width, double textScaleFactor) {
    if (value != null) {
      return Container(
        width: width * 0.8,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.fromRGBO(159, 199, 132, 0.9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16 * textScaleFactor,
                fontWeight: FontWeight.w900,
                fontFamily: 'Mulish',
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 12 * textScaleFactor,
                fontWeight: FontWeight.w700,
                fontFamily: 'Mulish',
              ),
            ),
            LinearProgressIndicator(
              value: 0.3,
              semanticsLabel: 'Linear progress indicator',
            ),
          ],
        ),
      );
    } else {
      return Container(
        child: SizedBox(),
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
