import 'package:flutter/material.dart';
import 'package:food_aid/screens/authenticate/sign_up.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Aid App'),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent,
      ),
      backgroundColor: Colors.grey,
      body: SignUp(),
    );
  }
}
