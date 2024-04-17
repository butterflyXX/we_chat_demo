import 'package:flutter/cupertino.dart';

class ChatBottomBarController {
  ValueNotifier<int> type = ValueNotifier(0);
  final controller = TextEditingController();
  int lastType = 0;
  setType(int newType) {

    lastType = type.value;
    type.value = newType;
  }
}