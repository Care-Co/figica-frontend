import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDLWu93cPZ1hhBDZDD3JFyTKEqzHiW4_Hk",
            authDomain: "carenco-94e1e.firebaseapp.com",
            projectId: "carenco-94e1e",
            storageBucket: "carenco-94e1e.appspot.com",
            messagingSenderId: "1039219461244",
            appId: "1:1039219461244:web:9b5aed52460e44da210df9",
            measurementId: "G-MXCJERP3SW"));
  } else {
    await Firebase.initializeApp();
  }
}
