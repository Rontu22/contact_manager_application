import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  ContactCard(
      {Key? key,
      required this.name,
      required this.phNumber,
      required this.email})
      : super(key: key);
  final String name;
  final String phNumber;
  final String email;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: size.height * 0.08,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name : ${this.name}"),
                Text("Ph Number : ${this.phNumber}"),
                Text("Email : ${this.email}"),
              ]),
        ),
      ),
    );
  }
}
