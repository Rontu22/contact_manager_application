import 'package:contact_manager/screens/add_contact_info.dart';
import 'package:contact_manager/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        actions: [
          FlatButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => RegistrationScreen()),
                    (route) => false);
              },
              child: Text(
                "Sign-Out",
                style: TextStyle(
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: Center(
        child: CupertinoButton(
          child: Text("Click Here"),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddContactsScreen()));
          },
        ),
      ),
    );
  }
}
