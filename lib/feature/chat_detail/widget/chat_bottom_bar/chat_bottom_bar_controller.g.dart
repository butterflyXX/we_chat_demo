// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_bottom_bar_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatBottomBarControllerHash() =>
    r'7fb40974ae09681987572c94f1e11a8ad1fc6a10';

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

abstract class _$ChatBottomBarController
    extends BuildlessAutoDisposeNotifier<ChatBottomBarInputType> {
  late final String chatId;

  ChatBottomBarInputType build(String chatId);
}

/// See also [ChatBottomBarController].
@ProviderFor(ChatBottomBarController)
const chatBottomBarControllerProvider = ChatBottomBarControllerFamily();

/// See also [ChatBottomBarController].
class ChatBottomBarControllerFamily extends Family<ChatBottomBarInputType> {
  /// See also [ChatBottomBarController].
  const ChatBottomBarControllerFamily();

  /// See also [ChatBottomBarController].
  ChatBottomBarControllerProvider call(String chatId) {
    return ChatBottomBarControllerProvider(chatId);
  }

  @override
  ChatBottomBarControllerProvider getProviderOverride(
    covariant ChatBottomBarControllerProvider provider,
  ) {
    return call(provider.chatId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chatBottomBarControllerProvider';
}

/// See also [ChatBottomBarController].
class ChatBottomBarControllerProvider
    extends
        AutoDisposeNotifierProviderImpl<
          ChatBottomBarController,
          ChatBottomBarInputType
        > {
  /// See also [ChatBottomBarController].
  ChatBottomBarControllerProvider(String chatId)
    : this._internal(
        () => ChatBottomBarController()..chatId = chatId,
        from: chatBottomBarControllerProvider,
        name: r'chatBottomBarControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$chatBottomBarControllerHash,
        dependencies: ChatBottomBarControllerFamily._dependencies,
        allTransitiveDependencies:
            ChatBottomBarControllerFamily._allTransitiveDependencies,
        chatId: chatId,
      );

  ChatBottomBarControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatId,
  }) : super.internal();

  final String chatId;

  @override
  ChatBottomBarInputType runNotifierBuild(
    covariant ChatBottomBarController notifier,
  ) {
    return notifier.build(chatId);
  }

  @override
  Override overrideWith(ChatBottomBarController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatBottomBarControllerProvider._internal(
        () => create()..chatId = chatId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatId: chatId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<
    ChatBottomBarController,
    ChatBottomBarInputType
  >
  createElement() {
    return _ChatBottomBarControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatBottomBarControllerProvider && other.chatId == chatId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChatBottomBarControllerRef
    on AutoDisposeNotifierProviderRef<ChatBottomBarInputType> {
  /// The parameter `chatId` of this provider.
  String get chatId;
}

class _ChatBottomBarControllerProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          ChatBottomBarController,
          ChatBottomBarInputType
        >
    with ChatBottomBarControllerRef {
  _ChatBottomBarControllerProviderElement(super.provider);

  @override
  String get chatId => (origin as ChatBottomBarControllerProvider).chatId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
