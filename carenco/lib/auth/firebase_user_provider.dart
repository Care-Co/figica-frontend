import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CarencoFirebaseUser {
  CarencoFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

CarencoFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<CarencoFirebaseUser> carencoFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<CarencoFirebaseUser>(
      (user) {
        currentUser = CarencoFirebaseUser(user);
        return currentUser!;
      },
    );
