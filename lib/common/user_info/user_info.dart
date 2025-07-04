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
    return null;
  }

  void setUserInfo(UserInfo? userInfo) {
    state = userInfo;
  }
}
