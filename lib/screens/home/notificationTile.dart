import 'package:flutter/material.dart';
import 'package:food_aid/models/notification.dart';
import 'package:food_aid/models/user.dart';
import 'package:provider/provider.dart';
import 'package:food_aid/services/database.dart';

class NotificationTile extends StatefulWidget {
  final CustomNotification notification;
  NotificationTile({this.notification});

  @override
  _NotificationTileState createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    // if (widget.notification.userid != user.uid) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Text(
              widget.notification.numOfMeals + 'are available for donation'),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Text('Contact Num of Donor : ' +
                      widget.notification.phoneNumber),
                  Text('Email address of Donor : ' + widget.notification.email),
                ],
              ),
              Row(
                children: [
                  Text('City : ' + widget.notification.city),
                  Text('Area : ' + widget.notification.area),
                ],
              ),
              Row(
                children: [
                  Text('SelfDrop : ' + widget.notification.selfDrop),
                ],
              ),
            ],
          ),
          trailing: FlatButton(
            child: Text('Accept the Donation'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text('Please enter your contact details'),
                    content: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  enableSuggestions: true,
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
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
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
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  child: Text("Submit"),
                                  onPressed: () async {
                                    await DatabaseService(uid: user.uid)
                                        .updateOrder(
                                            widget.notification.userid,
                                            email,
                                            user.uid,
                                            widget.notification.uid);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
//}
