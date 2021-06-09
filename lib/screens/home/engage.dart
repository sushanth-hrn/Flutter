import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Engage extends StatefulWidget {
  const Engage({Key key}) : super(key: key);

  @override
  _EngageState createState() => _EngageState();
}

class _EngageState extends State<Engage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  @override
  void initState() async {
    super.initState();

    //The below codes will handle user interaction (when they click on notification)

    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "New Food",
    // navigate to a home screen
    if (initialMessage?.data['type'] == 'New Food') {
      //go to home screen
    }

    // If the message also contains a data property with a "type" of "New Receiver",
    // navigate to a Google Maps screen or anything that handles this
    if (initialMessage?.data['type'] == 'New Food') {
      //go to appropriate screen
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['type'] == 'New Food') {
        //go to home screen
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['type'] == 'New Receiver') {
        //go to appropriate screen
      }
    });
    //End of interaction handling code

    await _fcm.subscribeToTopic('Receivers');

    //Below codes handle the notification

    //Foreground notification handling
    //here you can do UI updates and also change application state
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
