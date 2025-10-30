// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingState _$SettingStateFromJson(Map<String, dynamic> json) =>
    _SettingState(userChatAi: json['userChatAi'] as bool);

Map<String, dynamic> _$SettingStateToJson(_SettingState instance) => <String, dynamic>{
  'userChatAi': instance.userChatAi,
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingServiceHash() => r'9c16e38a4748dad51d0dc91a7b7a98a98111befc';

/// See also [SettingService].
@ProviderFor(SettingService)
final settingServiceProvider = NotifierProvider<SettingService, SettingState>.internal(
  SettingService.new,
  name: r'settingServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$settingServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SettingService = Notifier<SettingState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
