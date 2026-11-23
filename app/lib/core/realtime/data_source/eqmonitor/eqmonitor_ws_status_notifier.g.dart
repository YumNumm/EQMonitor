// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eqmonitor_ws_status_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// WebSocket の接続状態・サーバー起因 ping の受信状況を保持する

@ProviderFor(EqMonitorWsStatus)
final eqMonitorWsStatusProvider = EqMonitorWsStatusProvider._();

/// WebSocket の接続状態・サーバー起因 ping の受信状況を保持する
final class EqMonitorWsStatusProvider
    extends $NotifierProvider<EqMonitorWsStatus, EqMonitorWsStatusState> {
  /// WebSocket の接続状態・サーバー起因 ping の受信状況を保持する
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

String _$eqMonitorWsStatusHash() => r'8f48ea15afa0644b02ffed99aced2284fba5d3fb';

/// WebSocket の接続状態・サーバー起因 ping の受信状況を保持する

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
