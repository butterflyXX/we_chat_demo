# MQTT 即时通信功能使用说明

## 概述

本项目集成了 MQTT 协议来实现即时通信功能，支持实时消息传递、在线状态同步、消息排序等功能。

## 主要功能

### 1. 实时消息传递
- 基于 MQTT 协议的低延迟消息传递
- 支持文本、图片、语音等多种消息类型
- 消息可靠性保证（QoS 级别控制）

### 2. 消息排序机制
- **时间排序**：所有消息按时间戳自动排序
- **最新消息置顶**：当用户发送新消息时，该对话自动排到聊天列表最上方
- **未读消息优先**：有未读消息的对话会优先显示

### 3. 在线状态同步
- 实时显示用户在线/离线状态
- 支持打字状态指示
- 最后在线时间同步

### 4. 消息状态管理
- 消息发送状态（发送中、已发送、已送达、已读）
- 自动标记消息为已读
- 未读消息计数

## 核心组件

### 1. MqttService (lib/common/services/mqtt_service.dart)
MQTT 客户端核心服务，负责：
- MQTT 连接管理
- 消息发布和订阅
- 连接状态监听
- 自动重连机制

### 2. ChatManager (lib/common/services/chat_manager.dart)
聊天管理器，负责：
- 消息缓存和排序
- 聊天会话管理
- 消息状态处理
- 与 MQTT 服务的集成

### 3. MqttChatPage (lib/feature/mqtt_chat/mqtt_chat_page.dart)
MQTT 聊天页面 UI，包含：
- 消息列表显示
- 消息输入界面
- 连接状态指示
- 打字状态显示

## 使用方法

### 1. 初始化 MQTT 服务

```dart
// 在 main.dart 中初始化
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: const MyApp()));
}
```

### 2. 使用聊天管理器

```dart
// 在页面中使用
class ChatPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatManager = ref.watch(chatManagerProvider);
    
    // 初始化聊天管理器
    chatManager.initialize(
      userId: 'current_user_id',
      userName: '用户名',
      userAvatar: 'avatar_url',
      broker: 'broker.emqx.io', // MQTT 代理地址
      port: 1883,
    );
    
    // 连接到 MQTT
    chatManager.connect();
    
    return MqttChatPage(
      chatId: 'chat_room_id',
      chatName: '聊天室名称',
    );
  }
}
```

### 3. 发送消息

```dart
// 发送文本消息
await chatManager.sendMessage(
  receiverId: 'target_user_id',
  content: '你好，这是一条测试消息',
  messageType: 'text',
);

// 发送图片消息
await chatManager.sendMessage(
  receiverId: 'target_user_id',
  content: 'image_url',
  messageType: 'image',
  extra: {'width': 200, 'height': 300},
);
```

### 4. 实现消息排序

#### 聊天列表排序
```dart
// 在聊天列表页面中
final sortedChats = chatList.toList()
  ..sort((a, b) {
    // 1. 未读消息优先
    if (a.unreadCount > 0 && b.unreadCount == 0) return -1;
    if (a.unreadCount == 0 && b.unreadCount > 0) return 1;
    
    // 2. 按最后消息时间排序（最新的在最上面）
    return b.lastMessageTime.compareTo(a.lastMessageTime);
  });
```

#### 消息列表排序
```dart
// 在聊天详情页面中
final sortedMessages = messages.toList()
  ..sort((a, b) => a.timestamp.compareTo(b.timestamp)); // 按时间升序排列
```

### 5. 监听消息变化

```dart
// 使用 Riverpod 监听消息流
ref.listen(mqttMessageStreamProvider, (previous, next) {
  next.when(
    data: (messageData) {
      // 处理新消息
      final payload = jsonDecode(messageData.payload);
      if (messageData.topic.contains('/messages')) {
        // 更新消息列表
        // 重新排序聊天列表
      }
    },
    loading: () => debugPrint('加载中...'),
    error: (error, stack) => debugPrint('错误: $error'),
  );
});
```

## MQTT 主题设计

