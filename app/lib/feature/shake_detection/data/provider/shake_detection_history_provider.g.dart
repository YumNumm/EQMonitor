// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// セッション中に受信したすべての揺れ検知イベントを蓄積するプロバイダー。
/// shakeDetectionProvider（5分で削除）と異なり、クリーンアップしない。

@ProviderFor(ShakeDetectionHistory)
final shakeDetectionHistoryProvider = ShakeDetectionHistoryProvider._();

/// セッション中に受信したすべての揺れ検知イベントを蓄積するプロバイダー。
/// shakeDetectionProvider（5分で削除）と異なり、クリーンアップしない。
final class ShakeDetectionHistoryProvider
    extends
        $NotifierProvider<ShakeDetectionHistory, List<ShakeDetectionEvent>> {
  /// セッション中に受信したすべての揺れ検知イベントを蓄積するプロバイダー。
  /// shakeDetectionProvider（5分で削除）と異なり、クリーンアップしない。
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
    r'828a110f172fad9771f899bdccb4c596f1f29c22';

/// セッション中に受信したすべての揺れ検知イベントを蓄積するプロバイダー。
/// shakeDetectionProvider（5分で削除）と異なり、クリーンアップしない。

abstract class _$ShakeDetectionHistory
    extends $Notifier<List<ShakeDetectionEvent>> {
  List<ShakeDetectionEvent> build();
  @$mustCallSuper
  @override
  void runBuild() {
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
    element.handleCreate(ref, build);
  }
}
