// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// EQRP リプレイファイルの再生を司り、再生時刻と各フレームを
/// 本物の表示パイプライン（appClock / [eewProvider] / [kyoshinMonitorProvider]）
/// へ流し込むコントローラ。

@ProviderFor(ReplayNotifier)
final replayProvider = ReplayNotifierProvider._();

/// EQRP リプレイファイルの再生を司り、再生時刻と各フレームを
/// 本物の表示パイプライン（appClock / [eewProvider] / [kyoshinMonitorProvider]）
/// へ流し込むコントローラ。
final class ReplayNotifierProvider
    extends $NotifierProvider<ReplayNotifier, ReplayState?> {
  /// EQRP リプレイファイルの再生を司り、再生時刻と各フレームを
  /// 本物の表示パイプライン（appClock / [eewProvider] / [kyoshinMonitorProvider]）
  /// へ流し込むコントローラ。
  ReplayNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayNotifierHash();

  @$internal
  @override
  ReplayNotifier create() => ReplayNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayState? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayState?>(value),
    );
  }
}

String _$replayNotifierHash() => r'c35b4bbb0b59a581ce0565ccf9f024524865d48e';

/// EQRP リプレイファイルの再生を司り、再生時刻と各フレームを
/// 本物の表示パイプライン（appClock / [eewProvider] / [kyoshinMonitorProvider]）
/// へ流し込むコントローラ。

abstract class _$ReplayNotifier extends $Notifier<ReplayState?> {
  ReplayState? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ReplayState?, ReplayState?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReplayState?, ReplayState?>,
              ReplayState?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
