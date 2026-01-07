// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'websocket_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(websocket)
final websocketProvider = WebsocketProvider._();

final class WebsocketProvider
    extends $FunctionalProvider<WebSocket, WebSocket, WebSocket>
    with $Provider<WebSocket> {
  WebsocketProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'websocketProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$websocketHash();

  @$internal
  @override
  $ProviderElement<WebSocket> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WebSocket create(Ref ref) {
    return websocket(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebSocket value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebSocket>(value),
    );
  }
}

String _$websocketHash() => r'cb3408b7a0df5a6b8c4cbe5c07a567970771172a';

@ProviderFor(WebsocketStatus)
final websocketStatusProvider = WebsocketStatusProvider._();

final class WebsocketStatusProvider
    extends $NotifierProvider<WebsocketStatus, ConnectionState> {
  WebsocketStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'websocketStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$websocketStatusHash();

  @$internal
  @override
  WebsocketStatus create() => WebsocketStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConnectionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConnectionState>(value),
    );
  }
}

String _$websocketStatusHash() => r'9c6c47911232f1770b32d1b13f4364abf4900063';

abstract class _$WebsocketStatus extends $Notifier<ConnectionState> {
  ConnectionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ConnectionState, ConnectionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ConnectionState, ConnectionState>,
              ConnectionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(WebsocketMessages)
final websocketMessagesProvider = WebsocketMessagesProvider._();

final class WebsocketMessagesProvider
    extends $StreamNotifierProvider<WebsocketMessages, Map<String, dynamic>> {
  WebsocketMessagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'websocketMessagesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$websocketMessagesHash();

  @$internal
  @override
  WebsocketMessages create() => WebsocketMessages();
}

String _$websocketMessagesHash() => r'16cf86bb5810b07fac6e2bac65de369b306f6d9c';

abstract class _$WebsocketMessages
    extends $StreamNotifier<Map<String, dynamic>> {
  Stream<Map<String, dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<Map<String, dynamic>>, Map<String, dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, dynamic>>,
                Map<String, dynamic>
              >,
              AsyncValue<Map<String, dynamic>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
