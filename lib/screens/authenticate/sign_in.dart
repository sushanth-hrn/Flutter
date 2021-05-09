import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Email',
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.cyanAccent, width: 2.0))),
            validator: (val) {
              if (val.isEmpty) {
                return "Enter email";
              }
              return null;
            },
            onChanged: (val) {
              setState(() {
                email = val;
              });
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Password',
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.cyanAccent, width: 2.0))),
            obscureText: true,
            validator: (val) {
              if (val.length < 6) {
                return "Enter Password that is grater than 6 characters";
              }
              return null;
            },
            onChanged: (val) {
              setState(() {
                password = val;
              });
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
              padding: EdgeInsets.only(left: 150.0, top: 40.0),
              child: RaisedButton(
                child: Text('Login'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    print(email);
                    print(password);
                  }
                },
              )),
        ],
      ),
    );
  }
}
