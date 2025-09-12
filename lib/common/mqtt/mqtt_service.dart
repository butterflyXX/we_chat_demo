import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/mqtt/message_info.dart';
import 'package:chat_demo/common/services/record_service.dart';
import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'mqtt_service.g.dart';

// MQTT 服务提供者
@Riverpod(keepAlive: true)
class MqttServiceNotifier extends _$MqttServiceNotifier {
  //======================== 基础字段 ========================
  late MqttServerClient _client;
  final StreamController<MqttMessageData> _messageStreamController = StreamController<MqttMessageData>.broadcast();

  // 配置参数
  String _broker = 'broker.emqx.io';
  int _port = 1883;
  String _clientId = '';
  String _username = '';
  String _password = '';
  String _currentUserId = '';

  // 主题前缀
  static const String _topicPrefix = 'chat_demo';

  //======================== Riverpod build ==================
  @override
  MqttServiceNotifier build() {
    // 返回自身，方便外部直接调用方法。
    return this;
  }

  //======================== 对外暴露 ========================
  Stream<MqttMessageData> get messageStream => _messageStreamController.stream;

  // 初始化客户端（不自动连接）
  Future<void> initialize({
    String? broker,
    int? port,
    String? clientId,
    String? username,
    String? password,
    required String userId,
  }) async {
    _broker = broker ?? _broker;
    _port = port ?? _port;
    _clientId = clientId ?? 'flutter_chat_${DateTime.now().millisecondsSinceEpoch}';
    _username = username ?? _username;
    _password = password ?? _password;
    _currentUserId = userId;

    _client = MqttServerClient(_broker, _clientId);
    _client.port = _port;
    _client.logging(on: kDebugMode);
    _client.keepAlivePeriod = 60;
    _client.connectTimeoutPeriod = 5000;
    _client.autoReconnect = true;

    // 绑定回调
    _client
      ..onConnected = _onConnected
      ..onDisconnected = _onDisconnected
      ..onUnsubscribed = _onUnsubscribed
      ..onSubscribed = _onSubscribed
      ..onSubscribeFail = _onSubscribeFail
      ..onAutoReconnect = _onAutoReconnect
      ..onAutoReconnected = _onAutoReconnected;

    final connMessage = MqttConnectMessage().withClientIdentifier(_clientId);
    if (_username.isNotEmpty) {
      connMessage.authenticateAs(_username, _password);
    }
    _client.connectionMessage = connMessage;
  }

  // 连接到 MQTT 服务器
  Future<bool> connect() async {
    try {
      _setConnectionState(MqttConnectionState.connecting);
      final status = await _client.connect();
      if (status?.state == MqttConnectionState.connected) {
        _setConnectionState(MqttConnectionState.connected);
        // 监听消息
        _client.updates?.listen(_onMessage);
        // 订阅当前用户主题
        await _subscribeToUserTopics();
        return true;
      } else {
        _setConnectionState(MqttConnectionState.faulted);
        return false;
      }
    } catch (e) {
      _setConnectionState(MqttConnectionState.faulted);
      return false;
    }
  }

  // 断开连接
  Future<void> disconnect() async {
    try {
      _setConnectionState(MqttConnectionState.disconnecting);
      _client.disconnect();
    } catch (e) {
      debugPrint('MQTT 断开连接失败: $e');
    }
  }

  // 发送消息
  Future<void> sendMessage({required String receiverId, required String content, required String messageType}) async {
    if (_client.connectionStatus?.state != MqttConnectionState.connected) {
      throw Exception('MQTT 未连接');
    }

    final messageId = Uuid().v4();
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    if (messageType == 'voice') {
      // 语音消息：分步传输
      final localPath = content;
      try {
        final file = File(localPath);
        if (await file.exists()) {
          // 1. 先发送快速通知（包含元数据，不含音频数据）
          final quickMessage = {
            'messageId': messageId,
            'senderId': _currentUserId,
            'receiverId': receiverId,
            'timestamp': timestamp,
            'messageType': 'voice_notify', // 新类型
          };

          // 立即发送通知消息
          final topic = '$_topicPrefix/user/$receiverId/messages';
          final quickBuilder = MqttClientPayloadBuilder()..addUTF8String(jsonEncode(quickMessage));
          _client.publishMessage(topic, MqttQos.atLeastOnce, quickBuilder.payload!);

          // 本地缓存快速通知
          _cacheMessage(
            receiverId,
            MessageInfo(
              messageId: messageId,
              senderId: _currentUserId,
              receiverId: receiverId,
              content: localPath,
              timestamp: timestamp,
              messageType: 'voice_notify',
            ),
          );

          // 2. 异步发送音频数据
          Future(() async {
            try {
              final bytes = await file.readAsBytes();
              final audioMessage = {
                'messageId': messageId, // 相同ID
                'senderId': _currentUserId,
                'receiverId': receiverId,
                'content': base64Encode(bytes),
                'timestamp': timestamp,
                'messageType': 'voice_data',
              };

              final audioBuilder = MqttClientPayloadBuilder()..addUTF8String(jsonEncode(audioMessage));
              _client.publishMessage(topic, MqttQos.atLeastOnce, audioBuilder.payload!);

              debugPrint('语音数据发送完成: $messageId');
            } catch (e) {
              debugPrint('语音数据发送失败: $e');
            }
          });
        }
      } catch (e) {
        debugPrint('MQTT voice pack failed: $e');
      }
    } else {
      // 文本等其他类型：直接发送
      final message = {
        'messageId': messageId,
        'senderId': _currentUserId,
        'receiverId': receiverId,
        'content': content,
        'timestamp': timestamp,
        'messageType': messageType,
      };

      _cacheMessage(receiverId, MessageInfo.fromJson(message));

      final topic = '$_topicPrefix/user/$receiverId/messages';
      final builder = MqttClientPayloadBuilder()..addUTF8String(jsonEncode(message));
      _client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    }
  }

