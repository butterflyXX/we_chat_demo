import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

late BuildContext _readProviderContext;

final readProvider = ProviderScope.containerOf(_readProviderContext).read;

void setReadProviderContext(BuildContext context) {
  _readProviderContext = context;
}

double get lineHeight => 1.0 / ScreenUtil().pixelRatio!;

void cancelKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

void llPrint(Object? message) {
  if (kDebugMode) {
    print(message);
  }
}
