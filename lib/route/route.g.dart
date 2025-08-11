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
    GoRouteData.$route(path: 'add_user', factory: _$AddUserRoute._fromState),
    GoRouteData.$route(path: 'blue_list', factory: _$BlueListRoute._fromState),
    GoRouteData.$route(path: 'blue', factory: _$BluePageRoute._fromState),
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

mixin _$AddUserRoute on GoRouteData {
  static AddUserRoute _fromState(GoRouterState state) => const AddUserRoute();

  @override
  String get location => GoRouteData.$location('/add_user');

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

mixin _$BlueListRoute on GoRouteData {
  static BlueListRoute _fromState(GoRouterState state) => const BlueListRoute();

  @override
  String get location => GoRouteData.$location('/blue_list');

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

mixin _$BluePageRoute on GoRouteData {
  static BluePageRoute _fromState(GoRouterState state) =>
      BluePageRoute(deviceId: state.uri.queryParameters['device-id']!);

  BluePageRoute get _self => this as BluePageRoute;

  @override
  String get location => GoRouteData.$location(
    '/blue',
    queryParams: {'device-id': _self.deviceId},
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
