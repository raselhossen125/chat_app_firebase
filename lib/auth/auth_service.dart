// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final User? user = _auth.currentUser;

  static Future<bool> logIn(String email, String password) async {
    final credensial = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return credensial.user != null;
  }

  static Future<bool> register(String email, String password) async {
    final credensial = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return credensial.user != null;
  }

  static Future<void> logOut() => _auth.signOut();

  static bool isEmailVerifyed() => _auth.currentUser!.emailVerified;

  static Future<void> sendVeryficationMail() =>
      _auth.currentUser!.sendEmailVerification();

  static Future<void> updateDisplayNamer(String name) =>
      _auth.currentUser!.updateDisplayName(name);

  static Future<void> updatePhoneNumber(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationid, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationid) {},
    );
  }
}
