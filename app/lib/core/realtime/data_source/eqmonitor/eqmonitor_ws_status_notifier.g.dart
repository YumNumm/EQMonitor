// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eqmonitor_ws_status_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// WebSocket の接続状態・ping 情報を保持する keepAlive Notifier。
///
/// phase は [eqmonitorWebSocketProvider] の AsyncValue から導出する。
/// [WsPingMessage] 受信時に pong を返送し、サーバーの ping 送出間隔を [EqMonitorWsStatusState.pingRtt] に記録する。
/// なお pingRtt はネットワーク RTT ではなくサーバーからの ping 受信間隔である点に注意。

@ProviderFor(EqMonitorWsStatus)
final eqMonitorWsStatusProvider = EqMonitorWsStatusProvider._();

/// WebSocket の接続状態・ping 情報を保持する keepAlive Notifier。
///
/// phase は [eqmonitorWebSocketProvider] の AsyncValue から導出する。
/// [WsPingMessage] 受信時に pong を返送し、サーバーの ping 送出間隔を [EqMonitorWsStatusState.pingRtt] に記録する。
/// なお pingRtt はネットワーク RTT ではなくサーバーからの ping 受信間隔である点に注意。
final class EqMonitorWsStatusProvider
    extends $NotifierProvider<EqMonitorWsStatus, EqMonitorWsStatusState> {
  /// WebSocket の接続状態・ping 情報を保持する keepAlive Notifier。
  ///
  /// phase は [eqmonitorWebSocketProvider] の AsyncValue から導出する。
  /// [WsPingMessage] 受信時に pong を返送し、サーバーの ping 送出間隔を [EqMonitorWsStatusState.pingRtt] に記録する。
  /// なお pingRtt はネットワーク RTT ではなくサーバーからの ping 受信間隔である点に注意。
  EqMonitorWsStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eqMonitorWsStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eqMonitorWsStatusHash();

  @$internal
  @override
  EqMonitorWsStatus create() => EqMonitorWsStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EqMonitorWsStatusState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EqMonitorWsStatusState>(value),
    );
  }
}

String _$eqMonitorWsStatusHash() => r'82c1a2269e1bb5c0cbf316255b589c6c648930fb';

/// WebSocket の接続状態・ping 情報を保持する keepAlive Notifier。
///
/// phase は [eqmonitorWebSocketProvider] の AsyncValue から導出する。
/// [WsPingMessage] 受信時に pong を返送し、サーバーの ping 送出間隔を [EqMonitorWsStatusState.pingRtt] に記録する。
/// なお pingRtt はネットワーク RTT ではなくサーバーからの ping 受信間隔である点に注意。

abstract class _$EqMonitorWsStatus extends $Notifier<EqMonitorWsStatusState> {
  EqMonitorWsStatusState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<EqMonitorWsStatusState, EqMonitorWsStatusState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EqMonitorWsStatusState, EqMonitorWsStatusState>,
              EqMonitorWsStatusState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
