import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD2yPftuinBAeTUUnIhHxfmk_oiTG23FmQ",
            authDomain: "carencouserinfo.firebaseapp.com",
            projectId: "carencouserinfo",
            storageBucket: "carencouserinfo.appspot.com",
            messagingSenderId: "1070443989491",
            appId: "1:1070443989491:web:cf88120bfbc85eee2aea86",
            measurementId: "G-VZHK2G2CP1"));
  } else {
    await Firebase.initializeApp();
  }
}
