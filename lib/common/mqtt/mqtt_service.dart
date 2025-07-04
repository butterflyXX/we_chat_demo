import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// MQTT 服务提供者
final mqttServiceProvider = Provider<MqttService>((ref) {
  return MqttService();
});

// MQTT 连接状态提供者
final mqttConnectionStateProvider =
    StateNotifierProvider<MqttConnectionNotifier, MqttConnectionState>((ref) {
      return MqttConnectionNotifier();
    });

// 消息流提供者
final mqttMessageStreamProvider = StreamProvider<MqttMessageData>((ref) {
  final mqttService = ref.watch(mqttServiceProvider);
  return mqttService.messageStream;
});

// 连接状态管理器
class MqttConnectionNotifier extends StateNotifier<MqttConnectionState> {
  MqttConnectionNotifier() : super(MqttConnectionState.disconnected);

  void setConnectionState(MqttConnectionState newState) {
    state = newState;
  }
}

// MQTT 消息数据类
class MqttMessageData {
  final String topic;
  final String payload;
  final DateTime timestamp;
  final String messageId;

  MqttMessageData({
    required this.topic,
    required this.payload,
    required this.timestamp,
    required this.messageId,
  });

  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
      'payload': payload,
      'timestamp': timestamp.toIso8601String(),
      'messageId': messageId,
    };
  }

  factory MqttMessageData.fromJson(Map<String, dynamic> json) {
    return MqttMessageData(
      topic: json['topic'],
      payload: json['payload'],
      timestamp: DateTime.parse(json['timestamp']),
      messageId: json['messageId'],
    );
  }
}

// MQTT 服务类
class MqttService {
  late MqttServerClient _client;
  final StreamController<MqttMessageData> _messageStreamController =
      StreamController<MqttMessageData>.broadcast();
  final StreamController<MqttConnectionState> _connectionStreamController =
      StreamController<MqttConnectionState>.broadcast();

  // 配置参数
  String _broker = 'broker.emqx.io'; // 免费的公共 MQTT 代理
  int _port = 1883;
  String _clientId = '';
  String _username = '';
  String _password = '';
  String _currentUserId = '';

  // 主题前缀
  static const String _topicPrefix = 'chat_demo';

  // 流
  Stream<MqttMessageData> get messageStream => _messageStreamController.stream;
  Stream<MqttConnectionState> get connectionStream =>
      _connectionStreamController.stream;

  // 初始化 MQTT 客户端
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
    _clientId =
        clientId ?? 'flutter_chat_${DateTime.now().millisecondsSinceEpoch}';
    _username = username ?? _username;
    _password = password ?? _password;
    _currentUserId = userId;

    _client = MqttServerClient(_broker, _clientId);
    _client.port = _port;
    _client.logging(on: kDebugMode);
    _client.keepAlivePeriod = 60;
    _client.connectTimeoutPeriod = 5000;
    _client.autoReconnect = true;

    // 设置回调
    _client.onConnected = _onConnected;
    _client.onDisconnected = _onDisconnected;
    _client.onUnsubscribed = _onUnsubscribed;
    _client.onSubscribed = _onSubscribed;
    _client.onSubscribeFail = _onSubscribeFail;
    _client.onAutoReconnect = _onAutoReconnect;
    _client.onAutoReconnected = _onAutoReconnected;

    // 设置连接消息
    final connMessage = MqttConnectMessage()
        .withClientIdentifier(_clientId)
        .withWillTopic('$_topicPrefix/status/$_currentUserId')
        .withWillMessage('offline')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    if (_username.isNotEmpty) {
      connMessage.authenticateAs(_username, _password);
    }

