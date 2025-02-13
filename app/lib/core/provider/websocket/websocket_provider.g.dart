// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'websocket_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$websocketHash() => r'cb3408b7a0df5a6b8c4cbe5c07a567970771172a';

/// See also [websocket].
@ProviderFor(websocket)
final websocketProvider = Provider<WebSocket>.internal(
  websocket,
  name: r'websocketProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$websocketHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WebsocketRef = ProviderRef<WebSocket>;
String _$websocketParsedMessagesHash() =>
    r'e0d6a3353d45285f1e3b9489636a6d022eb9be1f';

/// See also [websocketParsedMessages].
@ProviderFor(websocketParsedMessages)
final websocketParsedMessagesProvider =
    StreamProvider<RealtimePostgresChangesPayloadBase>.internal(
      websocketParsedMessages,
      name: r'websocketParsedMessagesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$websocketParsedMessagesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WebsocketParsedMessagesRef =
    StreamProviderRef<RealtimePostgresChangesPayloadBase>;
String _$websocketTableMessagesHash() =>
    r'53916279b0c281a63156b8900900605a867bea1c';

/// See also [websocketTableMessages].
@ProviderFor(websocketTableMessages)
final websocketTableMessagesProvider =
    StreamProvider<RealtimePostgresChangesPayloadTable>.internal(
      websocketTableMessages,
      name: r'websocketTableMessagesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$websocketTableMessagesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WebsocketTableMessagesRef =
    StreamProviderRef<RealtimePostgresChangesPayloadTable>;
String _$websocketStatusHash() => r'9c6c47911232f1770b32d1b13f4364abf4900063';

/// See also [WebsocketStatus].
@ProviderFor(WebsocketStatus)
final websocketStatusProvider =
    NotifierProvider<WebsocketStatus, ConnectionState>.internal(
      WebsocketStatus.new,
      name: r'websocketStatusProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$websocketStatusHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WebsocketStatus = Notifier<ConnectionState>;
String _$websocketMessagesHash() => r'209382a0f1a8fb3231e709d278d154cf462aa4d6';

/// See also [WebsocketMessages].
@ProviderFor(WebsocketMessages)
final websocketMessagesProvider =
    StreamNotifierProvider<WebsocketMessages, Map<String, dynamic>>.internal(
      WebsocketMessages.new,
      name: r'websocketMessagesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$websocketMessagesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WebsocketMessages = StreamNotifier<Map<String, dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
