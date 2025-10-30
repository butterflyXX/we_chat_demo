import 'package:chat_demo/common/chat_ai/chat_ai_service.dart';
import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/mqtt/chat_manager.dart';
import 'package:chat_demo/common/mqtt/mqtt_service.dart';
import 'package:chat_demo/common/services/setting_service.dart';
import 'package:chat_demo/common/user_info/user_info.dart';
import 'package:chat_demo/feature/chat_detail/widget/chat_bottom_bar/chat_bottom_bar_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';
part 'state.freezed.dart';

@riverpod
class ChatDetailVM extends _$ChatDetailVM {
  final ScrollController controller = ScrollController();
  late final _chatManager = ref.read(chatManagerProvider.notifier);

  @override
  ChatDetailState build(String chatId) {
    _initialize();
    return const ChatDetailState();
  }

  void scrollToBottom(bool animation, bool nextFrame) {
    void anim() {
      if (animation) {
        controller.animateTo(
          controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
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

  void hasFocus(bool hasFocus) {
    if (_isExternalKeyboardHide(hasFocus)) {
      unfocus();
    }
  }

  void setCanScroll(bool canScroll) {
    state = state.copyWith(canScroll: canScroll);
  }

  void setIsRecord(bool isRecord) {
    state = state.copyWith(isRecord: isRecord);
  }

  void _initialize() async {
    // 监听新消息
    _listenToMessages();
    scrollToBottom(false, true);
    final subscription = ref.listen(chatBottomBarControllerProvider(chatId), (oldValue, newValue) {
      setCanScroll(newValue == ChatBottomBarInputType.normal);
      if (newValue != ChatBottomBarInputType.keyboard) {
        cancelKeyBoard();
      }
    });
    ref.onDispose(() {
      subscription.close();
    });
  }

  // 监听新消息并更新状态
  void _listenToMessages() {
    final subscription = ref.listen(chatManagerProvider, (oldValue, newValue) {
      scrollToBottom(true, true);
    });
    ref.onDispose(() {
      llPrint('Cancelling message stream subscription');
      subscription.close();
    });
  }

  // 发送消息
  Future<void> sendMessage(String content) async {
    final isConnected = ref.read(mqttConnectionNotifierProvider) == MqttConnectionState.connected;
    if (content.trim().isEmpty || !isConnected) return;
    try {
      await _chatManager.sendMessage(receiverId: chatId, content: content.trim());
      if (ref.read(settingServiceProvider).userChatAi) {
        await sendChatAiMessage(content);
      }
    } catch (e) {
      // 显示错误
      debugPrint('发送消息失败: $e');
    }
    scrollToBottom(true, true);
  }

  // 发送语音消息
  Future<void> sendVoice(String audioFilePath) async {
    final isConnected = ref.read(mqttConnectionNotifierProvider) == MqttConnectionState.connected;
    if (!isConnected) {
      debugPrint('MQTT 未连接，无法发送语音消息');
      return;
    }

    try {
      // 使用 ChatManager 的 sendVoiceMessage 方法
      await _chatManager.sendVoiceMessage(receiverId: chatId, audioFilePath: audioFilePath);

      llPrint('语音消息发送成功，文件保留: $audioFilePath');

      // 滚动到底部
      scrollToBottom(true, true);
    } catch (e) {
      debugPrint('发送语音消息失败: $e');
    }
  }

  Future<void> sendChatAiMessage(String content) async {
    await ref.read(chatAiServiceProvider.notifier).sendMessage(content, ref.read(userInfoNotifierProvider)!.id, chatId);
  }

  void unfocus() {
    ref.read(chatBottomBarControllerProvider(chatId).notifier).setType(ChatBottomBarInputType.normal);
  }

  bool _isExternalKeyboardHide(bool hasFocus) {
    final type = ref.read(chatBottomBarControllerProvider(chatId));
    return !hasFocus && type == ChatBottomBarInputType.keyboard;
  }
}

@freezed
abstract class ChatDetailState with _$ChatDetailState {
  const factory ChatDetailState({@Default(true) bool canScroll, @Default(false) bool isRecord}) = _ChatDetailState;
}
