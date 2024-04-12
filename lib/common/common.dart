import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double get lineHeight => 1.0 / ScreenUtil().pixelRatio!;

cancelKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}