  //======================== 内部方法 ========================
  Future<void> _subscribeToUserTopics() async {
    final topic = '$_topicPrefix/user/$_currentUserId/messages';
    _client.subscribe(topic, MqttQos.atLeastOnce);
  }

  void _onMessage(List<MqttReceivedMessage<MqttMessage>> messages) {
    for (final msg in messages) {
      final publish = msg.payload as MqttPublishMessage;
      final payloadStr = MqttPublishPayload.bytesToStringAsString(publish.payload.message);
      try {
        final map = jsonDecode(payloadStr) as Map<String, dynamic>;
        final messageType = (map['messageType'] as String?) ?? 'text';

        if (messageType == 'voice_notify') {
          // 语音通知：立即显示，等待音频数据
          final info = MessageInfo(
            messageId: map['messageId'] as String,
            senderId: map['senderId'] as String,
            receiverId: map['receiverId'] as String,
            content: '', // 显示占位符
            timestamp: (map['timestamp'] as num).toInt(),
            messageType: 'voice_notify',
          );
          _cacheMessage(info.senderId, info);
        } else if (messageType == 'voice_data') {
          // 语音数据：解码并保存到本地文件，然后更新现有消息
          final contentStr = map['content'] as String;
          final bytes = base64Decode(contentStr);

          final messageId = map['messageId'] as String;
          final senderId = map['senderId'] as String;
          final receiverId = map['receiverId'] as String;
          final timestamp = (map['timestamp'] as num).toInt();

          // 落盘到本地文件，然后更新现有的 MessageInfo
          Future(() async {
            try {
              final filePath = await ChatRecordService.createRecordPath();
              await File(filePath).writeAsBytes(bytes);

              // 更新为完整的语音消息（不重复添加，而是更新）
              final updatedInfo = MessageInfo(
                messageId: messageId,
                senderId: senderId,
                receiverId: receiverId,
                content: filePath, // 本地路径
                timestamp: timestamp,
                messageType: 'voice', // 最终类型
              );

              // 直接发送更新事件，让接收方知道这是更新操作
              _messageStreamController.add(MqttMessageData(chatId: senderId, messageInfo: updatedInfo));

              debugPrint('语音数据接收完成: $messageId -> $filePath');
            } catch (e) {
              debugPrint('语音数据保存失败: $e');
            }
          });
        } else {
          // 文本等其他类型：直接转 Domain
          final info = MessageInfo.fromJson(map);
          _cacheMessage(info.senderId, info);
        }
      } catch (e) {
        debugPrint('解析消息失败: $e');
      }
    }
  }

  void _cacheMessage(String chatId, MessageInfo msg) {
    _messageStreamController.add(MqttMessageData(chatId: chatId, messageInfo: msg));
  }

  //----------- 各类回调 -------------
  void _onConnected() => _setConnectionState(MqttConnectionState.connected);
  void _onDisconnected() => _setConnectionState(MqttConnectionState.disconnected);
  void _onSubscribed(String topic) => debugPrint('订阅成功: $topic');
  void _onSubscribeFail(String topic) => debugPrint('订阅失败: $topic');
  void _onUnsubscribed(String? topic) => debugPrint('取消订阅: $topic');
  void _onAutoReconnect() => _setConnectionState(MqttConnectionState.connecting);
  void _onAutoReconnected() => _setConnectionState(MqttConnectionState.connected);

  void _setConnectionState(MqttConnectionState state) {
    llPrint('MQTT 连接状态: $state');
    ref.read(mqttConnectionNotifierProvider.notifier).setConnectionState(state);
  }
}

// MQTT 连接状态提供者
@Riverpod(keepAlive: true)
class MqttConnectionNotifier extends _$MqttConnectionNotifier {
  @override
  MqttConnectionState build() => MqttConnectionState.disconnected;

  void setConnectionState(MqttConnectionState newState) {
    state = newState;
  }
}
