import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAZYV06SeYIwfzGmrYj7XcNY7iDLR_HI1o",
            authDomain: "carenco-8781f.firebaseapp.com",
            projectId: "carenco-8781f",
            storageBucket: "carenco-8781f.appspot.com",
            messagingSenderId: "500436900437",
            appId: "1:500436900437:web:cda129f3f26a37ad2e92dc",
            measurementId: "G-8NDCCWMSPR"));
  } else {
    await Firebase.initializeApp();
  }
}
