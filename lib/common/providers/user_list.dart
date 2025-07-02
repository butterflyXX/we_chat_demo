import 'package:chat_demo/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_list.g.dart';

@Riverpod(keepAlive: true)
class UserList extends _$UserList {
  @override
  Future<List<UserBaseModel>> build() async {
    return await loadData();
  }

  Future<List<UserBaseModel>> loadData() async {
    final current = DateTime.now();
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(20, (index) {
      return UserBaseModel(
        icon: "icon",
        title: "test-$index",
        subTitle: "test-$index description sdhjsjdh1",
        id: index,
        time: current.millisecondsSinceEpoch - 1000 * 60 * 60 * index,
        name: "名字 - $index",
      );
    });
  }
}
