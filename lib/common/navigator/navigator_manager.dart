import 'package:chat_demo/route/route.dart';
import 'package:go_router/go_router.dart';

class NavigatorManager {
  static Future<T?> push<T extends Object?>(GoRouteData route) {
    return router.push(route.location);
  }

  static void pop<T extends Object?>([T? result]) {
    return router.pop(result);
  }

  static void go(String path) {
    router.go(path);
  }

  static void login() {
    router.go(LoginRoute().location);
  }
}
