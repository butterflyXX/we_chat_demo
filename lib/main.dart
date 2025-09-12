import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/services/app_lifecycle_service.dart';
import 'package:chat_demo/common/services/blue_service/blue_service.dart';
import 'package:chat_demo/common/services/locale_service.dart';
import 'package:chat_demo/service_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_demo/route/route.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerServers();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  AppLifecycleService? _lifecycleService;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      serviceLocator.get<BlueService>().init();
      _lifecycleService = ref.read(appLifecycleServiceProvider);
      _lifecycleService?.initialize();
    });
  }

  @override
  void dispose() {
    _lifecycleService?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setReadProviderContext(context);
    return ScreenUtilInit(
      child: Consumer(
        builder: (context, ref, child) {
          return MaterialApp.router(
            title: 'Flutter Demo',
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
            ),
            locale: ref.watch(localeServiceProvider),
            routerConfig: router,
          );
        },
      ),
    );
  }
}
