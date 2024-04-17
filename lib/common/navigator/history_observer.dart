import 'package:flutter/cupertino.dart';

class HistoryObserver extends RouteObserver<PageRoute> {

  // 单例对象
  static final HistoryObserver _instance = HistoryObserver._();

  // 私有构造函数，防止外部直接实例化
  HistoryObserver._();

  // 工厂构造函数，用于返回单例对象
  factory HistoryObserver() => _instance;

  List<Route<dynamic>> history = [];
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    history.remove(route);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    history.add(route);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    history.remove(route);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null) {
      history.remove(oldRoute);
    }
    if (newRoute != null) {
      history.add(newRoute);
    }
  }
}