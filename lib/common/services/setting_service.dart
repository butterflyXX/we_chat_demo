import 'package:chat_demo/common/kv_manager/kv_manager.dart';
import 'package:chat_demo/service_manager.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setting_service.g.dart';
part 'setting_service.freezed.dart';

@Riverpod(keepAlive: true)
class SettingService extends _$SettingService {
  @override
  SettingState build() {
    return SettingState(userChatAi: serviceLocator<KvManagerBase>().get<bool>(KvKey.userChatAi) ?? false);
  }

  void setUserChatAi(bool value) {
    state = state.copyWith(userChatAi: value);
    serviceLocator<KvManagerBase>().set<bool>(KvKey.userChatAi, value: value);
  }
}

@freezed
abstract class SettingState with _$SettingState {
  const factory SettingState({required bool userChatAi}) = _SettingState;

  factory SettingState.fromJson(Map<String, dynamic> json) => _$SettingStateFromJson(json);
}
