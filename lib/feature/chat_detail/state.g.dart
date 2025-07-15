// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatDetailVMHash() => r'c87687b826c0fe8d91deee6f50e83d001cd35cf9';

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

abstract class _$ChatDetailVM
    extends BuildlessAutoDisposeNotifier<ChatDetailState> {
  late final String chatId;

  ChatDetailState build(String chatId);
}

/// See also [ChatDetailVM].
@ProviderFor(ChatDetailVM)
const chatDetailVMProvider = ChatDetailVMFamily();

/// See also [ChatDetailVM].
class ChatDetailVMFamily extends Family<ChatDetailState> {
  /// See also [ChatDetailVM].
  const ChatDetailVMFamily();

  /// See also [ChatDetailVM].
  ChatDetailVMProvider call(String chatId) {
    return ChatDetailVMProvider(chatId);
  }

  @override
  ChatDetailVMProvider getProviderOverride(
    covariant ChatDetailVMProvider provider,
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
  String? get name => r'chatDetailVMProvider';
}

/// See also [ChatDetailVM].
class ChatDetailVMProvider
    extends AutoDisposeNotifierProviderImpl<ChatDetailVM, ChatDetailState> {
  /// See also [ChatDetailVM].
  ChatDetailVMProvider(String chatId)
    : this._internal(
        () => ChatDetailVM()..chatId = chatId,
        from: chatDetailVMProvider,
        name: r'chatDetailVMProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$chatDetailVMHash,
        dependencies: ChatDetailVMFamily._dependencies,
        allTransitiveDependencies:
            ChatDetailVMFamily._allTransitiveDependencies,
        chatId: chatId,
      );

  ChatDetailVMProvider._internal(
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
  ChatDetailState runNotifierBuild(covariant ChatDetailVM notifier) {
    return notifier.build(chatId);
  }

  @override
  Override overrideWith(ChatDetailVM Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatDetailVMProvider._internal(
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
  AutoDisposeNotifierProviderElement<ChatDetailVM, ChatDetailState>
  createElement() {
    return _ChatDetailVMProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatDetailVMProvider && other.chatId == chatId;
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
mixin ChatDetailVMRef on AutoDisposeNotifierProviderRef<ChatDetailState> {
  /// The parameter `chatId` of this provider.
  String get chatId;
}

class _ChatDetailVMProviderElement
    extends AutoDisposeNotifierProviderElement<ChatDetailVM, ChatDetailState>
    with ChatDetailVMRef {
  _ChatDetailVMProviderElement(super.provider);

  @override
  String get chatId => (origin as ChatDetailVMProvider).chatId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
