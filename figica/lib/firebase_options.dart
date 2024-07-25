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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCXfP_QVzf9v1HNBAuWYhAvJnculmVbjwA',
    appId: '1:1018044330468:web:5c69e518249da5973ad7f1',
    messagingSenderId: '1018044330468',
    projectId: 'fisicatest-fc73a',
    authDomain: 'fisicatest-fc73a.firebaseapp.com',
    storageBucket: 'fisicatest-fc73a.appspot.com',
    measurementId: 'G-0XSVCYN0DB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDS9TADdQ5n4Bss4gG7oM4u0T_9qBJz2Jc',
    appId: '1:1018044330468:android:a15b17500b3fec7a3ad7f1',
    messagingSenderId: '1018044330468',
    projectId: 'fisicatest-fc73a',
    storageBucket: 'fisicatest-fc73a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7aS9qC3KauDcKEKE2MRnJCIrOGdzOT7Q',
    appId: '1:1018044330468:ios:92bbb323cffb0ede3ad7f1',
    messagingSenderId: '1018044330468',
    projectId: 'fisicatest-fc73a',
    storageBucket: 'fisicatest-fc73a.appspot.com',
    androidClientId: '1018044330468-3b0efntd1rjsvkm6asadm0vcerrvjpkb.apps.googleusercontent.com',
    iosClientId: '1018044330468-eire81ghvo2luc6h5pg1fic14itgambk.apps.googleusercontent.com',
    iosBundleId: 'com.carenco.fisica',
  );
}
