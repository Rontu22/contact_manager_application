import 'dart:convert';

import 'package:contact_manager/screens/contacts_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddContactsScreen extends StatefulWidget {
  const AddContactsScreen({Key? key}) : super(key: key);

  @override
  State<AddContactsScreen> createState() => _AddContactsScreenState();
}

class _AddContactsScreenState extends State<AddContactsScreen> {
  final TextEditingController nameEditingController =
      new TextEditingController();
  final TextEditingController phoneEditingController =
      new TextEditingController();
  final TextEditingController emailEditingController =
      new TextEditingController();

  Future<void> _addData(
      {required String name,
      required String phNumber,
      required String email}) async {
    // final DatabaseReference contactRef = FirebaseDatabase.instance.ref("One");
    String userId = FirebaseAuth.instance.currentUser!.uid!.toString();
    DatabaseReference ref = FirebaseDatabase.instance.ref("$userId");
    Map userData = {
      "name": name,
      "phNumber": phNumber,
      "email": email,
    };
    ref.push().set(userData);

    // DatabaseReference ref = FirebaseDatabase.instance.ref("users/123");
    debugPrint(FirebaseAuth.instance.currentUser!.uid!.toString());
  }

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      autofocus: false,
      controller: nameEditingController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(),
        hintText: "Enter Name",
      ),
    );
    final phoneNumberField = TextFormField(
      autofocus: false,
      controller: phoneEditingController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone),
        border: OutlineInputBorder(),
        hintText: "Enter Phone Number",
      ),
    );
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        border: OutlineInputBorder(),
        hintText: "Enter Email",
      ),
    );
    final SizedBox sizedBox = new SizedBox(
      height: 20,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          nameField,
          sizedBox,
          phoneNumberField,
          sizedBox,
          emailField,
          sizedBox,
          sizedBox,
          CupertinoButton(
              color: Colors.blue,
              child: const Text("Save"),
              onPressed: () {
                _addData(
                    name: nameEditingController.text,
                    phNumber: phoneEditingController.text,
                    email: emailEditingController.text);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false);
              })
        ]),
      ),
    );
  }
}
