import 'package:flutter/material.dart';
import 'package:we_chat_demo/common/widget/app_bar.dart';

class Contact extends StatefulWidget {
  static const String title = "通讯录";
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: commonAppbar(context,title: Contact.title),
      body: Center(
        child: Text(Contact.title),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}