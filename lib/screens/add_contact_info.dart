import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
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
      controller: emailEditingController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
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
        title: Text("Add Contact"),
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
              color: Colors.blue, child: Text("Save"), onPressed: () {})
        ]),
      ),
    );
  }
}
