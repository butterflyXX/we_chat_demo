import 'package:flutter/material.dart';
import 'package:we_chat_demo/common/typedef.dart';

mixin Routable {
  late final Map<String,dynamic>? params;
  Map<String, dynamic>? get argument => params?["params"];
  Map<String, dynamic>? get statArgument => params?["statParams"];
}

class RouteBuild {
  static WidgetBuilder route({required CommonWidgetBuilder builder}) {
    return (context) {
      final widget = builder();
      final params = ModalRoute.of(context)?.settings.arguments??{};
      if (params is Map<String,dynamic>) {
        if (widget is Routable) {
          (widget as Routable).params = params;
        }
      }
      return widget;
    };
  }
}