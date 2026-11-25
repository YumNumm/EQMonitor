// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// EQRP リプレイファイルと強震モニタの過去画像の再生を司り、再生時刻と各フレームを
/// 本物の表示パイプライン（appClock / [eewProvider] / [kyoshinMonitorProvider]）
/// へ流し込むコントローラ。

@ProviderFor(ReplayNotifier)
final replayProvider = ReplayNotifierProvider._();

/// EQRP リプレイファイルと強震モニタの過去画像の再生を司り、再生時刻と各フレームを
/// 本物の表示パイプライン（appClock / [eewProvider] / [kyoshinMonitorProvider]）
/// へ流し込むコントローラ。
final class ReplayNotifierProvider
    extends $NotifierProvider<ReplayNotifier, ReplayState?> {
  /// EQRP リプレイファイルと強震モニタの過去画像の再生を司り、再生時刻と各フレームを
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

String _$replayNotifierHash() => r'd7f854b56c86fcf78a1431bc903a6140fc2c0aeb';

/// EQRP リプレイファイルと強震モニタの過去画像の再生を司り、再生時刻と各フレームを
/// 本物の表示パイプライン（appClock / [eewProvider] / [kyoshinMonitorProvider]）
/// へ流し込むコントローラ。

abstract class _$ReplayNotifier extends $Notifier<ReplayState?> {
  ReplayState? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ReplayState?, ReplayState?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReplayState?, ReplayState?>,
              ReplayState?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
