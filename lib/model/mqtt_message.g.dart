// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mqtt_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MqttMessage _$MqttMessageFromJson(Map<String, dynamic> json) => _MqttMessage(
  id: json['id'] as String,
  senderId: json['senderId'] as String,
  receiverId: json['receiverId'] as String,
  content: json['content'] as String,
  messageType: json['messageType'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  isRead: json['isRead'] as bool? ?? false,
  senderName: json['senderName'] as String? ?? '',
  senderAvatar: json['senderAvatar'] as String? ?? '',
  extra: json['extra'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$MqttMessageToJson(_MqttMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'content': instance.content,
      'messageType': instance.messageType,
      'timestamp': instance.timestamp.toIso8601String(),
      'isRead': instance.isRead,
      'senderName': instance.senderName,
      'senderAvatar': instance.senderAvatar,
      'extra': instance.extra,
    };

_MqttChatRoom _$MqttChatRoomFromJson(Map<String, dynamic> json) =>
    _MqttChatRoom(
      roomId: json['roomId'] as String,
      roomName: json['roomName'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastMessageTime: DateTime.parse(json['lastMessageTime'] as String),
      lastMessage: json['lastMessage'] as String,
      unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
      roomType: json['roomType'] as String? ?? 'group',
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$MqttChatRoomToJson(_MqttChatRoom instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'roomName': instance.roomName,
      'participants': instance.participants,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastMessageTime': instance.lastMessageTime.toIso8601String(),
      'lastMessage': instance.lastMessage,
      'unreadCount': instance.unreadCount,
      'roomType': instance.roomType,
      'metadata': instance.metadata,
    };

_MqttUserStatus _$MqttUserStatusFromJson(Map<String, dynamic> json) =>
    _MqttUserStatus(
      userId: json['userId'] as String,
      status: json['status'] as String,
      lastSeen: DateTime.parse(json['lastSeen'] as String),
      statusMessage: json['statusMessage'] as String? ?? '',
    );

Map<String, dynamic> _$MqttUserStatusToJson(_MqttUserStatus instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'status': instance.status,
      'lastSeen': instance.lastSeen.toIso8601String(),
      'statusMessage': instance.statusMessage,
    };
