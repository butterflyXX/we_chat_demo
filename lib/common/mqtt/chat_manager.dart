import 'dart:async';
import 'package:chat_demo/common/mqtt/message_info.dart';
import 'package:chat_demo/common/providers/user_list.dart';
import 'package:chat_demo/common/user_info/user_info.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'mqtt_service.dart';
import 'package:chat_demo/common/data_base/data_base_service.dart';
import 'package:chat_demo/common/data_base/database.dart';

part 'chat_manager.g.dart';

// 聊天管理器提供者
@Riverpod(keepAlive: true)
class ChatManager extends _$ChatManager {
  late final _mqttService = ref.read(mqttServiceNotifierProvider);

  late final _dbService = ref.read(dataBaseServiceProvider.notifier);

  @override
  Map<String, List<MessageInfo>> build() {
    final subscription = _mqttService.messageStream.listen(_handleMqttMessage);
    ref.onDispose(subscription.cancel);
    return {};
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
    initCacheFromDb();
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

  // 从数据库初始化消息缓存
  Future<void> initCacheFromDb() async {
    final dbMessages = await _dbService.getMessages();
    final Map<String, List<MessageInfo>> _messageCache = {};
    for (final msg in dbMessages) {
      // 组装 MessageInfo
      final messageInfo = MessageInfo(
        messageId: msg.messageId,
        senderId: msg.senderId,
        receiverId: msg.receiverId,
        content: msg.content,
        timestamp: msg.timestamp,
      );
      // 确定聊天ID
      String chatId = _chatId(messageInfo);
      _messageCache.putIfAbsent(chatId, () => []);
      _messageCache[chatId]!.add(messageInfo);
    }
    // 按时间排序
    for (final list in _messageCache.values) {
      list.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    }
    state = _messageCache;
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
    String chatId = _chatId(message);
    List<MessageInfo> list = [...(state[chatId] ?? []), message];
    state = {...state, chatId: list};

    _insertMessage(message);

    _updateUserInfo(message);
    
  }

  void _insertMessage(MessageInfo message) {
    _dbService.insertOrUpdateMessage(
      MessageTableCompanion.insert(
        loginUserId: ref.read(userInfoNotifierProvider)!.id,
        messageId: message.messageId,
        senderId: message.senderId,
        receiverId: message.receiverId,
        content: message.content,
        messageType: 'text',
        timestamp: message.timestamp,
      ),
    );
  }

  // 更新当前用户的 lastMessage 字段
  void _updateUserInfo(MessageInfo message) async {
    await _dbService.updateUser(_chatId(message), onGetChangeValue: () {
      return UserTableInfoCompanion(
        createdAt: Value(message.timestamp),
        lastMessage: Value(message.content),
      );
    });

    ref.read(userListProvider.notifier).reloadData();
  }

  // 断开MQTT连接
  Future<void> disconnect() async {
    await _mqttService.disconnect();
  }

  String _chatId(MessageInfo message) {
    final currentUserId = ref.read(userInfoNotifierProvider)!.id;
    return message.getChatId(currentUserId);
  }

  // 清理资源
  void dispose() {
    state = {};
  }
}
