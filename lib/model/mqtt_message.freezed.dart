// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mqtt_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MqttMessage {

 String get id; String get senderId; String get receiverId; String get content; String get messageType;// 'text', 'image', 'voice', 'video'
 DateTime get timestamp; bool get isRead; String get senderName; String get senderAvatar; Map<String, dynamic> get extra;
/// Create a copy of MqttMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MqttMessageCopyWith<MqttMessage> get copyWith => _$MqttMessageCopyWithImpl<MqttMessage>(this as MqttMessage, _$identity);

  /// Serializes this MqttMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MqttMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.content, content) || other.content == content)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.senderAvatar, senderAvatar) || other.senderAvatar == senderAvatar)&&const DeepCollectionEquality().equals(other.extra, extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,senderId,receiverId,content,messageType,timestamp,isRead,senderName,senderAvatar,const DeepCollectionEquality().hash(extra));

@override
String toString() {
  return 'MqttMessage(id: $id, senderId: $senderId, receiverId: $receiverId, content: $content, messageType: $messageType, timestamp: $timestamp, isRead: $isRead, senderName: $senderName, senderAvatar: $senderAvatar, extra: $extra)';
}


}

/// @nodoc
abstract mixin class $MqttMessageCopyWith<$Res>  {
  factory $MqttMessageCopyWith(MqttMessage value, $Res Function(MqttMessage) _then) = _$MqttMessageCopyWithImpl;
@useResult
$Res call({
 String id, String senderId, String receiverId, String content, String messageType, DateTime timestamp, bool isRead, String senderName, String senderAvatar, Map<String, dynamic> extra
});




}
/// @nodoc
class _$MqttMessageCopyWithImpl<$Res>
    implements $MqttMessageCopyWith<$Res> {
  _$MqttMessageCopyWithImpl(this._self, this._then);

  final MqttMessage _self;
  final $Res Function(MqttMessage) _then;

/// Create a copy of MqttMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? senderId = null,Object? receiverId = null,Object? content = null,Object? messageType = null,Object? timestamp = null,Object? isRead = null,Object? senderName = null,Object? senderAvatar = null,Object? extra = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,senderAvatar: null == senderAvatar ? _self.senderAvatar : senderAvatar // ignore: cast_nullable_to_non_nullable
as String,extra: null == extra ? _self.extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MqttMessage implements MqttMessage {
  const _MqttMessage({required this.id, required this.senderId, required this.receiverId, required this.content, required this.messageType, required this.timestamp, this.isRead = false, this.senderName = '', this.senderAvatar = '', final  Map<String, dynamic> extra = const {}}): _extra = extra;
  factory _MqttMessage.fromJson(Map<String, dynamic> json) => _$MqttMessageFromJson(json);

@override final  String id;
@override final  String senderId;
@override final  String receiverId;
@override final  String content;
@override final  String messageType;
// 'text', 'image', 'voice', 'video'
@override final  DateTime timestamp;
@override@JsonKey() final  bool isRead;
@override@JsonKey() final  String senderName;
@override@JsonKey() final  String senderAvatar;
 final  Map<String, dynamic> _extra;
@override@JsonKey() Map<String, dynamic> get extra {
  if (_extra is EqualUnmodifiableMapView) return _extra;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extra);
}


/// Create a copy of MqttMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MqttMessageCopyWith<_MqttMessage> get copyWith => __$MqttMessageCopyWithImpl<_MqttMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MqttMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MqttMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.content, content) || other.content == content)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.senderAvatar, senderAvatar) || other.senderAvatar == senderAvatar)&&const DeepCollectionEquality().equals(other._extra, _extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,senderId,receiverId,content,messageType,timestamp,isRead,senderName,senderAvatar,const DeepCollectionEquality().hash(_extra));

@override
String toString() {
  return 'MqttMessage(id: $id, senderId: $senderId, receiverId: $receiverId, content: $content, messageType: $messageType, timestamp: $timestamp, isRead: $isRead, senderName: $senderName, senderAvatar: $senderAvatar, extra: $extra)';
}


}

