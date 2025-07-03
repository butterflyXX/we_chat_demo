// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatDetailVMHash() => r'5d71134641eefbe5a2b7517d8bc05cbe1832d257';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ChatDetailVM extends BuildlessAutoDisposeNotifier<void> {
  late final String userId;

  void build(String userId);
}

/// See also [ChatDetailVM].
@ProviderFor(ChatDetailVM)
const chatDetailVMProvider = ChatDetailVMFamily();

/// See also [ChatDetailVM].
class ChatDetailVMFamily extends Family<void> {
  /// See also [ChatDetailVM].
  const ChatDetailVMFamily();

  /// See also [ChatDetailVM].
  ChatDetailVMProvider call(String userId) {
    return ChatDetailVMProvider(userId);
  }

  @override
  ChatDetailVMProvider getProviderOverride(
    covariant ChatDetailVMProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chatDetailVMProvider';
}

/// See also [ChatDetailVM].
class ChatDetailVMProvider
    extends AutoDisposeNotifierProviderImpl<ChatDetailVM, void> {
  /// See also [ChatDetailVM].
  ChatDetailVMProvider(String userId)
    : this._internal(
        () => ChatDetailVM()..userId = userId,
        from: chatDetailVMProvider,
        name: r'chatDetailVMProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$chatDetailVMHash,
        dependencies: ChatDetailVMFamily._dependencies,
        allTransitiveDependencies:
            ChatDetailVMFamily._allTransitiveDependencies,
        userId: userId,
      );

  ChatDetailVMProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  void runNotifierBuild(covariant ChatDetailVM notifier) {
    return notifier.build(userId);
  }

  @override
  Override overrideWith(ChatDetailVM Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatDetailVMProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ChatDetailVM, void> createElement() {
    return _ChatDetailVMProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatDetailVMProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChatDetailVMRef on AutoDisposeNotifierProviderRef<void> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _ChatDetailVMProviderElement
    extends AutoDisposeNotifierProviderElement<ChatDetailVM, void>
    with ChatDetailVMRef {
  _ChatDetailVMProviderElement(super.provider);

  @override
  String get userId => (origin as ChatDetailVMProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
