import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

// import { initializeApp } from "firebase/app";
// import { getAnalytics } from "firebase/analytics";
/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
///
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
      apiKey: "AIzaSyDfjRngKMYgAr6l5s3VWED1vTLL2fEz_yc",
      authDomain: "notesflutter-c1048.firebaseapp.com",
      projectId: "notesflutter-c1048",
      storageBucket: "notesflutter-c1048.appspot.com",
      messagingSenderId: "161487283733",
      appId: "1:161487283733:web:ac7e79174f2d67b85dd01c"
  );


  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfjRngKMYgAr6l5s3VWED1vTLL2fEz_yc',
    appId: '1:161487283733:android:65302894a31cd8865dd01c',
    messagingSenderId: '161487283733',
    projectId: 'notesflutter-c1048',
    storageBucket: 'notesflutter-c1048.appspot.com',
  );
}