    _client.connectionMessage = connMessage;
  }

  // 连接到 MQTT 代理
  Future<bool> connect() async {
    try {
      _connectionStreamController.add(MqttConnectionState.connecting);

      final status = await _client.connect();

      if (status?.state == MqttConnectionState.connected) {
        _connectionStreamController.add(MqttConnectionState.connected);

        // 监听消息
        _client.updates?.listen(_onMessage);

        // 订阅用户相关主题
        await _subscribeToUserTopics();

        // 发布用户在线状态
        await _publishUserStatus('online');

        return true;
      } else {
        _connectionStreamController.add(MqttConnectionState.faulted);
        return false;
      }
    } catch (e) {
      debugPrint('MQTT 连接失败: $e');
      _connectionStreamController.add(MqttConnectionState.faulted);
      return false;
    }
  }

  // 断开连接
  Future<void> disconnect() async {
    try {
      _connectionStreamController.add(MqttConnectionState.disconnecting);

      // 发布用户离线状态
      await _publishUserStatus('offline');

      _client.disconnect();
    } catch (e) {
      debugPrint('MQTT 断开连接失败: $e');
    }
  }

  // 发送消息
  Future<void> sendMessage({
    required String receiverId,
    required String content,
    required String messageType,
    String? roomId,
    Map<String, dynamic>? extra,
  }) async {
    if (_client.connectionStatus?.state != MqttConnectionState.connected) {
      throw Exception('MQTT 未连接');
    }

    final messageId = 'msg_${DateTime.now().millisecondsSinceEpoch}';
    final message = {
      'id': messageId,
      'senderId': _currentUserId,
      'receiverId': receiverId,
      'content': content,
      'messageType': messageType,
      'timestamp': DateTime.now().toIso8601String(),
      'roomId': roomId,
      'extra': extra ?? {},
    };

    final topic = roomId != null
        ? '$_topicPrefix/room/$roomId/messages'
        : '$_topicPrefix/user/$receiverId/messages';

    final builder = MqttClientPayloadBuilder();
    builder.addString(jsonEncode(message));

    _client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }

  // 订阅聊天室
  Future<void> subscribeToRoom(String roomId) async {
    if (_client.connectionStatus?.state != MqttConnectionState.connected) {
      return;
    }

    final topics = [
      '$_topicPrefix/room/$roomId/messages',
      '$_topicPrefix/room/$roomId/events',
    ];

    for (final topic in topics) {
      _client.subscribe(topic, MqttQos.atLeastOnce);
    }
  }

  // 取消订阅聊天室
  Future<void> unsubscribeFromRoom(String roomId) async {
    if (_client.connectionStatus?.state != MqttConnectionState.connected) {
      return;
    }

    final topics = [
      '$_topicPrefix/room/$roomId/messages',
      '$_topicPrefix/room/$roomId/typing',
      '$_topicPrefix/room/$roomId/read',
      '$_topicPrefix/room/$roomId/events',
    ];

    for (final topic in topics) {
      _client.unsubscribe(topic);
    }
  }

  // 订阅用户主题
  Future<void> _subscribeToUserTopics() async {
    final topics = [
      '$_topicPrefix/user/$_currentUserId/messages',
      '$_topicPrefix/user/$_currentUserId/typing',
      '$_topicPrefix/user/$_currentUserId/read',
      '$_topicPrefix/user/$_currentUserId/events',
      '$_topicPrefix/broadcast/messages',
      '$_topicPrefix/broadcast/events',
    ];

    for (final topic in topics) {
      _client.subscribe(topic, MqttQos.atLeastOnce);
    }
  }

  // 发布用户状态
  Future<void> _publishUserStatus(String status) async {
    if (_client.connectionStatus!.state != MqttConnectionState.connected) {
      return;
    }

    final message = {
      'userId': _currentUserId,
      'status': status,
      'timestamp': DateTime.now().toIso8601String(),
    };

    final topic = '$_topicPrefix/status/$_currentUserId';
    final builder = MqttClientPayloadBuilder();
    builder.addString(jsonEncode(message));

    _client.publishMessage(
      topic,
      MqttQos.atLeastOnce,
      builder.payload!,
      retain: true,
    );
  }

  // 消息处理
  void _onMessage(List<MqttReceivedMessage<MqttMessage>> messages) {
    for (final message in messages) {
      final topic = message.topic;
      final payload = MqttPublishPayload.bytesToStringAsString(
        (message.payload as MqttPublishMessage).payload.message,
      );

      final messageData = MqttMessageData(
        topic: topic,
        payload: payload,
        timestamp: DateTime.now(),
        messageId: 'received_${DateTime.now().millisecondsSinceEpoch}',
      );

      _messageStreamController.add(messageData);
    }
  }

  // 连接回调
  void _onConnected() {
    debugPrint('MQTT 连接成功');
    _connectionStreamController.add(MqttConnectionState.connected);
  }

  void _onDisconnected() {
    debugPrint('MQTT 连接断开');
    _connectionStreamController.add(MqttConnectionState.disconnected);
  }

  void _onSubscribed(String topic) {
    debugPrint('订阅成功: $topic');
  }

  void _onSubscribeFail(String topic) {
    debugPrint('订阅失败: $topic');
  }

  void _onUnsubscribed(String? topic) {
    debugPrint('取消订阅: $topic');
  }

  void _onAutoReconnect() {
    debugPrint('MQTT 自动重连中...');
    _connectionStreamController.add(MqttConnectionState.connecting);
  }

  void _onAutoReconnected() {
    debugPrint('MQTT 自动重连成功');
    _connectionStreamController.add(MqttConnectionState.connected);
  }

  // 销毁资源
  void dispose() {
    _messageStreamController.close();
    _connectionStreamController.close();
    _client.disconnect();
  }
}
