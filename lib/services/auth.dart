import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_aid/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CustomUser _customUserFromUser(var user) {
    return CustomUser(uid: user.uid, email: user.email);
  }

  // SignUp using email and password
  Future signUp(String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      print(user.uid);
      print(user.email);
      //return _customUserFromUser(user);
    } catch (e) {
      print(e);
      //return null;
    }
  }

  // SignIn using email and password
  Future signIn(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      print(user.uid);
      print(user.email);
      //return _customUserFromUser(user);
    } catch (e) {
      print(e);
      //return null;
    }
  }

  // SignOut the current user
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
