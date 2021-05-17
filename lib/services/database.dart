import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_aid/models/notification.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference notifications =
      FirebaseFirestore.instance.collection('notifications');
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  //notification snapshot to list conversion
  List<CustomNotification> _toNotificationList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CustomNotification(
        uid: doc.id,
        userid: doc['userid'],
        email: doc['Email'] ?? '',
        phoneNumber: doc['PhoneNumber'] ?? '',
        numOfMeals: doc['NumOfMeals'] ?? '',
        city: doc['City'] ?? '',
        area: doc['Area'] ?? '',
        selfDrop: doc['SelfDrop'] ?? '',
        receiver: doc['receiver'] ?? false,
      );
    }).toList();
  }

  //stream for notifications collection
  Stream<List<CustomNotification>> get notifiy {
    return notifications.snapshots().map(_toNotificationList);
  }

  Future donateFood(String email, String phoneNumber, String numOfMeals,
      String city, String area, String selfDrop) async {
    return await notifications.add({
      'userid': uid,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'NumOfMeals': numOfMeals,
      'City': city,
      'Area': area,
      'SelfDrop': selfDrop,
      'receiver': false
    });
  }

  //populate order collection on receiver acceptance
  Future updateOrder(String donorId, String receiverEmail, String receiverid,
      String notificationId) async {
    // QuerySnapshot receiver =
    //     await users.where('email', isEqualTo: receiverEmail).limit(1).get();
    // List res = receiver.docs.map((doc) => doc['uid']);
    String receiverId = receiverid;
    dynamic result = await orders.add({
      'donorId': donorId,
      'notificationId': notificationId,
      'receiverId': receiverId,
    });
    await notifications.doc(notificationId).update({'receiver': true});
  }
}
