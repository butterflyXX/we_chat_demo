import 'dart:async';
import 'dart:convert';
import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/mqtt/message_info.dart';
import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'mqtt_service.g.dart';

// MQTT 服务提供者
@Riverpod(keepAlive: true)
class MqttServiceNotifier extends _$MqttServiceNotifier {
  @override
  MqttService build() {
    return MqttService();
  }

  MqttConnectionState get connectionState => state.connectionState.value;
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

// MQTT 服务类
class MqttService {
  late MqttServerClient _client;
  final StreamController<MqttMessageData> _messageStreamController =
      StreamController<MqttMessageData>.broadcast();

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
  ValueNotifier<MqttConnectionState> connectionState = ValueNotifier(MqttConnectionState.disconnected);

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
    final connMessage = MqttConnectMessage().withClientIdentifier(_clientId);

    if (_username.isNotEmpty) {
      connMessage.authenticateAs(_username, _password);
    }

    _client.connectionMessage = connMessage;
  }

  // 连接到 MQTT 代理
  Future<bool> connect() async {
    try {
      _setConnectionState(MqttConnectionState.connecting);

      final status = await _client.connect();

      if (status?.state == MqttConnectionState.connected) {
        _setConnectionState(MqttConnectionState.connected);

        // 监听消息
        _client.updates?.listen(_onMessage);

        // 订阅用户相关主题
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
  Future<void> sendMessage({
    required String receiverId,
    required String content,
    required String messageType,
  }) async {
    if (_client.connectionStatus?.state != MqttConnectionState.connected) {
      throw Exception('MQTT 未连接');
    }

    final message = {
      'messageId': Uuid().v4(),
      'senderId': _currentUserId,
      'receiverId': receiverId,
      'content': content,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };

    final topic = '$_topicPrefix/user/$receiverId/messages';

    final builder = MqttClientPayloadBuilder();

    builder.addUTF8String(jsonEncode(message));

    _client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);

    _cacheMessage(receiverId, MessageInfo.fromJson(message));
  }

  // 订阅用户主题
  Future<void> _subscribeToUserTopics() async {
    final topics = [
      '$_topicPrefix/user/$_currentUserId/messages',
    ];

    for (final topic in topics) {
      _client.subscribe(topic, MqttQos.atLeastOnce);
    }
  }

  // 消息处理
  void _onMessage(List<MqttReceivedMessage<MqttMessage>> messages) {
    for (final message in messages) {
      final payload = MqttPublishPayload.bytesToStringAsString(
        (message.payload as MqttPublishMessage).payload.message,
      );

      final messageInfo = MessageInfo.fromJson(jsonDecode(payload));

      _cacheMessage(messageInfo.senderId, MessageInfo.fromJson(jsonDecode(payload)));
    }
  }

  void _cacheMessage(String chatId, MessageInfo message) {
    final messageData = MqttMessageData(
      chatId: chatId,
      messageInfo: message,
    );
    _messageStreamController.add(messageData);
  }

  // 连接回调
  void _onConnected() {
    _setConnectionState(MqttConnectionState.connected);
  }

  void _onDisconnected() {
    _setConnectionState(MqttConnectionState.disconnected);
  }

  void _setConnectionState(MqttConnectionState state) {
    llPrint('MQTT 连接状态: $state');
    connectionState.value = state;
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
    _setConnectionState(MqttConnectionState.connecting);
  }

  void _onAutoReconnected() {
    _setConnectionState(MqttConnectionState.connected);
  }
}
