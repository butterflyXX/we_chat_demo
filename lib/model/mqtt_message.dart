import 'package:freezed_annotation/freezed_annotation.dart';

part 'mqtt_message.freezed.dart';
part 'mqtt_message.g.dart';

@freezed
abstract class MqttMessage with _$MqttMessage {
  const factory MqttMessage({
    required String id,
    required String senderId,
    required String receiverId,
    required String content,
    required String messageType, // 'text', 'image', 'voice', 'video'
    required DateTime timestamp,
    @Default(false) bool isRead,
    @Default('') String senderName,
    @Default('') String senderAvatar,
    @Default({}) Map<String, dynamic> extra,
  }) = _MqttMessage;

  factory MqttMessage.fromJson(Map<String, dynamic> json) =>
      _$MqttMessageFromJson(json);
}

@freezed
abstract class MqttChatRoom with _$MqttChatRoom {
  const factory MqttChatRoom({
    required String roomId,
    required String roomName,
    required List<String> participants,
    required DateTime createdAt,
    required DateTime lastMessageTime,
    required String lastMessage,
    @Default(0) int unreadCount,
    @Default('group') String roomType, // 'private', 'group'
    @Default({}) Map<String, dynamic> metadata,
  }) = _MqttChatRoom;

  factory MqttChatRoom.fromJson(Map<String, dynamic> json) =>
      _$MqttChatRoomFromJson(json);
}

@freezed
abstract class MqttUserStatus with _$MqttUserStatus {
  const factory MqttUserStatus({
    required String userId,
    required String status, // 'online', 'offline', 'away', 'busy'
    required DateTime lastSeen,
    @Default('') String statusMessage,
  }) = _MqttUserStatus;

  factory MqttUserStatus.fromJson(Map<String, dynamic> json) =>
      _$MqttUserStatusFromJson(json);
}

// 消息类型枚举
enum MessageType { text, image, voice, video, file, location, system }

// 用户状态枚举
enum UserStatus { online, offline, away, busy }

// 聊天室类型枚举
enum ChatRoomType { private, group }

// 消息事件类型
enum MqttEventType {
  message,
  userStatus,
  typing,
  messageRead,
  messageDelivered,
  roomCreated,
  roomDeleted,
  userJoined,
  userLeft,
}
