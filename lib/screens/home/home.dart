import 'package:flutter/material.dart';
import 'package:food_aid/screens/home/notifications.dart';
import 'package:food_aid/services/auth.dart';
import 'package:food_aid/services/database.dart';
import 'package:provider/provider.dart';
import 'package:food_aid/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  void initializeDonations() {
    //code to get donatins that are previously done by this user
  }

  @override
  void initState() {
    super.initState();
    initializeDonations();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    final DatabaseService _db = DatabaseService(uid: user.uid);
    final notifications = Provider.of<QuerySnapshot>(context);

    return StreamProvider.value(
      value: _db.notifiy,
      child: Scaffold(
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
                              onPressed: () async {
                                dynamic res = await _db.donateFood(
                                    email,
                                    phoneNumber,
                                    numOfMeals,
                                    city,
                                    area,
                                    selfDrop);
                                print(res);
                              })
                        ],
                      );
                    });
              },
            ),
            RaisedButton(
                child: Text("My Donations"),
                color: Colors.blue,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          title: Text("My Donations"),
                          content: Text("Donations data goes here"),
                        );
                      });
                })
          ],
        ),
        body: Notifications(),
      ),
    );
  }
}
