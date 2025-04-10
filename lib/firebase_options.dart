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
    apiKey: 'AIzaSyDfLjAgbTYlq-nzVXlNhP3VKwNFtpUVwQg',
    appId: '1:1011230176264:web:cda13ccf168eb65e1f4dbd',
    messagingSenderId: '1011230176264',
    projectId: 'chat-app-025',
    authDomain: 'chat-app-025.firebaseapp.com',
    storageBucket: 'chat-app-025.firebasestorage.app',
    measurementId: 'G-V76X5YGP3J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2Bw1LnWlC_4m0PHZNBJuVY_bYuGYyI-4',
    appId: '1:1011230176264:android:4c129f753a3ae1941f4dbd',
    messagingSenderId: '1011230176264',
    projectId: 'chat-app-025',
    storageBucket: 'chat-app-025.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvbYcWzl7O1ktosNh9tIkg0ijdBMwgrVk',
    appId: '1:1011230176264:ios:49c53550814e6d531f4dbd',
    messagingSenderId: '1011230176264',
    projectId: 'chat-app-025',
    storageBucket: 'chat-app-025.firebasestorage.app',
    iosBundleId: 'com.example.scholarChatProj',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCvbYcWzl7O1ktosNh9tIkg0ijdBMwgrVk',
    appId: '1:1011230176264:ios:49c53550814e6d531f4dbd',
    messagingSenderId: '1011230176264',
    projectId: 'chat-app-025',
    storageBucket: 'chat-app-025.firebasestorage.app',
    iosBundleId: 'com.example.scholarChatProj',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDfLjAgbTYlq-nzVXlNhP3VKwNFtpUVwQg',
    appId: '1:1011230176264:web:52f8aae35ff972c31f4dbd',
    messagingSenderId: '1011230176264',
    projectId: 'chat-app-025',
    authDomain: 'chat-app-025.firebaseapp.com',
    storageBucket: 'chat-app-025.firebasestorage.app',
    measurementId: 'G-77RSF57ZT9',
  );
}
