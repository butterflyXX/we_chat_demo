import 'package:chat_demo/common/kv_manager/kv_manager.dart';
import 'package:chat_demo/common/services/blue_service.dart';
import 'package:chat_demo/common/services/record_service.dart';
import 'package:chat_demo/common/services/tts_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> registerServers() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<KvManagerBase>(KvManager(sp));
  serviceLocator.registerSingleton<BlueService>(BlueService());
  serviceLocator.registerSingleton<XfTtsService>(
    XfTtsService(
      const XfTtsConfig(
        appId: '28991844',
        apiKey: '2cfb41b426628d73ba16640d50279bc9',
        apiSecret: 'ZTY2OThlYTc5NzU5NmI1MDQ1ZGFhOTkz',
        host: 'cbm01.cn-huabei-1.xf-yun.com',
        path: '/v1/private/mcd9m97e6',
        vcn: 'x5_lingxiaoxuan_flow',
      ),
    ),
  );
  serviceLocator.registerSingleton<RecordService>(RecordService());
}
