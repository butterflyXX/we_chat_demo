import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mqtt_service.dart';

// 聊天管理器提供者
final chatManagerProvider = Provider<ChatManager>((ref) {
  return ChatManager(ref);
});

// 聊天消息类
class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final String messageType;
  final DateTime timestamp;
  final bool isRead;
  final String senderName;
  final String senderAvatar;
  final String? roomId;
  final Map<String, dynamic> extra;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.messageType,
    required this.timestamp,
    this.isRead = false,
    this.senderName = '',
    this.senderAvatar = '',
    this.roomId,
    this.extra = const {},
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      content: json['content'],
      messageType: json['messageType'],
      timestamp: DateTime.parse(json['timestamp']),
      isRead: json['isRead'] ?? false,
      senderName: json['senderName'] ?? '',
      senderAvatar: json['senderAvatar'] ?? '',
      roomId: json['roomId'],
      extra: Map<String, dynamic>.from(json['extra'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'messageType': messageType,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'senderName': senderName,
      'senderAvatar': senderAvatar,
      'roomId': roomId,
      'extra': extra,
    };
  }
}

// 聊天管理器
class ChatManager {
  final Ref ref;
  late final MqttService _mqttService;
  late StreamSubscription _messageSubscription;

  final Map<String, List<ChatMessage>> _messageCache = {};
  String _currentUserId = '';

  ChatManager(this.ref) {
    _mqttService = ref.read(mqttServiceProvider);
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
    String? roomId,
    Map<String, dynamic>? extra,
  }) async {
    await _mqttService.sendMessage(
      receiverId: receiverId,
      content: content,
      messageType: messageType,
      roomId: roomId,
      extra: extra,
    );
  }

  // 处理 MQTT 消息
  void _handleMqttMessage(MqttMessageData messageData) {
    try {
      final payload = jsonDecode(messageData.payload) as Map<String, dynamic>;
      final topic = messageData.topic;

      if (topic.contains('/messages')) {
        _handleChatMessage(payload, topic);
      }
    } catch (e) {
      debugPrint('处理 MQTT 消息失败: $e');
    }
  }

  // 处理聊天消息
  void _handleChatMessage(Map<String, dynamic> payload, String topic) {
    final message = ChatMessage.fromJson(payload);

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
  List<ChatMessage> getCachedMessages(String chatId) {
    return _messageCache[chatId] ?? [];
  }

  // 清理资源
  void dispose() {
    _messageSubscription.cancel();
    _mqttService.dispose();
    _messageCache.clear();
  }
}
