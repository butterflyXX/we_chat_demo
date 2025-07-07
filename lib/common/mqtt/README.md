# MQTT 连接状态管理优化

## 改进说明

### 问题
之前每个聊天页面都在本地状态（`MqttChatState`）中维护自己的 `isConnected` 字段，这违反了单一数据源原则。

### 解决方案
将 MQTT 连接状态提升为全局状态，所有组件共享同一个连接状态。

## 架构改进

### 1. 全局连接状态管理
```dart
// 原始连接状态
final mqttConnectionStateProvider = StateNotifierProvider<MqttConnectionNotifier, MqttConnectionState>(...);

// 计算型提供者 - 返回简单的布尔值
final mqttIsConnectedProvider = Provider<bool>((ref) {
  final connectionState = ref.watch(mqttConnectionStateProvider);
  return connectionState == MqttConnectionState.connected;
});
```

### 2. 本地状态简化
```dart
// 移除前
class MqttChatState {
  final List<ChatMessage> messages;
  final bool isConnected;  // ❌ 删除这个字段
  final bool isLoading;
  // ...
}

// 移除后
class MqttChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  // ...
}
```

### 3. 组件中的使用
```dart
class MqttChatPage extends ConsumerStatefulWidget {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mqttChatPageProvider(widget.chatId));
    final isConnected = ref.watch(mqttIsConnectedProvider); // ✅ 从全局状态读取
    
    // 使用 isConnected 变量...
  }
}
```

## 优势

### 1. 单一数据源
- MQTT 连接状态只在一个地方管理
- 避免状态不一致的问题
- 更容易调试和维护

### 2. 性能优化
- 减少不必要的状态复制
- 状态变化时自动更新所有相关组件
- 避免手动同步状态

### 3. 代码简化
- 减少样板代码
- 更清晰的组件职责分离
- 易于测试

### 4. 可扩展性
- 新增使用连接状态的组件时更简单
- 连接状态逻辑集中管理
- 便于添加更多连接相关功能

## 使用指南

### 在任何组件中读取连接状态
```dart
// 在 ConsumerWidget 或 ConsumerStatefulWidget 中
final isConnected = ref.watch(mqttIsConnectedProvider);

// 在 StateNotifier 中
final isConnected = ref.read(mqttIsConnectedProvider);
```

### 监听连接状态变化
```dart
ref.listen(mqttIsConnectedProvider, (previous, next) {
  if (next) {
    print('MQTT 已连接');
  } else {
    print('MQTT 已断开');
  }
});
```

### 在业务逻辑中使用
```dart
// 发送消息前检查连接状态
Future<void> sendMessage(String content) async {
  final isConnected = ref.read(mqttIsConnectedProvider);
  if (!isConnected) return;
  
  // 发送消息逻辑...
}
```

## 最佳实践

### 1. 状态层级
- 全局状态：连接状态、用户信息
- 页面状态：消息列表、UI状态
- 组件状态：输入框内容、滚动位置

### 2. Provider 类型选择
- `StateNotifierProvider`: 可变状态管理
- `Provider`: 计算型状态（如 isConnected）
- `StreamProvider`: 异步数据流

### 3. 状态读取
- `ref.watch()`: 监听状态变化并重建UI
- `ref.read()`: 一次性读取状态值
- `ref.listen()`: 监听状态变化执行副作用

## 扩展功能

### 1. 连接质量指示
```dart
final mqttConnectionQualityProvider = Provider<ConnectionQuality>((ref) {
  final state = ref.watch(mqttConnectionStateProvider);
  // 根据连接状态返回连接质量
});
```

### 2. 重连逻辑
```dart
final mqttAutoReconnectProvider = Provider<bool>((ref) {
  final isConnected = ref.watch(mqttIsConnectedProvider);
  // 自动重连逻辑
});
```

### 3. 连接历史
```dart
final mqttConnectionHistoryProvider = StateNotifierProvider<...>((ref) {
  // 记录连接历史
});
```

这种架构更符合 Flutter 和 Riverpod 的最佳实践，提供了更好的可维护性和可扩展性。 