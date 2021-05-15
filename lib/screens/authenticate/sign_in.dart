import 'package:flutter/material.dart';
import 'package:food_aid/screens/authenticate/sign_up.dart';
import 'package:food_aid/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Aid App'),
        centerTitle: true,
        backgroundColor: Colors.brown[300],
      ),
      backgroundColor: Colors.grey,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(60.0, 0.0, 60.0, 0.0),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.brown[200], width: 2.0))),
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
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(60.0, 0.0, 60.0, 0.0),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.brown[200], width: 2.0))),
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Text('Login'),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic user = await _auth.signIn(email, password);
                    if (user == null) {
                      setState(() {
                        error = 'Invalid email or password';
                      });
                    }
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 90.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'New user? ',
                      style: TextStyle(
                        color: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  ElevatedButton(
                    child: Text('Register'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.redAccent),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
