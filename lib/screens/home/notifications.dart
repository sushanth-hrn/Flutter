import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_aid/models/notification.dart';
import 'package:food_aid/screens/home/notificationTile.dart';
import 'package:food_aid/models/user.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    final notifications = Provider.of<List<CustomNotification>>(context);
    final user = Provider.of<CustomUser>(context);

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return NotificationTile(notification: notifications[index]);
      },
    );
  }
}
