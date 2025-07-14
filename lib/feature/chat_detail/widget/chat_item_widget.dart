import 'package:chat_demo/common/mqtt/message_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_demo/common/color.dart';
import 'package:chat_demo/common/widget/chat_bubble.dart';

class ChatItemWidget extends StatelessWidget {
  final MessageInfo model;
  final String userId;

  const ChatItemWidget({required this.model, required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textWidth = constraints.maxWidth - 36.w - 20.w;

        final icon = Padding(
          padding: const EdgeInsets.only(top: 2),
          child: iconWidget(),
        );

        final text = textWidget(textWidth);

        final padding = SizedBox(width: 10.w);

        List<Widget> children = [icon, padding, Expanded(child: text)];

        if (!isUser()) {
          children = [Expanded(child: text), padding, icon];
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        );
      },
    );
  }

  Widget iconWidget() {
    return Container(
      height: 36.w,
      width: 36.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isUser() ? Colors.orangeAccent : Colors.blueAccent,
      ),
    );
  }

  Widget textWidget(double maxWidth) {
    return Row(
      mainAxisAlignment: !isUser()
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: ChatBubble(
            text: model.content,
            inLeft: isUser(),
            textBackColor: isUser() ? Colors.white : selectedTabBarItemColor,
          ),
        ),
      ],
    );
  }

  bool isUser() {
    return userId == model.senderId;
  }

  // String _formatTime(DateTime time) {
  //   final now = DateTime.now();
  //   final difference = now.difference(time);

  //   if (difference.inDays > 0) {
  //     return '${difference.inDays}天前';
  //   } else if (difference.inHours > 0) {
  //     return '${difference.inHours}小时前';
  //   } else if (difference.inMinutes > 0) {
  //     return '${difference.inMinutes}分钟前';
  //   } else {
  //     return '刚刚';
  //   }
  // }
}