### 消息主题
```
chat_demo/user/{userId}/messages     - 私聊消息
chat_demo/room/{roomId}/messages     - 群聊消息
chat_demo/user/{userId}/typing       - 打字状态
chat_demo/user/{userId}/read         - 已读状态
chat_demo/status/{userId}            - 用户在线状态
chat_demo/broadcast/messages         - 广播消息
```

### 消息格式
```json
{
  "id": "msg_1234567890",
  "senderId": "user_123",
  "receiverId": "user_456",
  "content": "消息内容",
  "messageType": "text",
  "timestamp": "2024-01-01T12:00:00Z",
  "roomId": null,
  "extra": {}
}
```

## 排序优化策略

### 1. 聊天列表排序
- **优先级 1**：置顶聊天（如果支持）
- **优先级 2**：未读消息数量 > 0
- **优先级 3**：最后消息时间（降序）
- **优先级 4**：聊天创建时间（降序）

```dart
List<ChatItem> sortChatList(List<ChatItem> chats) {
  return chats.toList()..sort((a, b) {
    // 置顶优先
    if (a.isPinned && !b.isPinned) return -1;
    if (!a.isPinned && b.isPinned) return 1;
    
    // 未读消息优先
    if (a.unreadCount > 0 && b.unreadCount == 0) return -1;
    if (a.unreadCount == 0 && b.unreadCount > 0) return 1;
    
    // 最后消息时间排序
    return b.lastMessageTime.compareTo(a.lastMessageTime);
  });
}
```

### 2. 消息列表排序
- 按时间戳升序排列（最早的消息在上面）
- 新消息自动滚动到底部

```dart
List<ChatMessage> sortMessages(List<ChatMessage> messages) {
  return messages.toList()
    ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
}
```

### 3. 实时排序更新
当收到新消息时：
1. 更新对应聊天的最后消息时间
2. 增加未读消息计数（如果不是当前打开的聊天）
3. 重新排序聊天列表
4. 通知 UI 更新

```dart
void handleNewMessage(ChatMessage message) {
  // 更新聊天信息
  final chatIndex = chatList.indexWhere((chat) => chat.id == message.chatId);
  if (chatIndex >= 0) {
    chatList[chatIndex] = chatList[chatIndex].copyWith(
      lastMessage: message.content,
      lastMessageTime: message.timestamp,
      unreadCount: isCurrentChat(message.chatId) ? 0 : chatList[chatIndex].unreadCount + 1,
    );
    
    // 重新排序
    chatList = sortChatList(chatList);
    
    // 通知 UI 更新
    notifyListeners();
  }
}
```

## 性能优化

### 1. 消息缓存
- 本地缓存最近的消息
- 分页加载历史消息
- 定期清理过期缓存

### 2. 连接优化
- 自动重连机制
- 心跳保活
- 网络状态监听

### 3. UI 优化
- 虚拟列表（ListView.builder）
- 消息去重
- 延迟排序（debounce）

## 注意事项

1. **MQTT 代理选择**：建议使用可靠的 MQTT 代理服务
2. **消息持久化**：重要消息需要本地存储备份
3. **权限控制**：实现适当的用户身份验证
4. **消息加密**：敏感消息需要端到端加密
5. **网络异常处理**：处理网络断开和重连场景

## 调试技巧

1. 启用 MQTT 客户端日志：
```dart
_client.logging(on: true);
```

2. 监听连接状态变化：
```dart
ref.listen(mqttConnectionStateProvider, (previous, next) {
  print('MQTT 连接状态: $next');
});
```

3. 查看消息流：
```dart
_mqttService.messageStream.listen((message) {
  print('收到消息: ${message.topic} - ${message.payload}');
});
```

## 扩展功能

### 1. 支持更多消息类型
- 语音消息
- 视频消息
- 文件传输
- 位置分享

### 2. 群聊功能
- 群组管理
- 成员权限
- 群公告

### 3. 消息回复和转发
- 消息引用回复
- 消息转发
- 消息撤回

### 4. 高级排序
- 按重要性排序
- 自定义排序规则
- 智能排序（基于用户行为）

这个 MQTT 即时通信系统为您的聊天应用提供了强大的实时通信能力，支持灵活的消息排序和状态管理，可以根据具体需求进行扩展和定制。 