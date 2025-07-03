// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_list.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatListHash() => r'e53e671fc04c3d0f69875d4ac5fb9dab52972969';

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

abstract class _$ChatList
    extends BuildlessAutoDisposeNotifier<List<ChatItemModel>> {
  late final String userId;

  List<ChatItemModel> build(String userId);
}

/// See also [ChatList].
@ProviderFor(ChatList)
const chatListProvider = ChatListFamily();

/// See also [ChatList].
class ChatListFamily extends Family<List<ChatItemModel>> {
  /// See also [ChatList].
  const ChatListFamily();

  /// See also [ChatList].
  ChatListProvider call(String userId) {
    return ChatListProvider(userId);
  }

  @override
  ChatListProvider getProviderOverride(covariant ChatListProvider provider) {
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
  String? get name => r'chatListProvider';
}

/// See also [ChatList].
class ChatListProvider
    extends AutoDisposeNotifierProviderImpl<ChatList, List<ChatItemModel>> {
  /// See also [ChatList].
  ChatListProvider(String userId)
    : this._internal(
        () => ChatList()..userId = userId,
        from: chatListProvider,
        name: r'chatListProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$chatListHash,
        dependencies: ChatListFamily._dependencies,
        allTransitiveDependencies: ChatListFamily._allTransitiveDependencies,
        userId: userId,
      );

  ChatListProvider._internal(
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
  List<ChatItemModel> runNotifierBuild(covariant ChatList notifier) {
    return notifier.build(userId);
  }

  @override
  Override overrideWith(ChatList Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatListProvider._internal(
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
  AutoDisposeNotifierProviderElement<ChatList, List<ChatItemModel>>
  createElement() {
    return _ChatListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatListProvider && other.userId == userId;
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
mixin ChatListRef on AutoDisposeNotifierProviderRef<List<ChatItemModel>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _ChatListProviderElement
    extends AutoDisposeNotifierProviderElement<ChatList, List<ChatItemModel>>
    with ChatListRef {
  _ChatListProviderElement(super.provider);

  @override
  String get userId => (origin as ChatListProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
