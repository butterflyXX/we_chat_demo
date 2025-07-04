// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$homeRoute, $loginRoute];

RouteBase get $homeRoute => GoRouteData.$route(
  path: '/',

  factory: _$HomeRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'chat_detail',

      factory: _$ChatDetailRoute._fromState,
    ),
    GoRouteData.$route(path: 'mqtt_chat', factory: _$MqttChatRoute._fromState),
  ],
);

mixin _$HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$ChatDetailRoute on GoRouteData {
  static ChatDetailRoute _fromState(GoRouterState state) =>
      ChatDetailRoute(userId: state.uri.queryParameters['user-id']!);

  ChatDetailRoute get _self => this as ChatDetailRoute;

  @override
  String get location => GoRouteData.$location(
    '/chat_detail',
    queryParams: {'user-id': _self.userId},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$MqttChatRoute on GoRouteData {
  static MqttChatRoute _fromState(GoRouterState state) => MqttChatRoute(
    chatId: state.uri.queryParameters['chat-id']!,
    chatName: state.uri.queryParameters['chat-name']!,
  );

  MqttChatRoute get _self => this as MqttChatRoute;

  @override
  String get location => GoRouteData.$location(
    '/mqtt_chat',
    queryParams: {'chat-id': _self.chatId, 'chat-name': _self.chatName},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute =>
    GoRouteData.$route(path: '/login', factory: _$LoginRoute._fromState);

mixin _$LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  @override
  String get location => GoRouteData.$location('/login');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
