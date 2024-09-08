import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smart_irrigation/main.dart';
class SoilInfo extends StatefulWidget {
  const SoilInfo({super.key});

  @override
  State<SoilInfo> createState() => _SoilInfoState();
}


class _SoilInfoState extends State<SoilInfo> {
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
              language==0?"Soil Information":"मिट्टी की जानकारी",
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
            image: AssetImage("assets/images/soilinfo.png"),
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
            if (isLoading) CircularProgressIndicator(),

            // Show data in different boxes when available
            if (soilData != null)
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    // soilData!['temp']['value'].toString()
                    _buildInfoBox(
                        language==0?"Heat Index":"ताप सूचकांक",
                        soilData!['heatindex']['value'].toString(),
                        screenWidth,
                        textScaleFactor,
                        screenHeight
                        ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildInfoBox(
                        language==0?"Humidity":"हवा की नमी",
                        soilData!['humidity']['value'].toString(),
                        screenWidth,
                        textScaleFactor,
                        screenHeight),
                    SizedBox(height: screenHeight * 0.02),
                    _buildInfoBox(
                        language==0?"Moisture":"मिट्टी की नमी",
                        soilData!['moisture']['value'].toString(),
                        screenWidth,
                        textScaleFactor,
                        screenHeight),
                    SizedBox(height: screenHeight * 0.02),
                    _buildInfoBox(
                        language==0?"Temperature":"तापमान",
                        soilData!['temp']['value'].toString(),
                        screenWidth,
                        textScaleFactor,
                        screenHeight),
                        SizedBox(height: screenHeight * 0.02),
                        _buildInfoBox(
                        language==0?"Rain":"बारिश",
                        soilData!['rain']['value'].toString(),
                        screenWidth,
                        textScaleFactor,
                        screenHeight),
                  ],
                ),
              ),

            SizedBox(
              height: screenHeight * 0.1,
            ),

            // Show message if no data is available
            if (soilData == null && !isLoading)
              Text(
                language==0?"No data available":"कोई डेटा मौजूद नहीं",
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
      String title, String value, double width, double textScaleFactor, double screenHeight) {
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
              value=="0"?(language==0?"No":"नहीं"):(value==1?(language==0?"Yes":"हाँ"):value),
              style: TextStyle(
                fontSize: 12 * textScaleFactor,
                fontWeight: FontWeight.w700,
                fontFamily: 'Mulish',
              ),
            ),
            LinearProgressIndicator(
              value: double.parse(value)/100,
              semanticsLabel: 'Linear progress indicator',
              color: (double.parse(value)/100)<0.25?Colors.red:(double.parse(value)/100<0.5? Colors.yellow:Colors.green),
              minHeight: 0.02*screenHeight,

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
