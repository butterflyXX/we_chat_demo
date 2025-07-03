import 'package:chat_demo/common/providers/chat_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';

typedef JumpCallBack<T> = void Function(bool animation, bool nextFrame);

@riverpod
class ChatDetailVM extends _$ChatDetailVM {
  final ScrollController controller = ScrollController();

  JumpCallBack? jumpWithAnimation;

  @override
  void build(String userId) {}

  void link() {
    jumpWithAnimation = (animation, nextFrame) {
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
    };
  }

  void addTest(String value) {
    ref.read(chatListProvider(userId).notifier).addTest(value);
    jumpWithAnimation?.call(true, true);
  }

  void send(String value) {
    addTest(value);
  }

  void hasFocus() {}
}
