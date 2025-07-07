class MqttConfig {
  // MQTT 服务器配置
  static const String defaultBroker = 'broker.emqx.io';
  static const int defaultPort = 1883;
  static const String? defaultUsername = null;
  static const String? defaultPassword = null;

  // 连接超时时间
  static const Duration connectionTimeout = Duration(seconds: 30);

  // 重连间隔
  static const Duration reconnectInterval = Duration(seconds: 5);

  // 心跳间隔
  static const Duration keepAliveInterval = Duration(seconds: 60);

  // 是否自动重连
  static const bool autoReconnect = true;

  // 消息质量等级
  static const int qos = 1;

  // 主题前缀
  static const String topicPrefix = 'chat_demo';

  // 获取完整的主题路径
  static String getUserTopic(String userId) {
    return '$topicPrefix/user/$userId/messages';
  }

  static String getRoomTopic(String roomId) {
    return '$topicPrefix/room/$roomId/messages';
  }

  static String getStatusTopic(String userId) {
    return '$topicPrefix/user/$userId/status';
  }

  static String getTypingTopic(String userId) {
    return '$topicPrefix/user/$userId/typing';
  }
}
