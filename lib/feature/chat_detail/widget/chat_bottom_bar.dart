import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_chat_demo/common/color.dart';
import 'package:we_chat_demo/common/common.dart';
import 'package:we_chat_demo/common/widget/text_field/home_text_field.dart';

class ChatBottomBar extends StatefulWidget {
  final ValueChanged<String>? onSubmit;
  const ChatBottomBar({this.onSubmit, super.key});

  @override
  State<ChatBottomBar> createState() => _ChatBottomBarState();
}

class _ChatBottomBarState extends State<ChatBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: inputBackColor,
          child: Column(
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.play_arrow),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 6,top: 6),
                        child: HomeTextField(
                          onSubmit: widget.onSubmit,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.donut_small),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ],
    );
  }
}
