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
    extends
        $FunctionalProvider<
          AsyncValue<WebSocket>,
          WebSocket,
          FutureOr<WebSocket>
        >
    with $FutureModifier<WebSocket>, $FutureProvider<WebSocket> {
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
  $FutureProviderElement<WebSocket> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<WebSocket> create(Ref ref) {
    return websocket(ref);
  }
}

String _$websocketHash() => r'47faff894fcc8d2a965a114fd5e647fc4117b1ba';

@ProviderFor(WebsocketStatus)
final websocketStatusProvider = WebsocketStatusProvider._();

final class WebsocketStatusProvider
    extends $StreamNotifierProvider<WebsocketStatus, ConnectionState> {
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
}

String _$websocketStatusHash() => r'67b0bba038065e4ef01b347c94e498ea8c01db6e';

abstract class _$WebsocketStatus extends $StreamNotifier<ConnectionState> {
  Stream<ConnectionState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ConnectionState>, ConnectionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ConnectionState>, ConnectionState>,
              AsyncValue<ConnectionState>,
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

String _$websocketMessagesHash() => r'49e5055d213c85bbf8cea7dbed4725d26524fc52';

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
