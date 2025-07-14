import 'dart:convert';

import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/kv_manager/kv_manager.dart';
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
    return getCacheUserInfo();
  }

  void setUserInfo(UserInfo? userInfo) {
    state = userInfo;
    setCacheUserInfo();
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
}
