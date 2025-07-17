// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageInfo {

 String get messageId; String get senderId; String get receiverId; String get content; int get timestamp;
/// Create a copy of MessageInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageInfoCopyWith<MessageInfo> get copyWith => _$MessageInfoCopyWithImpl<MessageInfo>(this as MessageInfo, _$identity);

  /// Serializes this MessageInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageInfo&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.content, content) || other.content == content)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,senderId,receiverId,content,timestamp);

@override
String toString() {
  return 'MessageInfo(messageId: $messageId, senderId: $senderId, receiverId: $receiverId, content: $content, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $MessageInfoCopyWith<$Res>  {
  factory $MessageInfoCopyWith(MessageInfo value, $Res Function(MessageInfo) _then) = _$MessageInfoCopyWithImpl;
@useResult
$Res call({
 String messageId, String senderId, String receiverId, String content, int timestamp
});




}
/// @nodoc
class _$MessageInfoCopyWithImpl<$Res>
    implements $MessageInfoCopyWith<$Res> {
  _$MessageInfoCopyWithImpl(this._self, this._then);

  final MessageInfo _self;
  final $Res Function(MessageInfo) _then;

/// Create a copy of MessageInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageId = null,Object? senderId = null,Object? receiverId = null,Object? content = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MessageInfo extends MessageInfo {
  const _MessageInfo({required this.messageId, required this.senderId, required this.receiverId, required this.content, required this.timestamp}): super._();
  factory _MessageInfo.fromJson(Map<String, dynamic> json) => _$MessageInfoFromJson(json);

@override final  String messageId;
@override final  String senderId;
@override final  String receiverId;
@override final  String content;
@override final  int timestamp;

/// Create a copy of MessageInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageInfoCopyWith<_MessageInfo> get copyWith => __$MessageInfoCopyWithImpl<_MessageInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageInfo&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.content, content) || other.content == content)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,senderId,receiverId,content,timestamp);

@override
String toString() {
  return 'MessageInfo(messageId: $messageId, senderId: $senderId, receiverId: $receiverId, content: $content, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$MessageInfoCopyWith<$Res> implements $MessageInfoCopyWith<$Res> {
  factory _$MessageInfoCopyWith(_MessageInfo value, $Res Function(_MessageInfo) _then) = __$MessageInfoCopyWithImpl;
@override @useResult
$Res call({
 String messageId, String senderId, String receiverId, String content, int timestamp
});




}
/// @nodoc
class __$MessageInfoCopyWithImpl<$Res>
    implements _$MessageInfoCopyWith<$Res> {
  __$MessageInfoCopyWithImpl(this._self, this._then);

  final _MessageInfo _self;
  final $Res Function(_MessageInfo) _then;

/// Create a copy of MessageInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? senderId = null,Object? receiverId = null,Object? content = null,Object? timestamp = null,}) {
  return _then(_MessageInfo(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MqttMessageData {

 String get chatId; MessageInfo get messageInfo;
/// Create a copy of MqttMessageData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MqttMessageDataCopyWith<MqttMessageData> get copyWith => _$MqttMessageDataCopyWithImpl<MqttMessageData>(this as MqttMessageData, _$identity);

  /// Serializes this MqttMessageData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MqttMessageData&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.messageInfo, messageInfo) || other.messageInfo == messageInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chatId,messageInfo);

@override
String toString() {
  return 'MqttMessageData(chatId: $chatId, messageInfo: $messageInfo)';
}


}

/// @nodoc
abstract mixin class $MqttMessageDataCopyWith<$Res>  {
  factory $MqttMessageDataCopyWith(MqttMessageData value, $Res Function(MqttMessageData) _then) = _$MqttMessageDataCopyWithImpl;
@useResult
$Res call({
 String chatId, MessageInfo messageInfo
});


$MessageInfoCopyWith<$Res> get messageInfo;

}
/// @nodoc
class _$MqttMessageDataCopyWithImpl<$Res>
    implements $MqttMessageDataCopyWith<$Res> {
  _$MqttMessageDataCopyWithImpl(this._self, this._then);

  final MqttMessageData _self;
  final $Res Function(MqttMessageData) _then;

/// Create a copy of MqttMessageData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chatId = null,Object? messageInfo = null,}) {
  return _then(_self.copyWith(
chatId: null == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String,messageInfo: null == messageInfo ? _self.messageInfo : messageInfo // ignore: cast_nullable_to_non_nullable
as MessageInfo,
  ));
}
/// Create a copy of MqttMessageData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageInfoCopyWith<$Res> get messageInfo {
  
  return $MessageInfoCopyWith<$Res>(_self.messageInfo, (value) {
    return _then(_self.copyWith(messageInfo: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _MqttMessageData implements MqttMessageData {
  const _MqttMessageData({required this.chatId, required this.messageInfo});
  factory _MqttMessageData.fromJson(Map<String, dynamic> json) => _$MqttMessageDataFromJson(json);

@override final  String chatId;
@override final  MessageInfo messageInfo;

/// Create a copy of MqttMessageData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MqttMessageDataCopyWith<_MqttMessageData> get copyWith => __$MqttMessageDataCopyWithImpl<_MqttMessageData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MqttMessageDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MqttMessageData&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.messageInfo, messageInfo) || other.messageInfo == messageInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chatId,messageInfo);

@override
String toString() {
  return 'MqttMessageData(chatId: $chatId, messageInfo: $messageInfo)';
}


}

/// @nodoc
abstract mixin class _$MqttMessageDataCopyWith<$Res> implements $MqttMessageDataCopyWith<$Res> {
  factory _$MqttMessageDataCopyWith(_MqttMessageData value, $Res Function(_MqttMessageData) _then) = __$MqttMessageDataCopyWithImpl;
@override @useResult
$Res call({
 String chatId, MessageInfo messageInfo
});


@override $MessageInfoCopyWith<$Res> get messageInfo;

}
/// @nodoc
class __$MqttMessageDataCopyWithImpl<$Res>
    implements _$MqttMessageDataCopyWith<$Res> {
  __$MqttMessageDataCopyWithImpl(this._self, this._then);

  final _MqttMessageData _self;
  final $Res Function(_MqttMessageData) _then;

/// Create a copy of MqttMessageData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chatId = null,Object? messageInfo = null,}) {
  return _then(_MqttMessageData(
chatId: null == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String,messageInfo: null == messageInfo ? _self.messageInfo : messageInfo // ignore: cast_nullable_to_non_nullable
as MessageInfo,
  ));
}

/// Create a copy of MqttMessageData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageInfoCopyWith<$Res> get messageInfo {
  
  return $MessageInfoCopyWith<$Res>(_self.messageInfo, (value) {
    return _then(_self.copyWith(messageInfo: value));
  });
}
}

// dart format on
