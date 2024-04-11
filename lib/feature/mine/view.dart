import 'package:flutter/material.dart';
import 'package:we_chat_demo/common/widget/app_bar.dart';

class Mine extends StatefulWidget {
  static const String title = "我的";
  const Mine({super.key});

  @override
  State<Mine> createState() => _MineState();
}

class _MineState extends State<Mine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(context,title: Mine.title),
      body: Center(
        child: Text(Mine.title),
      ),
    );
  }
}
