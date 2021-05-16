import 'package:flutter/material.dart';
import 'package:food_aid/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  String email = '';

  String phoneNumber = '';

  String numOfMeals = '';

  String city = '';

  String area = '';

  String selfDrop = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(Icons.person),
            label: Text('Sign Out'),
          ),
          RaisedButton(
            child: Text("Donate Food"),
            color: Colors.blue,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      scrollable: true,
                      title: Text('Food Donation'),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  icon: Icon(Icons.email),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  icon: Icon(Icons.phone_android_outlined),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    phoneNumber = val;
                                  });
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Number of meals',
                                  icon: Icon(Icons.food_bank_outlined),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    numOfMeals = val;
                                  });
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'City',
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    city = val;
                                  });
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Area',
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    area = val;
                                  });
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Self Drop',
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    selfDrop = val;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        RaisedButton(
                            child: Text("Submit"),
                            color: Colors.blue,
                            onPressed: () {})
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
