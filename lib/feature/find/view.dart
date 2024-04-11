import 'package:flutter/material.dart';
import 'package:we_chat_demo/common/widget/app_bar.dart';

class Find extends StatefulWidget {
  static const String title = "发现";
  const Find({super.key});

  @override
  State<Find> createState() => _FindState();
}

class _FindState extends State<Find> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(context,title: Find.title),
      body: Center(
        child: Text(Find.title),
      ),
    );
  }
}
