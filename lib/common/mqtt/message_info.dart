import 'package:freezed_annotation/freezed_annotation.dart';


part 'message_info.g.dart';
part 'message_info.freezed.dart';

@freezed
abstract class MessageInfo with _$MessageInfo {
  const factory MessageInfo({
    required String messageId,
    required String senderId,
    required String receiverId,
    required String content,
    required int timestamp,
  }) = _MessageInfo;

  factory MessageInfo.fromJson(Map<String, dynamic> json) =>
      _$MessageInfoFromJson(json);
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