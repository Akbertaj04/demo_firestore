// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore/model/user_details.dart';
import 'package:firestore/showUserDetails.dart';
import 'package:flutter/material.dart';
import 'controllers/login_controller.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login App"),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),

        // body of our ui
        // body: loginUI(),
        body: loginUI());
  }

  // creating a function loginUI

  loginUI() {
    // loggedINUI
    // loginControllers

    return Consumer<LoginController>(builder: (context, model, child) {
      // if we are already logged in
      if (model.userDetails != null) {
        // return Center(
        //   child: loggedInUI(model),
        // );
        return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                // .where('uid', isNotEqualTo: currentUserUid)
                // .orderBy('uid', descending: false)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                ));
              }

              if (snapshot.hasData) {
                return Scaffold(
                  body: SafeArea(
                    child: Center(
                      child: Column(
                        children: [
                          // user name list
                          SingleChildScrollView(
                            child: Column(
                              children: snapshot.data!.docs.map(
                                (DocumentSnapshot document) {
                                  dynamic data = document.data()!;
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ShowUserDetails(
                                                    data: data,
                                                  )));
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(data['userName'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.0,
                                            )),
                                      ],
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                          Spacer(),
                          // logout
                          ActionChip(
                              avatar: Icon(Icons.logout),
                              label: Text("Logout"),
                              onPressed: () {
                                Provider.of<LoginController>(context,
                                        listen: false)
                                    .logout();
                              })
                        ],
                      ),
                    ),
                  ),
                );
              }

              return Container();
            });
      } else {
        return loginControllers(context);
      }
    });
  }

  loggedInUI(LoginController model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      // our ui will have 3 children, name, email, photo , logout button

      children: [
        CircleAvatar(
          backgroundImage:
              Image.network(model.userDetails!.photoURL ?? "").image,
          radius: 50,
        ),

        Text(model.userDetails!.displayName ?? ""),
        Text(model.userDetails!.email ?? ""),
        Text("dateOfBirth"),
        Text(model.googleSignInAccount!.id),

        // logout
        ActionChip(
            avatar: Icon(Icons.logout),
            label: Text("Logout"),
            onPressed: () {
              Provider.of<LoginController>(context, listen: false).logout();
            })
      ],
    );
  }

  loginControllers(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              child: Image.asset(
                "assets/google.png",
                width: 240,
              ),
              onTap: () {
                Provider.of<LoginController>(context, listen: false)
                    .googleLogin();
              }),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
              child: Image.asset(
                "assets/fb.png",
                width: 240,
              ),
              onTap: () {
                Provider.of<LoginController>(context, listen: false)
                    .facebooklogin();
              }),
        ],
      ),
    );
  }
}
