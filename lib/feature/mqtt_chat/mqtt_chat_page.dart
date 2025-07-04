import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_demo/common/color.dart';
import 'package:chat_demo/common/widget/app_bar.dart';
import 'package:chat_demo/common/mqtt/chat_manager.dart';
import 'package:chat_demo/common/mqtt/mqtt_service.dart';
import 'package:mqtt_client/mqtt_client.dart';

// MQTT 聊天页面状态提供者
final mqttChatPageProvider =
    StateNotifierProvider.family<MqttChatNotifier, MqttChatState, String>((
      ref,
      chatId,
    ) {
      return MqttChatNotifier(ref, chatId);
    });

// 聊天状态
class MqttChatState {
  final List<ChatMessage> messages;
  final bool isConnected;
  final bool isLoading;
  final String typingStatus;
  final bool hasUnreadMessages;

  const MqttChatState({
    this.messages = const [],
    this.isConnected = false,
    this.isLoading = false,
    this.typingStatus = '',
    this.hasUnreadMessages = false,
  });

  MqttChatState copyWith({
    List<ChatMessage>? messages,
    bool? isConnected,
    bool? isLoading,
    String? typingStatus,
    bool? hasUnreadMessages,
  }) {
    return MqttChatState(
      messages: messages ?? this.messages,
      isConnected: isConnected ?? this.isConnected,
      isLoading: isLoading ?? this.isLoading,
      typingStatus: typingStatus ?? this.typingStatus,
      hasUnreadMessages: hasUnreadMessages ?? this.hasUnreadMessages,
    );
  }
}

// 聊天状态管理器
class MqttChatNotifier extends StateNotifier<MqttChatState> {
  final Ref ref;
  final String chatId;
  late final ChatManager _chatManager;
  late final TextEditingController textController;

  MqttChatNotifier(this.ref, this.chatId) : super(const MqttChatState()) {
    _chatManager = ref.read(chatManagerProvider);
    textController = TextEditingController();
    _initialize();
  }

  void _initialize() async {
    state = state.copyWith(isLoading: true);

    // 初始化聊天管理器
    await _chatManager.initialize(
      userId: 'user_123', // 当前用户ID，实际应用中从用户状态获取
      userName: '我的用户名',
      userAvatar: 'https://example.com/avatar.jpg',
    );

    // 连接到 MQTT
    final connected = await _chatManager.connect();
    state = state.copyWith(isConnected: connected, isLoading: false);

    // 加载缓存的消息
    _loadMessages();

    // 监听连接状态
    ref.listen(mqttConnectionStateProvider, (previous, next) {
      state = state.copyWith(
        isConnected: next == MqttConnectionState.connected,
      );
    });
  }

  void _loadMessages() {
    final cachedMessages = _chatManager.getCachedMessages(chatId);
    // 按时间排序，最新消息在最下面
    cachedMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    state = state.copyWith(messages: cachedMessages);
  }

  // 发送消息
  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty || !state.isConnected) return;

    try {
      await _chatManager.sendMessage(
        receiverId: chatId,
        content: content.trim(),
        messageType: 'text',
      );

      // 清空输入框
      textController.clear();

      // 停止打字状态
      // await _chatManager.sendTypingStatus(receiverId: chatId, isTyping: false);
    } catch (e) {
      // 显示错误
      debugPrint('发送消息失败: $e');
    }
  }

  // 发送打字状态
  Future<void> sendTypingStatus(bool isTyping) async {
    if (!state.isConnected) return;

    // await _chatManager.sendTypingStatus(receiverId: chatId, isTyping: isTyping);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}

// MQTT 聊天页面
class MqttChatPage extends ConsumerStatefulWidget {
  final String chatId;
  final String chatName;

  const MqttChatPage({super.key, required this.chatId, required this.chatName});

  @override
  ConsumerState<MqttChatPage> createState() => _MqttChatPageState();
}

class _MqttChatPageState extends ConsumerState<MqttChatPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(mqttChatPageProvider(widget.chatId).notifier);
    final state = ref.watch(mqttChatPageProvider(widget.chatId));

    // 监听消息变化，自动滚动到底部
    ref.listen(mqttChatPageProvider(widget.chatId), (previous, next) {
      if (previous?.messages.length != next.messages.length) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
      }
    });

    return Scaffold(
      appBar: commonAppbar(
        context,
        title: widget.chatName,
        actions: [
          // 连接状态指示器
          Container(
            margin: EdgeInsets.only(right: 16.w),
            child: Icon(
              state.isConnected ? Icons.wifi : Icons.wifi_off,
              color: state.isConnected ? Colors.green : Colors.red,
              size: 24.sp,
            ),
          ),
        ],
      ),
      backgroundColor: commonAppBarBackColor,
      body: Column(
        children: [
          // 加载指示器
          if (state.isLoading) const LinearProgressIndicator(),

          // 消息列表
          Expanded(
            child: state.messages.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      return _buildMessageItem(message);
                    },
                  ),
          ),

          // 打字状态指示器
          if (state.typingStatus.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  Text(
                    state.typingStatus,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
                ],
              ),
            ),

          // 输入区域
          _buildInputArea(notifier, state),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 80.sp, color: Colors.grey[400]),
          SizedBox(height: 16.h),
          Text(
            '开始聊天吧！',
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(ChatMessage message) {
    final isMyMessage = message.senderId == 'user_123'; // 当前用户ID

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: isMyMessage
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMyMessage) ...[
            // 对方头像
            CircleAvatar(
              radius: 16.r,
              backgroundImage: NetworkImage(
                message.senderAvatar.isNotEmpty
                    ? message.senderAvatar
                    : 'https://via.placeholder.com/32',
              ),
            ),
            SizedBox(width: 8.w),
          ],

          // 消息气泡
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: 0.7.sw),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isMyMessage ? Colors.blue[500] : Colors.grey[200],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMyMessage && message.senderName.isNotEmpty) ...[
                    Text(
                      message.senderName,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                  ],

                  Text(
                    message.content,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: isMyMessage ? Colors.white : Colors.black87,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _formatTime(message.timestamp),
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: isMyMessage
                              ? Colors.white70
                              : Colors.grey[500],
                        ),
                      ),

                      if (isMyMessage) ...[
                        SizedBox(width: 4.w),
                        Icon(
                          message.isRead ? Icons.done_all : Icons.done,
                          size: 12.sp,
                          color: message.isRead
                              ? Colors.blue[200]
                              : Colors.white70,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),

          if (isMyMessage) ...[
            SizedBox(width: 8.w),
            // 我的头像
            CircleAvatar(
              radius: 16.r,
              backgroundImage: const NetworkImage(
                'https://via.placeholder.com/32',
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputArea(MqttChatNotifier notifier, MqttChatState state) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: notifier.textController,
              enabled: state.isConnected,
              decoration: InputDecoration(
                hintText: state.isConnected ? '输入消息...' : '正在连接...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
              ),
              maxLines: 4,
              minLines: 1,
              onChanged: (text) {
                // 发送打字状态
                notifier.sendTypingStatus(text.isNotEmpty);
              },
              onSubmitted: (text) {
                notifier.sendMessage(text);
              },
            ),
          ),

          SizedBox(width: 8.w),

          // 发送按钮
          GestureDetector(
            onTap: state.isConnected
                ? () {
                    notifier.sendMessage(notifier.textController.text);
                  }
                : null,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: state.isConnected ? Colors.blue : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.send, color: Colors.white, size: 20.sp),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays}天前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }
}
