import 'package:chat_demo/common/data_base/data_base_service.dart';
import 'package:chat_demo/common/data_base/database.dart';
import 'package:chat_demo/common/user_info/user_info.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_list.g.dart';

@Riverpod(keepAlive: true)
class UserList extends _$UserList {
  @override
  Future<List<UserTableInfoData>> build() async {
    return await loadData();
  }

  Future<List<UserTableInfoData>> loadData() async {
    return await ref.read(dataBaseServiceProvider.notifier).getUsers();
  }

  void addUser(String id, String name) async {
    await ref
        .read(dataBaseServiceProvider.notifier)
        .insertOrUpdateUser(
          UserTableInfoCompanion(
            loginUserId: Value(ref.read(userInfoNotifierProvider)!.id),
            name: Value(name),
            userId: Value(id),
            createdAt: Value(DateTime.now()),
          ),
        );
    reloadData();
  }

  void reloadData() async {
    state = AsyncData(await loadData());
  }

  void deleteUserList() async {
    await ref.read(dataBaseServiceProvider.notifier).deleteUserList();
    reloadData();
  }
}
