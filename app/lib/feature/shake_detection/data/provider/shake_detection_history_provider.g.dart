// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// セッション中に受信したすべての揺れ検知イベントを蓄積するプロバイダー。
/// サーバーの active snapshot から消えたイベントも、履歴からは削除しない。

@ProviderFor(ShakeDetectionHistory)
final shakeDetectionHistoryProvider = ShakeDetectionHistoryProvider._();

/// セッション中に受信したすべての揺れ検知イベントを蓄積するプロバイダー。
/// サーバーの active snapshot から消えたイベントも、履歴からは削除しない。
final class ShakeDetectionHistoryProvider
    extends
        $NotifierProvider<ShakeDetectionHistory, List<ShakeDetectionEvent>> {
  /// セッション中に受信したすべての揺れ検知イベントを蓄積するプロバイダー。
  /// サーバーの active snapshot から消えたイベントも、履歴からは削除しない。
  ShakeDetectionHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionHistoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionHistoryHash();

  @$internal
  @override
  ShakeDetectionHistory create() => ShakeDetectionHistory();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ShakeDetectionEvent> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ShakeDetectionEvent>>(value),
    );
  }
}

String _$shakeDetectionHistoryHash() =>
    r'93366edec4b0b7bf62fccb4dab8d3eeb142e3e06';

/// セッション中に受信したすべての揺れ検知イベントを蓄積するプロバイダー。
/// サーバーの active snapshot から消えたイベントも、履歴からは削除しない。

abstract class _$ShakeDetectionHistory
    extends $Notifier<List<ShakeDetectionEvent>> {
  List<ShakeDetectionEvent> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<List<ShakeDetectionEvent>, List<ShakeDetectionEvent>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<ShakeDetectionEvent>, List<ShakeDetectionEvent>>,
              List<ShakeDetectionEvent>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
