import 'dart:math';

import 'package:flutter/material.dart';
import 'package:chat_demo/common/color.dart';
import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/widget/button/icon_button.dart';
import 'package:chat_demo/common/widget/text_field/home_text_field.dart';
import 'package:chat_demo/feature/chat_detail/widget/chat_bottom_bar/chat_bottom_bar_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatBottomBar extends ConsumerStatefulWidget {
  final String chatId;
  final ValueChanged<String>? onSubmit;
  final ValueChanged<bool>? hasFocus;
  final VoidCallback? keyboardFrameChange;

  const ChatBottomBar({
    required this.chatId,
    this.onSubmit,
    this.hasFocus,
    this.keyboardFrameChange,
    super.key,
  });

  @override
  ConsumerState<ChatBottomBar> createState() => _ChatBottomBarState();
}

class _ChatBottomBarState extends ConsumerState<ChatBottomBar> {
  double _lastHeight = 34;

  double _lastKeyboardHeight = 0.0;

  late final controller = ref.read(
    chatBottomBarControllerProvider(widget.chatId).notifier,
  );

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    if (_lastKeyboardHeight != mediaQuery.viewInsets.bottom) {
      _lastKeyboardHeight = mediaQuery.viewInsets.bottom;
      widget.keyboardFrameChange?.call();
    }
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
                    child: const Icon(Icons.play_arrow),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 6, top: 6),
                      child: HomeTextField(
                        onSubmit: widget.onSubmit,
                        hasFocus: (hasFocus) {
                          widget.hasFocus?.call(hasFocus);
                          if (hasFocus) {
                            controller.setType(ChatBottomBarInputType.keyboard);
                          }
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
                      controller.setType(ChatBottomBarInputType.setting);
                    },
                    child: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              Consumer(
                builder: (context, ref, child) {
                  final type = ref.watch(
                    chatBottomBarControllerProvider(widget.chatId),
                  );
                  double height = 34;
                  if (type == ChatBottomBarInputType.normal) {
                    height = mediaQuery.viewInsets.bottom;
                    height = min(_lastHeight, height);
                    height = max(height, 34);
                  } else if (type == ChatBottomBarInputType.keyboard) {
                    height = mediaQuery.viewInsets.bottom;
                    height = max(_lastHeight, height);
                    height = max(height, 34);
                  } else if (type == ChatBottomBarInputType.setting) {
                    height = mediaQuery.viewInsets.bottom;
                    height = max(height, 200);
                  }
                  final child = AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: type == ChatBottomBarInputType.setting ? 1 : 0,
                    child: setting(),
                  );
                  final duration =
                      (controller.lastType == ChatBottomBarInputType.keyboard ||
                          type == ChatBottomBarInputType.keyboard)
                      ? 0
                      : 250;
                  _lastHeight = height;
                  return AnimatedContainer(
                    duration: Duration(milliseconds: duration),
                    height: height,
                    curve: Curves.easeInOut,
                    child: child,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget setting() {
    return Container(color: Colors.red);
  }
}
