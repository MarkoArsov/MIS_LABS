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
    apiKey: 'AIzaSyAaX8wlaHjoyLmGNyKEqiY46mUi8eUjz_M',
    appId: '1:338312319102:web:2f4cd4d12b03748d8a082f',
    messagingSenderId: '338312319102',
    projectId: 'mis-lab4-2eaba',
    authDomain: 'mis-lab4-2eaba.firebaseapp.com',
    storageBucket: 'mis-lab4-2eaba.appspot.com',
    measurementId: 'G-56XLDJ80ZH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDlu8Mxfk6h5FD0VNj5UCfgE5m3zbQy_Cg',
    appId: '1:338312319102:android:122496621dac97888a082f',
    messagingSenderId: '338312319102',
    projectId: 'mis-lab4-2eaba',
    storageBucket: 'mis-lab4-2eaba.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANaCn80giu5sZfxdiEPdN6rs4So2Q1ihU',
    appId: '1:338312319102:ios:29d8107e4b2ea6968a082f',
    messagingSenderId: '338312319102',
    projectId: 'mis-lab4-2eaba',
    storageBucket: 'mis-lab4-2eaba.appspot.com',
    iosBundleId: 'com.example.lab4',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyANaCn80giu5sZfxdiEPdN6rs4So2Q1ihU',
    appId: '1:338312319102:ios:28a6a0d219cb97438a082f',
    messagingSenderId: '338312319102',
    projectId: 'mis-lab4-2eaba',
    storageBucket: 'mis-lab4-2eaba.appspot.com',
    iosBundleId: 'com.example.lab4.RunnerTests',
  );
}
