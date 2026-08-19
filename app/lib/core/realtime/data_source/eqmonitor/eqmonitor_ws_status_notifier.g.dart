// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eqmonitor_ws_status_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// WebSocket の接続状態・サーバー起因 ping の受信状況を保持する keepAlive Notifier。
///
/// phase は [eqmonitorWebSocketProvider] の AsyncValue から導出する。
/// [WsPingMessage] 受信時に最終 ping 時刻と ping 受信間隔を記録する。
///
/// ここが持つのはサーバー起因 ping の観測値だけで、ネットワーク RTT ではない。
/// RTT はクライアント起因 ping を送出する `eqmonitorWsPingProbeProvider` が持つ。

@ProviderFor(EqMonitorWsStatus)
final eqMonitorWsStatusProvider = EqMonitorWsStatusProvider._();

/// WebSocket の接続状態・サーバー起因 ping の受信状況を保持する keepAlive Notifier。
///
/// phase は [eqmonitorWebSocketProvider] の AsyncValue から導出する。
/// [WsPingMessage] 受信時に最終 ping 時刻と ping 受信間隔を記録する。
///
/// ここが持つのはサーバー起因 ping の観測値だけで、ネットワーク RTT ではない。
/// RTT はクライアント起因 ping を送出する `eqmonitorWsPingProbeProvider` が持つ。
final class EqMonitorWsStatusProvider
    extends $NotifierProvider<EqMonitorWsStatus, EqMonitorWsStatusState> {
  /// WebSocket の接続状態・サーバー起因 ping の受信状況を保持する keepAlive Notifier。
  ///
  /// phase は [eqmonitorWebSocketProvider] の AsyncValue から導出する。
  /// [WsPingMessage] 受信時に最終 ping 時刻と ping 受信間隔を記録する。
  ///
  /// ここが持つのはサーバー起因 ping の観測値だけで、ネットワーク RTT ではない。
  /// RTT はクライアント起因 ping を送出する `eqmonitorWsPingProbeProvider` が持つ。
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

String _$eqMonitorWsStatusHash() => r'a01bd369d9c482ec697dfbaa0fd27d40310a0e1e';

/// WebSocket の接続状態・サーバー起因 ping の受信状況を保持する keepAlive Notifier。
///
/// phase は [eqmonitorWebSocketProvider] の AsyncValue から導出する。
/// [WsPingMessage] 受信時に最終 ping 時刻と ping 受信間隔を記録する。
///
/// ここが持つのはサーバー起因 ping の観測値だけで、ネットワーク RTT ではない。
/// RTT はクライアント起因 ping を送出する `eqmonitorWsPingProbeProvider` が持つ。

abstract class _$EqMonitorWsStatus extends $Notifier<EqMonitorWsStatusState> {
  EqMonitorWsStatusState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
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
    return element.handleCreate(ref, build);
  }
}
