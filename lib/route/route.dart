import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/user_info/user_info.dart';
import 'package:chat_demo/feature/login/login.dart';
import 'package:chat_demo/feature/mqtt_chat/mqtt_chat_page.dart';
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
    TypedGoRoute<MqttChatRoute>(path: 'mqtt_chat'),
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

class MqttChatRoute extends GoRouteData with _$MqttChatRoute {
  final String chatId;
  final String chatName;
  const MqttChatRoute({required this.chatId, required this.chatName});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      MqttChatPage(chatId: chatId, chatName: chatName);
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with _$LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => LoginPage();
}
