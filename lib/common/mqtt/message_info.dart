import 'package:freezed_annotation/freezed_annotation.dart';


part 'message_info.g.dart';
part 'message_info.freezed.dart';

@freezed
abstract class MessageInfo with _$MessageInfo {
  const MessageInfo._();
  const factory MessageInfo({
    required String messageId,
    required String senderId,
    required String receiverId,
    required String content,
    required int timestamp,
  }) = _MessageInfo;

  factory MessageInfo.fromJson(Map<String, dynamic> json) =>
      _$MessageInfoFromJson(json);

  // 就是聊天对方的用户id
  String getChatId(String loginUserId) {
    return senderId == loginUserId ? receiverId : senderId;
  }
}

@freezed
abstract class MqttMessageData with _$MqttMessageData {
  const factory MqttMessageData({
    required String chatId,
    required MessageInfo messageInfo,
  }) = _MqttMessageData;

  factory MqttMessageData.fromJson(Map<String, dynamic> json) =>
      _$MqttMessageDataFromJson(json);
}