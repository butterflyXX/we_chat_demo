import 'package:chat_demo/common/providers/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_demo/common/color.dart';
import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/widget/app_bar.dart';
import 'package:chat_demo/common/widget/button/icon_button.dart';
import 'package:chat_demo/feature/chat_detail/state.dart';
import 'package:chat_demo/feature/chat_detail/widget/chat_bottom_bar/chat_bottom_bar.dart';
import 'package:chat_demo/feature/chat_detail/widget/chat_bottom_bar/chat_bottom_bar_controller.dart';
import 'package:chat_demo/feature/chat_detail/widget/chat_item_widget.dart';

class ChatDetailPage extends ConsumerStatefulWidget {
  final String userId;
  const ChatDetailPage({super.key, required this.userId});

  @override
  ConsumerState<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends ConsumerState<ChatDetailPage> {
  final barController = ChatBottomBarController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(chatDetailVMProvider(widget.userId).notifier).link();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatDetailVMProvider(widget.userId).notifier);
    final chatList = ref.watch(chatListProvider(widget.userId));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: commonAppbar(
        context,
        title: widget.userId,
        actions: [
          CommonIconButton(onTap: () {}, child: const Icon(Icons.more_horiz)),
        ],
      ),
      backgroundColor: commonAppBarBackColor,
      body: GestureDetector(
        onTap: () {
          cancelKeyBoard();
          barController.setType(0);
        },
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 20),
                controller: state.controller,
                separatorBuilder: (_, _) {
                  return const SizedBox(height: 20);
                },
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  final model = chatList[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: ChatItemWidget(myId: 2, model: model),
                  );
                },
              ),
            ),
            ChatBottomBar(
              controller: barController,
              hasFocus: state.hasFocus,
              onSubmit: (value) {
                state.send(value);
                // return false;
              },
            ),
          ],
        ),
      ),
    );
  }
}
