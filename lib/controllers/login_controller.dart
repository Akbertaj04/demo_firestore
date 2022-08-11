import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../authenticationServices.dart';
import '../model/user_details.dart';

class LoginController with ChangeNotifier {
  // object
  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  UserDetails? userDetails;

  // fucntion for google login
  googleLogin() async {
    this.googleSignInAccount = await _googleSignIn.signIn();
    // inserting values to our user details model

    this.userDetails = new UserDetails(
      displayName: this.googleSignInAccount!.displayName,
      email: this.googleSignInAccount!.email,
      photoURL: this.googleSignInAccount!.photoUrl,
    );
    await Authentication.addUser(this.googleSignInAccount!.id);

    // call

    notifyListeners();
  }

  // function for facebook login
  facebooklogin() async {
    var result = await FacebookAuth.i.login(
      permissions: ["public_profile", "email"],
    );

    // check the status of our login
    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email, name, picture",
      );

      // this.userDetails = new UserDetails(
      //   displayName: requestData["name"],
      //   email: requestData["email"],
      //   photoURL: requestData["picture"]["data"]["url"] ?? " ",
      // );
      notifyListeners();
    }
  }

  // static Future<void> addUser(User user, {bool? isPhoneLogin}) async {
  //   dynamic userExists;
  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
  //   // check if user Exists
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user.uid)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       userExists = documentSnapshot.exists;
  //     }
  //   });
  //   // Call the user's CollectionReference to add a new user
  //   return userExists == true
  //       ? users.doc(user.uid).get()
  //       : users.doc(user.uid).set({
  //           'displayName': user.displayName,
  //           'uid': user.uid,
  //           'email': user.email,
  //           'photoURL': user.photoURL,
  //           'isConsumer': true,
  //           'isPhoneLogin': isPhoneLogin ?? false,
  //           'number': user.phoneNumber,
  //           'lastLoginDate':
  //               user.metadata.lastSignInTime.toString().split(' ').first,
  //         });
  // }

  // logout

  logout() async {
    this.googleSignInAccount = await _googleSignIn.signOut();
    await FacebookAuth.i.logOut();
    userDetails = null;
    notifyListeners();
  }
}
