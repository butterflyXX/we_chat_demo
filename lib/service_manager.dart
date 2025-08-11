import 'package:chat_demo/common/kv_manager/kv_manager.dart';
import 'package:chat_demo/common/services/blue_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> registerServers() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<KvManagerBase>(KvManager(sp));
  serviceLocator.registerSingleton<BlueService>(BlueService());
}