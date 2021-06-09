import 'package:flutter/material.dart';
import 'package:food_aid/models/user.dart';
import 'package:food_aid/services/auth.dart';
import 'package:food_aid/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_aid/shared/loading.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Background notification handling
  //here you can't do UI updates and also can't any change application state
  //as this will run in separate thread than main application
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      print('Couldn\'t initialize firebase_core');
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      Loading();
    }

    return StreamProvider<CustomUser>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        title: 'Food Aid',
        home: Wrapper(),
      ),
    );
  }
}
