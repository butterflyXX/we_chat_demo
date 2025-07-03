import 'package:chat_demo/common/providers/chat_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';
part 'state.freezed.dart';

@riverpod
class ChatDetailVM extends _$ChatDetailVM {
  final ScrollController controller = ScrollController();

  @override
  ChatDetailState build() {
    return const ChatDetailState();
  }

  void link(bool animation, bool nextFrame) {
    void anim() {
      if (animation) {
        controller.animateTo(
          controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
        );
      } else {
        controller.jumpTo(controller.position.maxScrollExtent);
      }
    }

    if (nextFrame) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        anim();
      });
    } else {
      anim();
    }
  }

  void send(String userId, String value) {
    ref.read(chatListProvider(userId).notifier).addTest(value);
    link(true, true);
  }

  void hasFocus(bool hasFocus) {}

  void setCanScroll(bool canScroll) {
    state = state.copyWith(canScroll: canScroll);
  }
}

@freezed
abstract class ChatDetailState with _$ChatDetailState {
  const factory ChatDetailState({@Default(true) bool canScroll}) =
      _ChatDetailState;
}