/// @nodoc
abstract mixin class _$MqttMessageCopyWith<$Res> implements $MqttMessageCopyWith<$Res> {
  factory _$MqttMessageCopyWith(_MqttMessage value, $Res Function(_MqttMessage) _then) = __$MqttMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String senderId, String receiverId, String content, String messageType, DateTime timestamp, bool isRead, String senderName, String senderAvatar, Map<String, dynamic> extra
});




}
/// @nodoc
class __$MqttMessageCopyWithImpl<$Res>
    implements _$MqttMessageCopyWith<$Res> {
  __$MqttMessageCopyWithImpl(this._self, this._then);

  final _MqttMessage _self;
  final $Res Function(_MqttMessage) _then;

/// Create a copy of MqttMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderId = null,Object? receiverId = null,Object? content = null,Object? messageType = null,Object? timestamp = null,Object? isRead = null,Object? senderName = null,Object? senderAvatar = null,Object? extra = null,}) {
  return _then(_MqttMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,senderAvatar: null == senderAvatar ? _self.senderAvatar : senderAvatar // ignore: cast_nullable_to_non_nullable
as String,extra: null == extra ? _self._extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$MqttChatRoom {

 String get roomId; String get roomName; List<String> get participants; DateTime get createdAt; DateTime get lastMessageTime; String get lastMessage; int get unreadCount; String get roomType;// 'private', 'group'
 Map<String, dynamic> get metadata;
/// Create a copy of MqttChatRoom
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MqttChatRoomCopyWith<MqttChatRoom> get copyWith => _$MqttChatRoomCopyWithImpl<MqttChatRoom>(this as MqttChatRoom, _$identity);

  /// Serializes this MqttChatRoom to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MqttChatRoom&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.roomName, roomName) || other.roomName == roomName)&&const DeepCollectionEquality().equals(other.participants, participants)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastMessageTime, lastMessageTime) || other.lastMessageTime == lastMessageTime)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.roomType, roomType) || other.roomType == roomType)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roomId,roomName,const DeepCollectionEquality().hash(participants),createdAt,lastMessageTime,lastMessage,unreadCount,roomType,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'MqttChatRoom(roomId: $roomId, roomName: $roomName, participants: $participants, createdAt: $createdAt, lastMessageTime: $lastMessageTime, lastMessage: $lastMessage, unreadCount: $unreadCount, roomType: $roomType, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $MqttChatRoomCopyWith<$Res>  {
  factory $MqttChatRoomCopyWith(MqttChatRoom value, $Res Function(MqttChatRoom) _then) = _$MqttChatRoomCopyWithImpl;
@useResult
$Res call({
 String roomId, String roomName, List<String> participants, DateTime createdAt, DateTime lastMessageTime, String lastMessage, int unreadCount, String roomType, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$MqttChatRoomCopyWithImpl<$Res>
    implements $MqttChatRoomCopyWith<$Res> {
  _$MqttChatRoomCopyWithImpl(this._self, this._then);

  final MqttChatRoom _self;
  final $Res Function(MqttChatRoom) _then;

/// Create a copy of MqttChatRoom
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roomId = null,Object? roomName = null,Object? participants = null,Object? createdAt = null,Object? lastMessageTime = null,Object? lastMessage = null,Object? unreadCount = null,Object? roomType = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,roomName: null == roomName ? _self.roomName : roomName // ignore: cast_nullable_to_non_nullable
as String,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastMessageTime: null == lastMessageTime ? _self.lastMessageTime : lastMessageTime // ignore: cast_nullable_to_non_nullable
as DateTime,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,roomType: null == roomType ? _self.roomType : roomType // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MqttChatRoom implements MqttChatRoom {
  const _MqttChatRoom({required this.roomId, required this.roomName, required final  List<String> participants, required this.createdAt, required this.lastMessageTime, required this.lastMessage, this.unreadCount = 0, this.roomType = 'group', final  Map<String, dynamic> metadata = const {}}): _participants = participants,_metadata = metadata;
  factory _MqttChatRoom.fromJson(Map<String, dynamic> json) => _$MqttChatRoomFromJson(json);

@override final  String roomId;
@override final  String roomName;
 final  List<String> _participants;
@override List<String> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

@override final  DateTime createdAt;
@override final  DateTime lastMessageTime;
@override final  String lastMessage;
@override@JsonKey() final  int unreadCount;
@override@JsonKey() final  String roomType;
// 'private', 'group'
 final  Map<String, dynamic> _metadata;
// 'private', 'group'
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of MqttChatRoom
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MqttChatRoomCopyWith<_MqttChatRoom> get copyWith => __$MqttChatRoomCopyWithImpl<_MqttChatRoom>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MqttChatRoomToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MqttChatRoom&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.roomName, roomName) || other.roomName == roomName)&&const DeepCollectionEquality().equals(other._participants, _participants)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastMessageTime, lastMessageTime) || other.lastMessageTime == lastMessageTime)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.roomType, roomType) || other.roomType == roomType)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roomId,roomName,const DeepCollectionEquality().hash(_participants),createdAt,lastMessageTime,lastMessage,unreadCount,roomType,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'MqttChatRoom(roomId: $roomId, roomName: $roomName, participants: $participants, createdAt: $createdAt, lastMessageTime: $lastMessageTime, lastMessage: $lastMessage, unreadCount: $unreadCount, roomType: $roomType, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$MqttChatRoomCopyWith<$Res> implements $MqttChatRoomCopyWith<$Res> {
  factory _$MqttChatRoomCopyWith(_MqttChatRoom value, $Res Function(_MqttChatRoom) _then) = __$MqttChatRoomCopyWithImpl;
