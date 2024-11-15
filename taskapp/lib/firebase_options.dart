// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyCCfG8bCqB7zTkHT0u8kSs0tnF2MqwhKiM',
    appId: '1:415860170073:web:1239a757ae197d3a9b0048',
    messagingSenderId: '415860170073',
    projectId: 'taskmanagmentapp-f8057',
    authDomain: 'taskmanagmentapp-f8057.firebaseapp.com',
    storageBucket: 'taskmanagmentapp-f8057.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmYlEefkd2CXljLvzJGB9cJWu2WZ4bYZQ',
    appId: '1:415860170073:android:1198b1eda3b0bcf99b0048',
    messagingSenderId: '415860170073',
    projectId: 'taskmanagmentapp-f8057',
    storageBucket: 'taskmanagmentapp-f8057.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqvuuItJmASXdyjmVXoIfZpv3nx0wiTmM',
    appId: '1:415860170073:ios:108c77a71559ae089b0048',
    messagingSenderId: '415860170073',
    projectId: 'taskmanagmentapp-f8057',
    storageBucket: 'taskmanagmentapp-f8057.firebasestorage.app',
    iosBundleId: 'com.example.taskapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBqvuuItJmASXdyjmVXoIfZpv3nx0wiTmM',
    appId: '1:415860170073:ios:108c77a71559ae089b0048',
    messagingSenderId: '415860170073',
    projectId: 'taskmanagmentapp-f8057',
    storageBucket: 'taskmanagmentapp-f8057.firebasestorage.app',
    iosBundleId: 'com.example.taskapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCCfG8bCqB7zTkHT0u8kSs0tnF2MqwhKiM',
    appId: '1:415860170073:web:5870bfbc5078f2079b0048',
    messagingSenderId: '415860170073',
    projectId: 'taskmanagmentapp-f8057',
    authDomain: 'taskmanagmentapp-f8057.firebaseapp.com',
    storageBucket: 'taskmanagmentapp-f8057.firebasestorage.app',
  );
}
