// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'websocket_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(websocket)
const websocketProvider = WebsocketProvider._();

final class WebsocketProvider extends $FunctionalProvider<WebSocket, WebSocket>
    with $Provider<WebSocket> {
  const WebsocketProvider._()
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
      providerOverride: $ValueProvider<WebSocket>(value),
    );
  }
}

String _$websocketHash() => r'cb3408b7a0df5a6b8c4cbe5c07a567970771172a';

@ProviderFor(WebsocketStatus)
const websocketStatusProvider = WebsocketStatusProvider._();

final class WebsocketStatusProvider
    extends $NotifierProvider<WebsocketStatus, ConnectionState> {
  const WebsocketStatusProvider._()
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

  @$internal
  @override
  $NotifierProviderElement<WebsocketStatus, ConnectionState> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConnectionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<ConnectionState>(value),
    );
  }
}

String _$websocketStatusHash() => r'9c6c47911232f1770b32d1b13f4364abf4900063';

abstract class _$WebsocketStatus extends $Notifier<ConnectionState> {
  ConnectionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ConnectionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ConnectionState>,
              ConnectionState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(WebsocketMessages)
const websocketMessagesProvider = WebsocketMessagesProvider._();

final class WebsocketMessagesProvider
    extends $StreamNotifierProvider<WebsocketMessages, Map<String, dynamic>> {
  const WebsocketMessagesProvider._()
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

  @$internal
  @override
  $StreamNotifierProviderElement<WebsocketMessages, Map<String, dynamic>>
  $createElement($ProviderPointer pointer) =>
      $StreamNotifierProviderElement(pointer);
}

String _$websocketMessagesHash() => r'16cf86bb5810b07fac6e2bac65de369b306f6d9c';

abstract class _$WebsocketMessages
    extends $StreamNotifier<Map<String, dynamic>> {
  Stream<Map<String, dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Map<String, dynamic>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Map<String, dynamic>>>,
              AsyncValue<Map<String, dynamic>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(websocketParsedMessages)
const websocketParsedMessagesProvider = WebsocketParsedMessagesProvider._();

final class WebsocketParsedMessagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<RealtimePostgresChangesPayloadBase>,
          Stream<RealtimePostgresChangesPayloadBase>
        >
    with
        $FutureModifier<RealtimePostgresChangesPayloadBase>,
        $StreamProvider<RealtimePostgresChangesPayloadBase> {
  const WebsocketParsedMessagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'websocketParsedMessagesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$websocketParsedMessagesHash();

  @$internal
  @override
  $StreamProviderElement<RealtimePostgresChangesPayloadBase> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<RealtimePostgresChangesPayloadBase> create(Ref ref) {
    return websocketParsedMessages(ref);
  }
}

String _$websocketParsedMessagesHash() =>
    r'e0d6a3353d45285f1e3b9489636a6d022eb9be1f';

@ProviderFor(websocketTableMessages)
const websocketTableMessagesProvider = WebsocketTableMessagesProvider._();

final class WebsocketTableMessagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<RealtimePostgresChangesPayloadTable>,
          Stream<RealtimePostgresChangesPayloadTable>
        >
    with
        $FutureModifier<RealtimePostgresChangesPayloadTable>,
        $StreamProvider<RealtimePostgresChangesPayloadTable> {
  const WebsocketTableMessagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'websocketTableMessagesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$websocketTableMessagesHash();

  @$internal
  @override
  $StreamProviderElement<RealtimePostgresChangesPayloadTable> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<RealtimePostgresChangesPayloadTable> create(Ref ref) {
    return websocketTableMessages(ref);
  }
}

String _$websocketTableMessagesHash() =>
    r'53916279b0c281a63156b8900900605a867bea1c';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
