import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference notifications =
      FirebaseFirestore.instance.collection('notifications');

  //custom notification

  //stream for notifications collection
  Stream<QuerySnapshot> get notifiy {
    return notifications.snapshots();
  }

  Future donateFood(String email, String phoneNumber, String numOfMeals,
      String city, String area, String selfDrop) async {
    return await notifications.doc(uid).set({
      'uid': uid,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'NumOfMeals': numOfMeals,
      'City': city,
      'Area': area,
      'SelfDrop': selfDrop,
      'receiver': false
    });
  }
}
