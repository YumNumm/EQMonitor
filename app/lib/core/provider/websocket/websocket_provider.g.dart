// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'websocket_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$websocketHash() => r'6faaaeaa4aafed72504f15896ed0c79e4877c2b3';

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

typedef WebsocketRef = ProviderRef<WebSocket>;
String _$websocketStatusHash() => r'7f199af406e0d7998f53615c616e41470b0f1eff';

/// See also [websocketStatus].
@ProviderFor(websocketStatus)
final websocketStatusProvider = AutoDisposeProvider<ConnectionState>.internal(
  websocketStatus,
  name: r'websocketStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$websocketStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WebsocketStatusRef = AutoDisposeProviderRef<ConnectionState>;
String _$websocketMessagesHash() => r'231000da2b9ef04c6cce2814a67651c9cfeea4de';

/// See also [websocketMessages].
@ProviderFor(websocketMessages)
final websocketMessagesProvider =
    AutoDisposeStreamProvider<Map<String, dynamic>>.internal(
  websocketMessages,
  name: r'websocketMessagesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$websocketMessagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WebsocketMessagesRef
    = AutoDisposeStreamProviderRef<Map<String, dynamic>>;
String _$websocketParsedMessagesHash() =>
    r'b978f3a89cb132ddc28779f9cc05f1c70c4639ab';

/// See also [websocketParsedMessages].
@ProviderFor(websocketParsedMessages)
final websocketParsedMessagesProvider =
    AutoDisposeStreamProvider<RealtimePostgresChangesPayloadBase>.internal(
  websocketParsedMessages,
  name: r'websocketParsedMessagesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$websocketParsedMessagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WebsocketParsedMessagesRef
    = AutoDisposeStreamProviderRef<RealtimePostgresChangesPayloadBase>;
String _$realtimePostgresChangesPayloadTableMessageHash() =>
    r'21037c3c37433c1968cf8ee1b3ae72e785db899f';

/// See also [realtimePostgresChangesPayloadTableMessage].
@ProviderFor(realtimePostgresChangesPayloadTableMessage)
final realtimePostgresChangesPayloadTableMessageProvider =
    AutoDisposeStreamProvider<RealtimePostgresChangesPayloadTable>.internal(
  realtimePostgresChangesPayloadTableMessage,
  name: r'realtimePostgresChangesPayloadTableMessageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$realtimePostgresChangesPayloadTableMessageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RealtimePostgresChangesPayloadTableMessageRef<T extends V1Database>
    = AutoDisposeStreamProviderRef<RealtimePostgresChangesPayloadTable<T>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
