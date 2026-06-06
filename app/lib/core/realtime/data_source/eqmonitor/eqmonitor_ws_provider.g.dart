// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eqmonitor_ws_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eqmonitorWebSocket)
final eqmonitorWebSocketProvider = EqmonitorWebSocketProvider._();

final class EqmonitorWebSocketProvider
    extends
        $FunctionalProvider<
          AsyncValue<WebSocket>,
          WebSocket,
          FutureOr<WebSocket>
        >
    with $FutureModifier<WebSocket>, $FutureProvider<WebSocket> {
  EqmonitorWebSocketProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eqmonitorWebSocketProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eqmonitorWebSocketHash();

  @$internal
  @override
  $FutureProviderElement<WebSocket> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<WebSocket> create(Ref ref) {
    return eqmonitorWebSocket(ref);
  }
}

String _$eqmonitorWebSocketHash() =>
    r'd604e71545aae0f39cb2bdeb36b6f19783960284';

@ProviderFor(eqmonitorWsEventStream)
final eqmonitorWsEventStreamProvider = EqmonitorWsEventStreamProvider._();

final class EqmonitorWsEventStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<WebSocketEvent>,
          WebSocketEvent,
          Stream<WebSocketEvent>
        >
    with $FutureModifier<WebSocketEvent>, $StreamProvider<WebSocketEvent> {
  EqmonitorWsEventStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eqmonitorWsEventStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eqmonitorWsEventStreamHash();

  @$internal
  @override
  $StreamProviderElement<WebSocketEvent> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<WebSocketEvent> create(Ref ref) {
    return eqmonitorWsEventStream(ref);
  }
}

String _$eqmonitorWsEventStreamHash() =>
    r'b98526debe804e6b0c87e1c6343db5fe099124f3';

@ProviderFor(eqmonitorWebSocketTicket)
final eqmonitorWebSocketTicketProvider = EqmonitorWebSocketTicketProvider._();

final class EqmonitorWebSocketTicketProvider
    extends
        $FunctionalProvider<
          AsyncValue<RealtimeTicketResponse>,
          RealtimeTicketResponse,
          FutureOr<RealtimeTicketResponse>
        >
    with
        $FutureModifier<RealtimeTicketResponse>,
        $FutureProvider<RealtimeTicketResponse> {
  EqmonitorWebSocketTicketProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eqmonitorWebSocketTicketProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eqmonitorWebSocketTicketHash();

  @$internal
  @override
  $FutureProviderElement<RealtimeTicketResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RealtimeTicketResponse> create(Ref ref) {
    return eqmonitorWebSocketTicket(ref);
  }
}

String _$eqmonitorWebSocketTicketHash() =>
    r'bcde890bcab8766a787ed78a3aac6f2f1220b09b';
