import 'package:chat_demo/common/navigator/navigator_manager.dart';
import 'package:chat_demo/model/user_model.dart';
import 'package:chat_demo/route/route_name.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';
part 'state.freezed.dart';

@riverpod
class Home extends _$Home {
  @override
  String build() {
    return "test";
  }

  void gotoChatDetail(UserBaseModel model) {
    NavigatorManager.pushNamed(
      RouteName.chatDetail,
      arguments: {
        "params": {"name": model.name},
      },
    );
  }
}

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({required String name}) = _HomeState;

  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);
}
