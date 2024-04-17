import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:we_chat_demo/common/channel/event_channel.dart';
import 'package:we_chat_demo/common/color.dart';
import 'package:we_chat_demo/common/common.dart';
import 'package:we_chat_demo/common/value_notifier/tuple.dart';
import 'package:we_chat_demo/common/value_notifier/value_listenBuilder.dart';
import 'package:we_chat_demo/common/widget/button/icon_button.dart';
import 'package:we_chat_demo/common/widget/text_field/home_text_field.dart';
import 'package:we_chat_demo/feature/chat_detail/widget/chat_bottom_bar/chat_bottom_bar_controller.dart';

class ChatBottomBar extends StatefulWidget {
  final ChatBottomBarController controller;
  final ValueChanged<String>? onSubmit;
  final VoidCallback? hasFocus;

  const ChatBottomBar({
    required this.controller,
    this.onSubmit,
    this.hasFocus,
    super.key,
  });

  @override
  State<ChatBottomBar> createState() => _ChatBottomBarState();
}

class _ChatBottomBarState extends State<ChatBottomBar> {

  dynamic keyboardHeight = {};
  StreamSubscription? subscription;

  double _lastHeight = 34;

  @override
  void initState() {
    SystemChannels.textInput;
    subscription = keyBoardShowController.stream.listen(_changed);
    super.initState();
  }

  void _changed(event) {
    // final height = keyboardHeight["keyboardHeight"];
    // if(height != null) return;
    // keyboardHeight = event;
    // widget.controller.type.value = 1;
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: inputBackColor,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonIconButton(
                    onTap: () {},
                    child: Icon(Icons.play_arrow),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 6, top: 6),
                      child: HomeTextField(
                        onSubmit: widget.onSubmit,
                        hasFocus: () {
                          widget.hasFocus?.call();
                          widget.controller.setType(1);
                        },
                      ),
                    ),
                  ),
                  CommonIconButton(
                    onTap: () {},
                    child: const Icon(Icons.donut_small),
                  ),
                  CommonIconButton(
                    onTap: () {
                      widget.controller.setType(2);
                      cancelKeyBoard();
                    },
                    child: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              Builder(
                builder: (context) {
                  return ValueListenableBuilder(
                      valueListenable: widget.controller.type,
                      builder: (context, type, child) {
                        double height = 34;
                        if (type == 0) {
                          height = MediaQuery.of(context).viewInsets.bottom;
                          height = min(_lastHeight, height);
                          height = max(height, 34);
                        } else if (type == 1) {
                          height = MediaQuery.of(context).viewInsets.bottom;
                          height = max(_lastHeight, height);
                          height = max(height, 34);
                        } else if (type == 2) {
                          height = MediaQuery.of(context).viewInsets.bottom;
                          height = max(height, 200);
                        }
                        final child = AnimatedOpacity(
                          duration: const Duration(milliseconds: 250),
                          opacity: type == 2?1:0,
                          child: setting(),
                        );

                        final duration = (widget.controller.lastType == 1 || type == 1)?0:250;
                        _lastHeight = height;
                        return AnimatedContainer(
                          duration: Duration(milliseconds: duration),
                          height: height,
                          curve: Curves.easeInOut,
                          child: child,
                        );
                      });
                }
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget setting() {
    return Container(
      color: Colors.red,
    );
  }
}
