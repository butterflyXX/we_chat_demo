import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/mqtt/chat_manager.dart';
import 'package:chat_demo/common/providers/user_list.dart';
import 'package:chat_demo/feature/chat_detail/widget/recording_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_demo/common/color.dart';
import 'package:chat_demo/common/widget/app_bar.dart';
import 'package:chat_demo/common/widget/button/icon_button.dart';
import 'package:chat_demo/feature/chat_detail/state.dart';
import 'package:chat_demo/feature/chat_detail/widget/chat_bottom_bar/chat_bottom_bar.dart';
import 'package:chat_demo/feature/chat_detail/widget/chat_item_widget.dart';

class ChatDetailPage extends ConsumerStatefulWidget {
  final String userId;
  const ChatDetailPage({super.key, required this.userId});

  @override
  ConsumerState<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends ConsumerState<ChatDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    llPrint('build');
    final stateNotifier = ref.read(chatDetailVMProvider(widget.userId).notifier);
    final chatList = ref.watch(chatManagerProvider.select((state) => state[widget.userId])) ?? [];
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: commonAppbar(
            context,
            title: ref.watch(userListProvider.notifier.select((it) => it.getUser(widget.userId)))?.name ?? '',
            actions: [CommonIconButton(onTap: () {}, child: const Icon(Icons.more_horiz))],
          ),
          backgroundColor: commonAppBarBackColor,
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: stateNotifier.unfocus,
            onVerticalDragStart: (_) {
              stateNotifier.unfocus();
            },
            child: Column(
              children: [
                Expanded(
                  child: Consumer(
                    builder: (context, ref, child) {
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        physics: ref.watch(chatDetailVMProvider(widget.userId).select((it) => it.canScroll))
                            ? null
                            : const NeverScrollableScrollPhysics(),
                        controller: stateNotifier.controller,
                        separatorBuilder: (_, _) {
                          return const SizedBox(height: 20);
                        },
                        itemCount: chatList.length,
                        itemBuilder: (context, index) {
                          final model = chatList[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: ChatItemWidget(userId: widget.userId, model: model),
                          );
                        },
                      );
                    },
                  ),
                ),
                ChatBottomBar(
                  chatId: widget.userId,
                  hasFocus: stateNotifier.hasFocus,
                  onSubmit: (value) {
                    stateNotifier.sendMessage(value);
                  },
                  keyboardFrameChange: () {
                    stateNotifier.scrollToBottom(false, false);
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Consumer(
            builder: (context, ref, child) {
              if (ref.watch(chatDetailVMProvider(widget.userId).select((it) => it.isRecord))) {
                return Material(
                  color: Colors.transparent,
                  child: const RecordingPage(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
