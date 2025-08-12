import 'package:chat_demo/common/data_base/database.dart';
import 'package:chat_demo/common/user_info/user_info.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_base_service.g.dart';

@Riverpod(keepAlive: true)
class DataBaseService extends _$DataBaseService {
  @override
  AppDatabase build() => AppDatabase();

  Future<void> insertOrUpdateUser(UserTableInfoCompanion user) async {
    await state.into(state.userTableInfo).insertOnConflictUpdate(user);
  }

  Future<void> updateUser(String userId, {required ValueGetter<UserTableInfoCompanion> onGetChangeValue}) async {
    final table = state.update(state.userTableInfo)..where((item) => item.userId.equals(userId));
    table.write(onGetChangeValue());
  }

  Future<List<UserTableInfoData>> getUsers() async {
    final table = state.select(state.userTableInfo)..where((item) => item.loginUserId.equals(ref.read(userInfoNotifierProvider)!.id));
    final data = await table.get();
    data.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return data;
  }

  Future<void> deleteUserList() async {
    await state.delete(state.userTableInfo).go();
    await state.delete(state.messageTable).go();
  }

  Future<void> insertOrUpdateMessage(MessageTableCompanion message) async {
    await state.into(state.messageTable).insertOnConflictUpdate(message);
  }

  Future<List<MessageTableData>> getMessages() async {
    final table = state.select(state.messageTable)..where((item) => item.loginUserId.equals(ref.read(userInfoNotifierProvider)!.id));
    final data = await table.get();
    data.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return data;
  }
}
