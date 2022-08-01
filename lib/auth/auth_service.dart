// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final User? user = _auth.currentUser;
  
  static Future<bool> logIn (String email, String password) async {
    final credensial = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return credensial.user != null;
  }

  static Future<bool> register (String email, String password) async {
    final credensial = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return credensial.user != null;
  }
}