import 'package:flutter/material.dart';
import 'package:we_chat_demo/common/widget/app_bar.dart';

class Contact extends StatefulWidget {
  static const String title = "通讯录";
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(context,title: Contact.title),
      body: Center(
        child: Text(Contact.title),
      ),
    );
  }
}