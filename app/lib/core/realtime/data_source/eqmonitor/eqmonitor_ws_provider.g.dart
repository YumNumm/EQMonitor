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
    r'a2ec95ca93dd52b41d6b11bf833eb20780645400';

/// WebSocket イベントストリーム。
///
/// ws.events は単一サブスクリプションのため、ここが唯一の subscriber。
/// 接続失敗・切断時に指数バックオフ（1s→最大60s）で再接続する。
/// アプリ resume 時はバックオフをリセットして即座に再接続する。

@ProviderFor(EqmonitorWsEventStream)
final eqmonitorWsEventStreamProvider = EqmonitorWsEventStreamProvider._();

/// WebSocket イベントストリーム。
///
/// ws.events は単一サブスクリプションのため、ここが唯一の subscriber。
/// 接続失敗・切断時に指数バックオフ（1s→最大60s）で再接続する。
/// アプリ resume 時はバックオフをリセットして即座に再接続する。
final class EqmonitorWsEventStreamProvider
    extends $StreamNotifierProvider<EqmonitorWsEventStream, WebSocketEvent> {
  /// WebSocket イベントストリーム。
  ///
  /// ws.events は単一サブスクリプションのため、ここが唯一の subscriber。
  /// 接続失敗・切断時に指数バックオフ（1s→最大60s）で再接続する。
  /// アプリ resume 時はバックオフをリセットして即座に再接続する。
  EqmonitorWsEventStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eqmonitorWsEventStreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eqmonitorWsEventStreamHash();

  @$internal
  @override
  EqmonitorWsEventStream create() => EqmonitorWsEventStream();
}

String _$eqmonitorWsEventStreamHash() =>
    r'd090a5d6007e78467623a68841fcbf33337a8929';

/// WebSocket イベントストリーム。
///
/// ws.events は単一サブスクリプションのため、ここが唯一の subscriber。
/// 接続失敗・切断時に指数バックオフ（1s→最大60s）で再接続する。
/// アプリ resume 時はバックオフをリセットして即座に再接続する。

abstract class _$EqmonitorWsEventStream
    extends $StreamNotifier<WebSocketEvent> {
  Stream<WebSocketEvent> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<WebSocketEvent>, WebSocketEvent>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<WebSocketEvent>, WebSocketEvent>,
              AsyncValue<WebSocketEvent>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

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
    r'47c39d4339fb81572b99acb7d9577eac1f2a2f33';
