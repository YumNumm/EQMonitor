// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_merge_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// EEW 結合済みフラグを付与した揺れ検知イベント一覧

@ProviderFor(shakeDetectionMerged)
final shakeDetectionMergedProvider = ShakeDetectionMergedProvider._();

/// EEW 結合済みフラグを付与した揺れ検知イベント一覧

final class ShakeDetectionMergedProvider
    extends
        $FunctionalProvider<
          List<ShakeDetectionEvent>,
          List<ShakeDetectionEvent>,
          List<ShakeDetectionEvent>
        >
    with $Provider<List<ShakeDetectionEvent>> {
  /// EEW 結合済みフラグを付与した揺れ検知イベント一覧
  ShakeDetectionMergedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionMergedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionMergedHash();

  @$internal
  @override
  $ProviderElement<List<ShakeDetectionEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<ShakeDetectionEvent> create(Ref ref) {
    return shakeDetectionMerged(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ShakeDetectionEvent> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ShakeDetectionEvent>>(value),
    );
  }
}

String _$shakeDetectionMergedHash() =>
    r'3ce6403a2fd5f77a2a67a6a3c05334b0248e8c11';

/// 未結合かつ表示期間内の揺れ検知イベントのみを返す

@ProviderFor(shakeDetectionVisible)
final shakeDetectionVisibleProvider = ShakeDetectionVisibleProvider._();

/// 未結合かつ表示期間内の揺れ検知イベントのみを返す

final class ShakeDetectionVisibleProvider
    extends
        $FunctionalProvider<
          List<ShakeDetectionEvent>,
          List<ShakeDetectionEvent>,
          List<ShakeDetectionEvent>
        >
    with $Provider<List<ShakeDetectionEvent>> {
  /// 未結合かつ表示期間内の揺れ検知イベントのみを返す
  ShakeDetectionVisibleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionVisibleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionVisibleHash();

  @$internal
  @override
  $ProviderElement<List<ShakeDetectionEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<ShakeDetectionEvent> create(Ref ref) {
    return shakeDetectionVisible(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ShakeDetectionEvent> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ShakeDetectionEvent>>(value),
    );
  }
}

String _$shakeDetectionVisibleHash() =>
    r'8102e402ab7705696475cbba7086a3479aa75b19';
