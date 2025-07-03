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
);

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [TypedGoRoute<ChatDetailRoute>(path: 'chat_detail')],
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