@override @useResult
$Res call({
 String roomId, String roomName, List<String> participants, DateTime createdAt, DateTime lastMessageTime, String lastMessage, int unreadCount, String roomType, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$MqttChatRoomCopyWithImpl<$Res>
    implements _$MqttChatRoomCopyWith<$Res> {
  __$MqttChatRoomCopyWithImpl(this._self, this._then);

  final _MqttChatRoom _self;
  final $Res Function(_MqttChatRoom) _then;

/// Create a copy of MqttChatRoom
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roomId = null,Object? roomName = null,Object? participants = null,Object? createdAt = null,Object? lastMessageTime = null,Object? lastMessage = null,Object? unreadCount = null,Object? roomType = null,Object? metadata = null,}) {
  return _then(_MqttChatRoom(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,roomName: null == roomName ? _self.roomName : roomName // ignore: cast_nullable_to_non_nullable
as String,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastMessageTime: null == lastMessageTime ? _self.lastMessageTime : lastMessageTime // ignore: cast_nullable_to_non_nullable
as DateTime,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,roomType: null == roomType ? _self.roomType : roomType // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$MqttUserStatus {

 String get userId; String get status;// 'online', 'offline', 'away', 'busy'
 DateTime get lastSeen; String get statusMessage;
/// Create a copy of MqttUserStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MqttUserStatusCopyWith<MqttUserStatus> get copyWith => _$MqttUserStatusCopyWithImpl<MqttUserStatus>(this as MqttUserStatus, _$identity);

  /// Serializes this MqttUserStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MqttUserStatus&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastSeen, lastSeen) || other.lastSeen == lastSeen)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,status,lastSeen,statusMessage);

@override
String toString() {
  return 'MqttUserStatus(userId: $userId, status: $status, lastSeen: $lastSeen, statusMessage: $statusMessage)';
}


}

/// @nodoc
abstract mixin class $MqttUserStatusCopyWith<$Res>  {
  factory $MqttUserStatusCopyWith(MqttUserStatus value, $Res Function(MqttUserStatus) _then) = _$MqttUserStatusCopyWithImpl;
@useResult
$Res call({
 String userId, String status, DateTime lastSeen, String statusMessage
});




}
/// @nodoc
class _$MqttUserStatusCopyWithImpl<$Res>
    implements $MqttUserStatusCopyWith<$Res> {
  _$MqttUserStatusCopyWithImpl(this._self, this._then);

  final MqttUserStatus _self;
  final $Res Function(MqttUserStatus) _then;

/// Create a copy of MqttUserStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? status = null,Object? lastSeen = null,Object? statusMessage = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,lastSeen: null == lastSeen ? _self.lastSeen : lastSeen // ignore: cast_nullable_to_non_nullable
as DateTime,statusMessage: null == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MqttUserStatus implements MqttUserStatus {
  const _MqttUserStatus({required this.userId, required this.status, required this.lastSeen, this.statusMessage = ''});
  factory _MqttUserStatus.fromJson(Map<String, dynamic> json) => _$MqttUserStatusFromJson(json);

@override final  String userId;
@override final  String status;
// 'online', 'offline', 'away', 'busy'
@override final  DateTime lastSeen;
@override@JsonKey() final  String statusMessage;

/// Create a copy of MqttUserStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MqttUserStatusCopyWith<_MqttUserStatus> get copyWith => __$MqttUserStatusCopyWithImpl<_MqttUserStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MqttUserStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MqttUserStatus&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastSeen, lastSeen) || other.lastSeen == lastSeen)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,status,lastSeen,statusMessage);

@override
String toString() {
  return 'MqttUserStatus(userId: $userId, status: $status, lastSeen: $lastSeen, statusMessage: $statusMessage)';
}


}

/// @nodoc
abstract mixin class _$MqttUserStatusCopyWith<$Res> implements $MqttUserStatusCopyWith<$Res> {
  factory _$MqttUserStatusCopyWith(_MqttUserStatus value, $Res Function(_MqttUserStatus) _then) = __$MqttUserStatusCopyWithImpl;
@override @useResult
$Res call({
 String userId, String status, DateTime lastSeen, String statusMessage
});




}
/// @nodoc
class __$MqttUserStatusCopyWithImpl<$Res>
    implements _$MqttUserStatusCopyWith<$Res> {
  __$MqttUserStatusCopyWithImpl(this._self, this._then);

  final _MqttUserStatus _self;
  final $Res Function(_MqttUserStatus) _then;

/// Create a copy of MqttUserStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? status = null,Object? lastSeen = null,Object? statusMessage = null,}) {
  return _then(_MqttUserStatus(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,lastSeen: null == lastSeen ? _self.lastSeen : lastSeen // ignore: cast_nullable_to_non_nullable
as DateTime,statusMessage: null == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
