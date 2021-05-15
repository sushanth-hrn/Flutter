import 'package:flutter/material.dart';
import 'package:food_aid/models/user.dart';
import 'package:food_aid/services/auth.dart';
import 'package:food_aid/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      print('Loading');
    }

    return StreamProvider<CustomUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Food Aid',
        home: Wrapper(),
      ),
    );
  }
}
