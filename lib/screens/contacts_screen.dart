import 'dart:convert';

import 'package:contact_manager/screens/add_contact_info.dart';
import 'package:contact_manager/screens/contact_card.dart';
import 'package:contact_manager/screens/contacts_model.dart';
import 'package:contact_manager/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ContactModel> _contacts = [];

  Future<void> inflateContacts() async {
    _contacts = await retriveData();
  }

  @override
  void initState() {
    super.initState();
    inflateContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  inflateContacts();
                });
              },
              icon: Icon(Icons.refresh)),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: _contacts.length,
            itemBuilder: (context, index) {
              return ContactCard(
                  name: _contacts[index].name!,
                  phNumber: _contacts[index].phoneNumber!,
                  email: _contacts[index].email!);
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddContactsScreen()));
          },
          label: Text("Add Contact")),
    );
  }

  Future<List<ContactModel>> retriveData() async {
    final ref = FirebaseDatabase.instance.ref();
    DataSnapshot snapshot =
        await ref.child(FirebaseAuth.instance.currentUser!.uid).get();
    List<ContactModel> models = [];
    for (final child in snapshot.children) {
      String phNumber = child.children
          .firstWhere((element) => element.key == 'phNumber')
          .value
          .toString();
      String email = child.children
          .firstWhere((element) => element.key == 'email')
          .value
          .toString();
      String name = child.children
          .firstWhere((element) => element.key == 'name')
          .value
          .toString();

      ContactModel model =
          new ContactModel(name: name, email: email, phoneNumber: phNumber);
      models.add(model);
    }

    return models;
  }
}
