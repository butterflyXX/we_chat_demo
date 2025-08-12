// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatDetailState {

 bool get canScroll; bool get isRecord;
/// Create a copy of ChatDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatDetailStateCopyWith<ChatDetailState> get copyWith => _$ChatDetailStateCopyWithImpl<ChatDetailState>(this as ChatDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatDetailState&&(identical(other.canScroll, canScroll) || other.canScroll == canScroll)&&(identical(other.isRecord, isRecord) || other.isRecord == isRecord));
}


@override
int get hashCode => Object.hash(runtimeType,canScroll,isRecord);

@override
String toString() {
  return 'ChatDetailState(canScroll: $canScroll, isRecord: $isRecord)';
}


}

/// @nodoc
abstract mixin class $ChatDetailStateCopyWith<$Res>  {
  factory $ChatDetailStateCopyWith(ChatDetailState value, $Res Function(ChatDetailState) _then) = _$ChatDetailStateCopyWithImpl;
@useResult
$Res call({
 bool canScroll, bool isRecord
});




}
/// @nodoc
class _$ChatDetailStateCopyWithImpl<$Res>
    implements $ChatDetailStateCopyWith<$Res> {
  _$ChatDetailStateCopyWithImpl(this._self, this._then);

  final ChatDetailState _self;
  final $Res Function(ChatDetailState) _then;

/// Create a copy of ChatDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? canScroll = null,Object? isRecord = null,}) {
  return _then(_self.copyWith(
canScroll: null == canScroll ? _self.canScroll : canScroll // ignore: cast_nullable_to_non_nullable
as bool,isRecord: null == isRecord ? _self.isRecord : isRecord // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _ChatDetailState implements ChatDetailState {
  const _ChatDetailState({this.canScroll = true, this.isRecord = false});
  

@override@JsonKey() final  bool canScroll;
@override@JsonKey() final  bool isRecord;

/// Create a copy of ChatDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatDetailStateCopyWith<_ChatDetailState> get copyWith => __$ChatDetailStateCopyWithImpl<_ChatDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatDetailState&&(identical(other.canScroll, canScroll) || other.canScroll == canScroll)&&(identical(other.isRecord, isRecord) || other.isRecord == isRecord));
}


@override
int get hashCode => Object.hash(runtimeType,canScroll,isRecord);

@override
String toString() {
  return 'ChatDetailState(canScroll: $canScroll, isRecord: $isRecord)';
}


}

/// @nodoc
abstract mixin class _$ChatDetailStateCopyWith<$Res> implements $ChatDetailStateCopyWith<$Res> {
  factory _$ChatDetailStateCopyWith(_ChatDetailState value, $Res Function(_ChatDetailState) _then) = __$ChatDetailStateCopyWithImpl;
@override @useResult
$Res call({
 bool canScroll, bool isRecord
});




}
/// @nodoc
class __$ChatDetailStateCopyWithImpl<$Res>
    implements _$ChatDetailStateCopyWith<$Res> {
  __$ChatDetailStateCopyWithImpl(this._self, this._then);

  final _ChatDetailState _self;
  final $Res Function(_ChatDetailState) _then;

/// Create a copy of ChatDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? canScroll = null,Object? isRecord = null,}) {
  return _then(_ChatDetailState(
canScroll: null == canScroll ? _self.canScroll : canScroll // ignore: cast_nullable_to_non_nullable
as bool,isRecord: null == isRecord ? _self.isRecord : isRecord // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
