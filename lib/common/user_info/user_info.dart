import 'dart:convert';

import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/config/mqtt_config.dart';
import 'package:chat_demo/common/extension/util_extension.dart';
import 'package:chat_demo/common/kv_manager/kv_manager.dart';
import 'package:chat_demo/common/mqtt/chat_manager.dart';
import 'package:chat_demo/service_manager.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_info.freezed.dart';
part 'user_info.g.dart';

@freezed
abstract class UserInfo with _$UserInfo {
  const factory UserInfo({required String id, required String name}) =
      _UserInfo;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}

@Riverpod(keepAlive: true)
class UserInfoNotifier extends _$UserInfoNotifier {
  @override
  UserInfo? build() {
    final userInfo = getCacheUserInfo();
    if (userInfo != null) {
      Future(() {
        _connectSocket();
      });
    }
    return userInfo;
  }

  void setUserInfo(UserInfo? userInfo) {
    state = userInfo;
    setCacheUserInfo();
    _connectSocket();
  }

  UserInfo? getCacheUserInfo() {
    final infoString = serviceLocator<KvManagerBase>().get(KvKey.userInfo);
    if (infoString == null) return null;
    try {
      final infoJson = jsonDecode(infoString);
      final userInfo = UserInfo.fromJson(infoJson);
      return userInfo;
    } catch (_) {
      return null;
    }
  }

  Future<bool> setCacheUserInfo() async {
    String? infoString;
    if (state != null) {
      try {
        final infoJson = state!.toJson();
        infoString = jsonEncode(infoJson);
      } catch (err) {
        llPrint('user_save_error: $err');
      }
    }
    return serviceLocator<KvManagerBase>().set(KvKey.userInfo, value: infoString);
  }

  Future _connectSocket() async {
    final chatManager = ref.read(chatManagerProvider.notifier);
    await chatManager.disconnect();
    // 初始化 ChatManager
    state?.let((it) async {
      try {
        await chatManager.initialize(
          userId: it.id,
          userName: it.name,
          userAvatar: '', // 当前没有头像信息
          broker: MqttConfig.defaultBroker,
          port: MqttConfig.defaultPort,
          username: MqttConfig.defaultUsername,
          password: MqttConfig.defaultPassword,
        );

        // 连接到 MQTT 服务器
        await chatManager.connect();
      } catch (e) {
        llPrint('MQTT 连接失败: $e');
      }
    });
  }
}
