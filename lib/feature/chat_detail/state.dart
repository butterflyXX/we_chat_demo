import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/mqtt/chat_manager.dart';
import 'package:chat_demo/common/mqtt/mqtt_service.dart';
import 'package:chat_demo/common/user_info/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';
part 'state.freezed.dart';

@riverpod
class ChatDetailVM extends _$ChatDetailVM {
  final ScrollController controller = ScrollController();
  late final _chatManager = ref.read(chatManagerProvider);

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
  }

  void hasFocus(bool hasFocus) {}

  void setCanScroll(bool canScroll) {
    state = state.copyWith(canScroll: canScroll);
  }

  void _initialize() async {
    // 监听新消息
    _listenToMessages();
    // 加载缓存的消息
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadMessages();
    });
  }

  void _loadMessages() {
    final cachedMessages = _chatManager.getCachedMessages(chatId);
    if (cachedMessages.isEmpty) {
      return;
    }
    // 按时间排序，最新消息在最下面
    cachedMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    state = state.copyWith(messages: cachedMessages);
  }

  // 监听新消息并更新状态
  void _listenToMessages() {
    final userId = ref.read(userInfoNotifierProvider)!.id;
    final subscription = ref
        .read(mqttServiceNotifierProvider)
        .messageStream
        .listen(
          (messageData) {
            llPrint('messageData.topic: ${messageData.topic}');
            llPrint('chatId: $userId');
            if (messageData.topic.contains(userId)) {
              llPrint('messageData.topic');
              _loadMessages();
              scrollToBottom(true, true);
            }
          },
          onError: (error) {
            llPrint("Error in message stream: $error");
          },
          cancelOnError: false,
        );
    ref.onDispose(() {
      llPrint('Cancelling message stream subscription');
      subscription.cancel();
    });
  }

  // 发送消息
  Future<void> sendMessage(String content) async {
    final isConnected =
        ref.read(mqttServiceNotifierProvider).connectionState.value ==
        MqttConnectionState.connected;
    if (content.trim().isEmpty || isConnected) return;
    try {
      await _chatManager.sendMessage(
        receiverId: chatId,
        content: content.trim(),
        messageType: 'text',
      );
    } catch (e) {
      // 显示错误
      debugPrint('发送消息失败: $e');
    }
    scrollToBottom(true, true);
  }
}

@freezed
abstract class ChatDetailState with _$ChatDetailState {
  const factory ChatDetailState({
    @Default(true) bool canScroll,
    @Default([]) List<ChatMessage> messages,
  }) = _ChatDetailState;
}
