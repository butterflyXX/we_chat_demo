import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/feature/chat_detail/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_bottom_bar_controller.g.dart';

enum ChatBottomBarInputType { normal, keyboard, setting }

@riverpod
class ChatBottomBarController extends _$ChatBottomBarController {
  final controller = TextEditingController();
  @override
  ChatBottomBarInputType build(String chatId) => ChatBottomBarInputType.normal;

  ChatBottomBarInputType lastType = ChatBottomBarInputType.normal;
  void setType(ChatBottomBarInputType newType) {
    llPrint(newType.name);
    lastType = state;
    state = newType;
    if (newType == ChatBottomBarInputType.normal) {
      ref.read(chatDetailVMProvider(chatId).notifier).setCanScroll(true);
    } else {
      ref.read(chatDetailVMProvider(chatId).notifier).setCanScroll(false);
    }
  }
}
