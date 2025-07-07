// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeState _$HomeStateFromJson(Map<String, dynamic> json) =>
    _HomeState(name: json['name'] as String);

Map<String, dynamic> _$HomeStateToJson(_HomeState instance) =>
    <String, dynamic>{'name': instance.name};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeHash() => r'b59ce90d4d0956865065ffb753c9386d3c76cbde';

/// See also [Home].
@ProviderFor(Home)
final homeProvider = AutoDisposeNotifierProvider<Home, String>.internal(
  Home.new,
  name: r'homeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Home = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
