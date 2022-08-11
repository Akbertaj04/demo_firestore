import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static Future<void> addUser(String uid) async {
    dynamic userExists;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // check if user Exists
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        userExists = documentSnapshot.exists;
      }
    });
    // Call the user's CollectionReference to add a new user
    return userExists == true
        ? users
            .doc(uid)
            .get()
            .then((value) => print("user exists"))
            .catchError((error) => print("Failed to get user exists: $error"))
        : users
            .doc(uid)
            .set({
              'userName': "user.displayName",
              'uid': uid,
              'email': "user.email",
              'dateOfBirth': 'dateOfBirth',
            })
            .then((value) => print("User Set"))
            .catchError((error) => print("Failed to add user: $error"));
  }
}
