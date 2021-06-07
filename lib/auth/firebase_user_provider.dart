import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class PhoneFirebaseUser {
  PhoneFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

PhoneFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<PhoneFirebaseUser> phoneFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<PhoneFirebaseUser>((user) => currentUser = PhoneFirebaseUser(user));
