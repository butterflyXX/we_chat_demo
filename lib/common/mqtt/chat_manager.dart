import 'dart:async';
import 'dart:convert';
import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/data_base/database.dart';
import 'package:chat_demo/common/mqtt/message_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mqtt_service.dart';

// 聊天管理器提供者
final chatManagerProvider = Provider<ChatManager>((ref) {
  return ChatManager(ref);
});

// 聊天管理器
class ChatManager {
  final Ref ref;
  late final MqttService _mqttService;
  late StreamSubscription _messageSubscription;

  final Map<String, List<MessageInfo>> _messageCache = {};
  String _currentUserId = '';

  ChatManager(this.ref) {
    _mqttService = ref.read(mqttServiceNotifierProvider);
    _initialize();
  }

  void _initialize() {
    _messageSubscription = _mqttService.messageStream.listen(
      _handleMqttMessage,
    );
  }

  // 初始化聊天管理器
  Future<void> initialize({
    required String userId,
    required String userName,
    required String userAvatar,
    String? broker,
    int? port,
    String? username,
    String? password,
  }) async {
    _currentUserId = userId;

    await _mqttService.initialize(
      userId: userId,
      broker: broker,
      port: port,
      username: username,
      password: password,
    );
  }

  // 连接到 MQTT 服务器
  Future<bool> connect() async {
    return await _mqttService.connect();
  }

  // 发送消息
  Future<void> sendMessage({
    required String receiverId,
    required String content,
    String messageType = 'text',
  }) async {
    await _mqttService.sendMessage(
      receiverId: receiverId,
      content: content,
      messageType: messageType,
    );
  }

  // 处理 MQTT 消息
  void _handleMqttMessage(MqttMessageData messageData) {
    try {
      _handleChatMessage(messageData.messageInfo);
    } catch (e) {
      debugPrint('处理 MQTT 消息失败: $e');
    }
  }

  // 处理聊天消息
  void _handleChatMessage(MessageInfo message) {

    // 确定聊天 ID
    String chatId = message.senderId == _currentUserId
        ? message.receiverId
        : message.senderId;

    if (!_messageCache.containsKey(chatId)) {
      _messageCache[chatId] = [];
    }

    _messageCache[chatId]!.add(message);

    // 按时间排序
    _messageCache[chatId]!.sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  // 获取缓存的消息
  List<MessageInfo> getCachedMessages(String chatId) {
    return _messageCache[chatId] ?? [];
  }

  // 断开MQTT连接
  Future<void> disconnect() async {
    await _mqttService.disconnect();
  }

  // 清理资源
  void dispose() {
    _mqttService.dispose();
    _messageCache.clear();
  }
}
