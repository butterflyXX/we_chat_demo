import 'package:flutter/material.dart';
import 'package:we_chat_demo/common/navigator/history_observer.dart';

class NavigatorManager {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get state => navigatorKey.currentState!;

  static Future<T?> push<T extends Object?>(Route<T> route) {
    return state.push(route);
  }

  static Future<T?> pushNamed<T extends Object?>(
      String routeName, {
        Object? arguments,
      }) {
    return state.pushNamed(routeName,arguments: arguments);
  }

  static void pop<T extends Object?>([T? result]) {
    return state.pop();
  }

  static void popToRoute<T extends Object?>(String routeName,{T? result}) {
    final history = HistoryObserver().history;
    var current = history.last;
    while (history.length >= 2) {
      final last = history[history.length - 2];
      if (last.settings.name == routeName) {
        break;
      }
      state.removeRouteBelow(current);
    }
    if (history.length > 1) {
      state.pop(result);
    }
  }
}