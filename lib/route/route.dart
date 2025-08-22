import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/user_info/user_info.dart';
import 'package:chat_demo/feature/add_user/add_user.dart';
import 'package:chat_demo/feature/blue/blue_list_page/view.dart';
import 'package:chat_demo/feature/blue/blue_page/view.dart';
import 'package:chat_demo/feature/login/login.dart';
import 'package:flutter/material.dart';
import 'package:chat_demo/feature/chat_detail/view.dart';
import 'package:chat_demo/feature/home_tab/view.dart';
import 'package:go_router/go_router.dart';

part 'route.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: const HomeRoute().location,
  navigatorKey: rootNavigatorKey,
  routes: $appRoutes,
  onException: (context, state, router) {
    // AppLinkHandler().handleRouteException(state, router);
  },
  overridePlatformDefaultLocation: true,
  redirect: (context, state) {
    // 获取容器实例
    final userInfo = readProvider(userInfoNotifierProvider);

    final loginRoute = LoginRoute().location;
    final homeRoute = HomeRoute().location;

    // 如果用户未登录且不在登录页面，重定向到登录页面
    if (userInfo == null && state.matchedLocation != loginRoute) {
      return loginRoute;
    }

    // 如果用户已登录且在登录页面，重定向到主页
    if (userInfo != null && state.matchedLocation == loginRoute) {
      return homeRoute;
    }

    return null;
  },
);

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<ChatDetailRoute>(path: 'chat_detail'),
    TypedGoRoute<AddUserRoute>(path: 'add_user'),
    TypedGoRoute<BlueListRoute>(path: 'blue_list'),
    TypedGoRoute<BluePageRoute>(path: 'blue'),
  ],
)
class HomeRoute extends GoRouteData with _$HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => HomeTab();
}

class ChatDetailRoute extends GoRouteData with _$ChatDetailRoute {
  final String userId;
  const ChatDetailRoute({required this.userId});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ChatDetailPage(userId: userId);
}

class AddUserRoute extends GoRouteData with _$AddUserRoute {
  const AddUserRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AddUserPage();
}

class BlueListRoute extends GoRouteData with _$BlueListRoute {
  const BlueListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const BlueListPage();
}

class BluePageRoute extends GoRouteData with _$BluePageRoute {
  final String deviceId;
  const BluePageRoute({required this.deviceId});

  @override
  Widget build(BuildContext context, GoRouterState state) => BluePage(deviceId: deviceId);
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with _$LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => LoginPage();
}
