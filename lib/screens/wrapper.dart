import 'package:flutter/material.dart';
import 'package:food_aid/models/user.dart';
import 'package:food_aid/screens/authenticate/authenticate.dart';
import 'package:food_aid/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    print(user);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
