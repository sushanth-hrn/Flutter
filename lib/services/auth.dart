import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_aid/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CustomUser _customUserFromUser(User user) {
    return user != null ? CustomUser(uid: user.uid, email: user.email) : null;
  }

  //auth change user Stream
  Stream<CustomUser> get user {
    return _auth.authStateChanges().map(_customUserFromUser);
  }

  // SignUp using email and password
  Future signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _customUserFromUser(user);
    } catch (e) {
      return null;
    }
  }

  // SignIn using email and password
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _customUserFromUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // SignOut the current user
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
