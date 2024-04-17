import 'dart:async';

import 'package:flutter/services.dart';

EventChannel eventChannel = const EventChannel("event");
StreamController keyBoardShowController = StreamController.broadcast();

initEventChannel() {
  eventChannel.receiveBroadcastStream().listen((event) {
    if(event["name"] == "KeyboardWillShow") {
      keyBoardShowController.add(event["value"]);
    }
  });
}