import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_demo/common/channel/event_channel.dart';
import 'package:we_chat_demo/common/navigator/history_observer.dart';
import 'package:we_chat_demo/common/navigator/navigator_manager.dart';
import 'package:we_chat_demo/global_state.dart';
import 'package:we_chat_demo/route/route.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initEventChannel();

  runApp(Provider(
    create: (context)=>GlobalState(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: NavigatorManager.navigatorKey,
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        routes: LXCRoute.routes,
        navigatorObservers: [
          HistoryObserver(),
        ],
      ),
    );
  }
}
