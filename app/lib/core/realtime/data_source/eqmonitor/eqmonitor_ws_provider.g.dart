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
    r'bb214bb74e5d680e4d59ecf9c5ecbf815da812ae';

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
    r'b664af2727103929fdd06f8075ca44149bb8c689';

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
    r'4bd7254baad2946739458c1e5f08eceaebec1dbc';
