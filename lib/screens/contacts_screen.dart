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
      // body: Center(
      //   child: CupertinoButton(
      //     child: ContactCard(
      //       email: "ee",
      //       phNumber: "phe",
      //       name: "name",
      //     ),
      //     onPressed: () async {
      //       _contacts.forEach((element) {
      //         print(element);
      //       });
      //       print(_contacts[1].name);

      //       // callDatabase();
      //       // List<ContactModel> models = await retriveData();
      //       // models.forEach((element) {
      //       //   print(element);
      //       // });
      //       // contacts.then((value) => value.forEach((element) {
      //       //       print(element.toJson());
      //       //     }));
      //     },
      //   ),
      // ),
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

  // Future<void> callDatabase() async {
  //   final ref = FirebaseDatabase.instance.ref();
  //   final snapshot =
  //       await ref.child(FirebaseAuth.instance.currentUser!.uid).get();
  //   print(snapshot.value);
  // }

  Future<List<ContactModel>> retriveData() async {
    final ref = FirebaseDatabase.instance.ref();
    DataSnapshot snapshot =
        await ref.child(FirebaseAuth.instance.currentUser!.uid).get();
    List<ContactModel> models = [];
    for (final child in snapshot.children) {
      // String name = child.children.first.value.toString();
      // print(child.children.first.key);
      // print(child.children
      //     .firstWhere((element) => element.key == 'phNumber')
      //     .value);
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
      // print(name);
      // print(phNumber);
      // print(email);
      ContactModel model =
          new ContactModel(name: name, email: email, phoneNumber: phNumber);
      models.add(model);
    }

    // Object? modelsList = snapshot.value;
    // print(modelsList);

    // snapshot.children.forEach((element) {
    //   print(element.key);
    //   print(element.value);
    //   // Map<String, dynamic> json = Map.from(element.value);
    // });
    // print(snapshot);
    // for (final child in snapshot.children) {
    //   print(child.key);

    //   // Map<String, dynamic> m = child.value as Map<String, dynamic>;
    //   // print(m);
    //   // ContactModel model = ContactModel.fromJson({"name": child.value['name'],});
    // }

    return models;
  }
}
