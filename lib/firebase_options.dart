// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyD1gSlXRkEIE1nbTZYIGww8hPlbd7Ch4D4',
    appId: '1:271496468793:web:1a3ff9f4f7d2f4c57df0e8',
    messagingSenderId: '271496468793',
    projectId: 'noteme-02',
    authDomain: 'noteme-02.firebaseapp.com',
    storageBucket: 'noteme-02.appspot.com',
    measurementId: 'G-B0JYE1Q2K1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDL2gegOtvlDhJg1akBnREmrRmwEmZSqA',
    appId: '1:271496468793:android:a9d35c9d1769b4007df0e8',
    messagingSenderId: '271496468793',
    projectId: 'noteme-02',
    storageBucket: 'noteme-02.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1Y6MIybXzs13ngO7xFdTR_moiNeCYldA',
    appId: '1:271496468793:ios:ee8a6b74eb138fa47df0e8',
    messagingSenderId: '271496468793',
    projectId: 'noteme-02',
    storageBucket: 'noteme-02.appspot.com',
    iosClientId: '271496468793-t0dvghcbk863vsvhftjj36gmoil8i02t.apps.googleusercontent.com',
    iosBundleId: 'com.example.noteme',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA1Y6MIybXzs13ngO7xFdTR_moiNeCYldA',
    appId: '1:271496468793:ios:514e9cdba4f123ed7df0e8',
    messagingSenderId: '271496468793',
    projectId: 'noteme-02',
    storageBucket: 'noteme-02.appspot.com',
    iosClientId: '271496468793-6fkcrq85a13kec28efj02rmh6f73d7mr.apps.googleusercontent.com',
    iosBundleId: 'com.example.noteme.RunnerTests',
  );
}
