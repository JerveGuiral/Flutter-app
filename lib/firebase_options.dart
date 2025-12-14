import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDdFlgWOjCqBok5wcWRFLYKl9mxZfAbT1E',
    appId: '1:110194306652:android:790b9cb8c3e93023f0c099',
    messagingSenderId: '110194306652',
    projectId: 'flutter-app-d249e',
    storageBucket: 'flutter-app-d249e.firebasestorage.app',
  );

  static FirebaseOptions get currentPlatform {
    return android;
  }
}