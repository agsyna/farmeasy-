import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smart_irrigation/homepage.dart';
import 'package:smart_irrigation/main.dart';

class FaqPage extends StatefulWidget {
  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    double textScaleFactor = ScaleSize.textScaleFactor(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(language==0?"FAQs":"पूछे जाने वाले प्रश्न"),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.search,
        //       color: Colors.black,
        //     ),
        //     onPressed: () {},
        //   ),
        // ],
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // FAQ image at the top
          Container(
            height: 200,
            width: double.infinity,
            child: Image.asset(
              'assets/images/faqs.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blueAccent,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    language==0?'Frequently Asked Questions':"अक्सर पूछे जाने वाले प्रश्नों",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ExpansionTile(
                  title: Text(
                    language==0?'How to use this app==0?':"इस ऐप का उपयोग कैसे करें",
                    style: TextStyle(
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      fontSize: textScaleFactor * 13,
                    ),
                  ),
                  children: [
                    ListTile(
                      title: Text(
                        language==0?'You can use this app for multiple tasks such as interacting with the chatbot "Kaka Ji," which assists with agricultural queries and hardware operations. Additionally, you can monitor soil information and manage the irrigation system by simply clicking the respective icons on the homepage.':"आप इस ऐप का उपयोग कई कार्यों के लिए कर सकते हैं जैसे कि चैटबॉट 'काका जी' के साथ बातचीत करना, जो कृषि प्रश्नों और हार्डवेयर संचालन में सहायता करता है। इसके अतिरिक्त, आप केवल होमपेज पर संबंधित आइकन पर क्लिक करके मिट्टी की जानकारी की निगरानी कर सकते हैं और सिंचाई प्रणाली का प्रबंधन कर सकते हैं।",
                        style: TextStyle(
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w400,
                          fontSize: textScaleFactor * 13,
                        ),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    language==0?'How to change the interface language==0?':"इंटरफ़ेस भाषा कैसे बदलें==0?",
                    style: TextStyle(
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      fontSize: textScaleFactor * 13,
                    ),
                  ),
                  children: [
                    ListTile(
                      title: Text(
                        language==0?'We are currently working on implementing language change options. This feature will be available soon.':"हम वर्तमान में भाषा परिवर्तन विकल्पों को लागू करने पर काम कर रहे हैं। यह सुविधा जल्द ही उपलब्ध होगी.",
                        style: TextStyle(
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w400,
                          fontSize: textScaleFactor * 13,
                        ),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    language==0?'How to use the chatbot==0?':"चैटबॉट का उपयोग कैसे करें==0?",
                    style: TextStyle(
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      fontSize: textScaleFactor * 13,
                    ),
                  ),
                  children: [
                    ListTile(
                      title: Text(
                        language==0?'To use our chatbot "Kaka Ji," click on its icon. A text box will appear where you can type your query, and the chatbot will provide you with an appropriate response.':'हमारे चैटबॉट "काका जी" का उपयोग करने के लिए इसके आइकन पर क्लिक करें। एक टेक्स्ट बॉक्स दिखाई देगा जहां आप अपनी क्वेरी टाइप कर सकते हैं, और चैटबॉट आपको उचित प्रतिक्रिया प्रदान करेगा।',
                        style: TextStyle(
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w400,
                          fontSize: textScaleFactor * 13,
                        ),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    language==0?'How do I log out==0?':'मैं लॉग आउट कैसे करूँ==0?',
                    style: TextStyle(
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      fontSize: textScaleFactor * 13,
                    ),
                  ),
                  children: [
                    ListTile(
                      title: Text(
                        language==0?'To log out, open the app menu, navigate to the settings or profile section, and select "Log Out."':'लॉग आउट करने के लिए, ऐप मेनू खोलें, सेटिंग्स या प्रोफ़ाइल अनुभाग पर जाएँ, और "लॉग आउट करें" चुनें।',
                        style: TextStyle(
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w400,
                          fontSize: textScaleFactor * 13,
                        ),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    language==0?'How do I change my profile information==0?':'मैं अपनी प्रोफ़ाइल जानकारी कैसे बदलूं==0?',
                    style: TextStyle(
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      fontSize: textScaleFactor * 13,
                    ),
                  ),
                  children: [
                    ListTile(
                      title: Text(
                        language==0?'Go to your profile, click "Edit Profile," and update your personal information such as name, email, and profile picture.':'अपनी प्रोफ़ाइल पर जाएं, "प्रोफ़ाइल संपादित करें" पर क्लिक करें और अपनी व्यक्तिगत जानकारी जैसे नाम, ईमेल और प्रोफ़ाइल चित्र अपडेट करें।',
                        style: TextStyle(
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w400,
                          fontSize: textScaleFactor * 13,
                        ),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    language==0?'How do I contact customer support==0?':'मैं ग्राहक सहायता से कैसे संपर्क करूं==0?',
                    style: TextStyle(
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      fontSize: textScaleFactor * 13,
                    ),
                  ),
                  children: [
                    ListTile(
                      title: Text(
                        language==0?'You can contact customer support through the "Help & Support" section in the app, where you\'ll find options for email, live chat, or phone support.':'आप ऐप में "सहायता और सहायता" अनुभाग के माध्यम से ग्राहक सहायता से संपर्क कर सकते हैं, जहां आपको ईमेल, लाइव चैट या फोन सहायता के विकल्प मिलेंगे।',
                        style: TextStyle(
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w400,
                          fontSize: textScaleFactor * 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
