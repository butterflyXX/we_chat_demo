import 'dart:math';

import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/services/record_service.dart';
import 'package:chat_demo/feature/chat_detail/state.dart';
import 'package:chat_demo/feature/chat_detail/widget/recording_page.dart';
import 'package:chat_demo/service_manager.dart';
import 'package:flutter/material.dart';
import 'package:chat_demo/common/color.dart';
import 'package:chat_demo/common/widget/button/icon_button.dart';
import 'package:chat_demo/common/widget/text_field/home_text_field.dart';
import 'package:chat_demo/feature/chat_detail/widget/chat_bottom_bar/chat_bottom_bar_controller.dart';
import 'package:chat_demo/feature/chat_detail/widget/chat_bottom_bar/item_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ChatBottomBar extends ConsumerStatefulWidget {
  final String chatId;
  final ValueChanged<String>? onSubmit;
  final ValueChanged<bool>? hasFocus;
  final VoidCallback? keyboardFrameChange;

  const ChatBottomBar({required this.chatId, this.onSubmit, this.hasFocus, this.keyboardFrameChange, super.key});

  @override
  ConsumerState<ChatBottomBar> createState() => _ChatBottomBarState();
}

class _ChatBottomBarState extends ConsumerState<ChatBottomBar> {
  double _lastHeight = 34;

  double _lastKeyboardHeight = 0.0;

  late final controller = ref.read(chatBottomBarControllerProvider(widget.chatId).notifier);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    if (_lastKeyboardHeight != mediaQuery.viewInsets.bottom) {
      _lastKeyboardHeight = mediaQuery.viewInsets.bottom;
      widget.keyboardFrameChange?.call();
    }
    final type = ref.watch(chatBottomBarControllerProvider(widget.chatId));
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
                    onTap: () {
                      if (type == ChatBottomBarInputType.voice) {
                        controller.setType(ChatBottomBarInputType.keyboard);
                      } else {
                        controller.setType(ChatBottomBarInputType.voice);
                      }
                    },
                    child: type == ChatBottomBarInputType.voice
                        ? const Icon(LucideIcons.keyboard)
                        : const Icon(LucideIcons.mic),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 6, top: 6),
                      child: type == ChatBottomBarInputType.voice
                          ? voiceTextField()
                          : HomeTextField(
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
                  CommonIconButton(onTap: () {}, child: const Icon(Icons.donut_small)),
                  CommonIconButton(
                    onTap: () {
                      controller.setType(ChatBottomBarInputType.setting);
                    },
                    child: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              Builder(
                builder: (context) {
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
                    height = max(height, 220);
                  }
                  llPrint("type: $type");
                  llPrint("height: $height");
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

  Widget voiceTextField() {
    return GestureDetector(
      onLongPressStart: (details) {
        ref.read(chatDetailVMProvider(widget.chatId).notifier).setIsRecord(true);
        serviceLocator.get<RecordService>().start();
      },
      onLongPressEnd: (details) async {
        ref.read(chatDetailVMProvider(widget.chatId).notifier).setIsRecord(false);
        final path = await serviceLocator.get<RecordService>().stop();
        llPrint("path: $path");
        final recordingState = ref.read(recordingStateProvider);
        if (recordingState == RecordingStateEnum.toText) {
          // 转文本
          llPrint("转文本");
        } else if (recordingState == RecordingStateEnum.cancel) {
          // 取消
          llPrint("取消");
        } else {
          // 发送语音
          llPrint("发送语音");
        }
      },
      onLongPressMoveUpdate: (details) {
        ref.read(recordingStateProvider.notifier).setStateWithPositon(details.globalPosition);
      },
      onTap: () {
        // 占位
        llPrint("onTap");
      },
      child: Container(
        height: 34,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Center(
          child: Text(
            '按住说话',
            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }

  Widget setting() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: lineHeight, color: Colors.grey),
            SizedBox(height: 16),
            Wrap(
              spacing: 40,
              runSpacing: 10,
              children: [
                ItemWidget(title: '照片', icon: LucideIcons.image, onTap: () {}),
                ItemWidget(title: '拍摄', icon: LucideIcons.camera, onTap: () {}),
                ItemWidget(title: '位置', icon: LucideIcons.map_pin, onTap: () {}),
                ItemWidget(title: '语音输入', icon: LucideIcons.mic, onTap: () {}),
                ItemWidget(title: '收藏', icon: LucideIcons.heart, onTap: () {}),
                ItemWidget(title: '个人名片', icon: LucideIcons.user, onTap: () {}),
                ItemWidget(title: '文件', icon: LucideIcons.file, onTap: () {}),
                ItemWidget(title: '音乐', icon: LucideIcons.music, onTap: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
