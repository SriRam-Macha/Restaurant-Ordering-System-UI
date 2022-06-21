import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class SriRamSEProjectFirebaseUser {
  SriRamSEProjectFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

SriRamSEProjectFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<SriRamSEProjectFirebaseUser> sriRamSEProjectFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<SriRamSEProjectFirebaseUser>(
            (user) => currentUser = SriRamSEProjectFirebaseUser(user));
