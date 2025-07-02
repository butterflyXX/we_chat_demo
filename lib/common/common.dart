import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double get lineHeight => 1.0 / ScreenUtil().pixelRatio!;

void cancelKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

void llPrint(Object? message) {
  if (kDebugMode) {
    print(message);
  }
}
