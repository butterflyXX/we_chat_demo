import 'package:flutter/material.dart';
import 'package:we_chat_demo/feature/home_tab/view.dart';
import 'package:we_chat_demo/route/route_builder.dart';
import 'package:we_chat_demo/route/route_name.dart';

class LXCRoute {
  static Map<String, WidgetBuilder> routes = {
    RouteName.home: RouteBuild.route(builder: ()=> HomeTab()),
  };
}