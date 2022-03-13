import 'package:contact_manager/screens/contacts_screen.dart';
import 'package:contact_manager/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // our form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController firstNameEditingController =
      new TextEditingController();
  final TextEditingController secondNameEditingController =
      new TextEditingController();
  final TextEditingController emailEditingController =
      new TextEditingController();
  final TextEditingController passwordEditingController =
      new TextEditingController();
  final TextEditingController confirmPasswordEditingController =
      new TextEditingController();

  Future<void> _registerUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  // void _register() async {
  //   final FirebaseUser user = (await
  //   _auth.createUserWithEmailAndPassword(
  //     email: "rontubarhoi01@gmail.com",
  //     password:"abc123@#123",
  //   )
  //   ).user;
  //   if (user != null) {
  //     setState(() {
  //
  //     });
  //   } else {
  //     setState(() {
  //
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        border: OutlineInputBorder(),
        hintText: "First Name",
      ),
    );

    // final secondNameField = TextFormField(
    //   autofocus: false,
    //   controller: secondNameEditingController,
    //   keyboardType: TextInputType.name,
    //   onSaved: (value) {
    //     secondNameEditingController.text = value!;
    //   },
    //   textInputAction: TextInputAction.next,
    //   decoration: InputDecoration(
    //     prefixIcon: Icon(Icons.mail),
    //     border: OutlineInputBorder(),
    //     hintText: "Second Name",
    //   ),
    // );

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
        hintText: "Email",
      ),
    );

    final passwordField = TextFormField(
      obscureText: true,
      autofocus: false,
      controller: passwordEditingController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        border: OutlineInputBorder(),
        hintText: "Password",
      ),
    );

    // final confirmPasswordField = TextFormField(
    //   autofocus: false,
    //   obscureText: true,
    //   controller: confirmPasswordEditingController,
    //   keyboardType: TextInputType.name,
    //   onSaved: (value) {
    //     confirmPasswordEditingController.text = value!;
    //   },
    //   textInputAction: TextInputAction.next,
    //   decoration: InputDecoration(
    //     prefixIcon: Icon(Icons.mail),
    //     border: OutlineInputBorder(),
    //     hintText: "Confirm Password",
    //   ),
    // );
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      firstNameField,
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      // secondNameField,
                      // SizedBox(
                      //   height: size.height * 0.05,
                      // ),
                      emailField,
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      passwordField,
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      // confirmPasswordField,
                      // SizedBox(
                      //   height: size.height * 0.05,
                      // ),
                      CupertinoButton(
                        color: Colors.blue,
                        child: Text("Sign-Up"),
                        onPressed: () {
                          String email = emailEditingController.text;
                          String password = passwordEditingController.text;
                          _registerUser(email: email, password: password);
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {
                          print("This is a trial project");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text("Already have an account ? Login"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
