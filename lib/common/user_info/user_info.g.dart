// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserInfo _$UserInfoFromJson(Map<String, dynamic> json) =>
    _UserInfo(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$UserInfoToJson(_UserInfo instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userInfoNotifierHash() => r'a629822047e0282433b78262964bbcc18f9ad891';

/// See also [UserInfoNotifier].
@ProviderFor(UserInfoNotifier)
final userInfoNotifierProvider =
    NotifierProvider<UserInfoNotifier, UserInfo?>.internal(
      UserInfoNotifier.new,
      name: r'userInfoNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$userInfoNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$UserInfoNotifier = Notifier<UserInfo?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
