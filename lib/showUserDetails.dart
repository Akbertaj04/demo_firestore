import 'package:flutter/material.dart';

class ShowUserDetails extends StatefulWidget {
  final data;
  const ShowUserDetails({Key? key, this.data}) : super(key: key);

  @override
  State<ShowUserDetails> createState() => _ShowUserDetailsState();
}

class _ShowUserDetailsState extends State<ShowUserDetails> {
  // screen details
  dynamic data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.data['userName'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      )),
                  Text(widget.data['email'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      )),
                  Text(widget.data['uid'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      )),
                  Text(widget.data['dateOfBirth'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      )),
                ]),
          ),
        ),
      ),
    );
  }
}
