import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'xyz',
    appId: '1:889487711594:web:a2073f2c762fe9e2585913',
    messagingSenderId: '889487711594',
    projectId: 'smart-irrigation-fcb24',
    authDomain: 'smart-irrigation-fcb24.firebaseapp.com',
    storageBucket: 'smart-irrigation-fcb24.appspot.com',
    databaseURL:'https://smart-irrigation-fcb24-default-rtdb.asia-southeast1.firebasedatabase.app'
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'xyz',
    appId: '1:889487711594:android:aa47dec25e4306e9585913',
    messagingSenderId: '889487711594',
    projectId: 'smart-irrigation-fcb24',
    storageBucket: 'smart-irrigation-fcb24.appspot.com',
    databaseURL:'https://smart-irrigation-fcb24-default-rtdb.asia-southeast1.firebasedatabase.app',
    
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'xyz',
    appId: '1:889487711594:ios:acd0154d78b8b7d3585913',
    messagingSenderId: '889487711594',
    projectId: 'smart-irrigation-fcb24',
    storageBucket: 'smart-irrigation-fcb24.appspot.com',
    iosBundleId: 'com.example.smartIrrigation',
     databaseURL:'https://smart-irrigation-fcb24-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'xyz',
    appId: '1:889487711594:ios:acd0154d78b8b7d3585913',
    messagingSenderId: '889487711594',
    projectId: 'smart-irrigation-fcb24',
    storageBucket: 'smart-irrigation-fcb24.appspot.com',
    iosBundleId: 'com.example.smartIrrigation',
     databaseURL:'https://smart-irrigation-fcb24-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'xyz',
    appId: '1:889487711594:web:b49b64c593de58db585913',
    messagingSenderId: '889487711594',
    projectId: 'smart-irrigation-fcb24',
    authDomain: 'smart-irrigation-fcb24.firebaseapp.com',
    storageBucket: 'smart-irrigation-fcb24.appspot.com',
     databaseURL:'https://smart-irrigation-fcb24-default-rtdb.asia-southeast1.firebasedatabase.app',
  );
}
