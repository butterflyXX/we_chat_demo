import 'package:chat_demo/common/data_base/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_base_service.g.dart';

@riverpod
class DataBaseService extends _$DataBaseService {
  @override
  AppDatabase build() => AppDatabase();

  Future<void> insertOrUpdateUser(UserTableInfoCompanion user) async {
    await state.into(state.userTableInfo).insertOnConflictUpdate(user);
  }

  Future<List<UserTableInfoData>> getUsers() async {
    final data = await state.select(state.userTableInfo).get();
    data.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return data;
  }

  Future<void> deleteUserList() async {
    await state.delete(state.userTableInfo).go();
  }
}
