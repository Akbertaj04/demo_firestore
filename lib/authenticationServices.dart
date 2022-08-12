// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static Future<void> addUser(String? userName, String? uid, String? email,
      String? dateOfBirth, String? photoUrl) async {
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
    // return userExists == true
    //     ? users
    //         .doc(uid)
    //         .get()
    //         .then((value) => print("user exists"))
    //         .catchError((error) => print("Failed to get user exists: $error"))
    //     :
    users
        .doc(uid)
        .set({
          'userName': userName,
          'uid': uid,
          'email': email,
          'dateOfBirth': dateOfBirth,
          'photoUrl': photoUrl,
        })
        .then((value) => print("User Set"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static Future<dynamic> getAllUserDetails(User user) async {
    dynamic allUserDetails;
    allUserDetails = FirebaseFirestore.instance.collection('users').get();
    return allUserDetails;
  }
}
