// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageInfo _$MessageInfoFromJson(Map<String, dynamic> json) => _MessageInfo(
  messageId: json['messageId'] as String,
  senderId: json['senderId'] as String,
  receiverId: json['receiverId'] as String,
  content: json['content'] as String,
  timestamp: (json['timestamp'] as num).toInt(),
);

Map<String, dynamic> _$MessageInfoToJson(_MessageInfo instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'content': instance.content,
      'timestamp': instance.timestamp,
    };

_MqttMessageData _$MqttMessageDataFromJson(Map<String, dynamic> json) =>
    _MqttMessageData(
      chatId: json['chatId'] as String,
      messageInfo: MessageInfo.fromJson(
        json['messageInfo'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$MqttMessageDataToJson(_MqttMessageData instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'messageInfo': instance.messageInfo,
    };
