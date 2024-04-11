import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_chat_demo/common/color.dart';
import 'package:we_chat_demo/common/widget/chat_bubble.dart';
import 'package:we_chat_demo/model/chat_item_model.dart';

class ChatItemWidget extends StatelessWidget {
  final ChatItemModel model;
  final int myId;

  const ChatItemWidget({required this.model, required this.myId, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textWidth = constraints.maxWidth - 36.w - 20.w;

        final icon = Padding(
          padding: EdgeInsets.only(top: 2),
          child: iconWidget(),
        );

        final text = textWidget(textWidth);

        final padding = SizedBox(
          width: 10.w,
        );

        List<Widget> children = [
          icon,
          padding,
          Expanded(child: text,),
        ];

        if(isMe()) {
          children = [
            Expanded(child: text,),
            padding,
            icon,
          ];
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
        color: isMe()?Colors.blueAccent:Colors.orangeAccent,
      ),
    );
  }

  Widget textWidget(double maxWidth) {
    return Row(
      mainAxisAlignment: isMe()?MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: ChatBubble(
            text: model.text,
            inLeft: !isMe(),
            textBackColor: isMe()?selectedTabBarItemColor:Colors.white,
          ),
        ),
      ],
    );
  }

  bool isMe() {
    return myId == model.id;
  }
}
