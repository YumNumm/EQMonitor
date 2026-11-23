// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_merge_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 有効期限内で、設定した表示レベル以上の揺れ検知イベント。
///
/// EEW と結合したイベントも含む。

@ProviderFor(shakeDetectionActive)
final shakeDetectionActiveProvider = ShakeDetectionActiveProvider._();

/// 有効期限内で、設定した表示レベル以上の揺れ検知イベント。
///
/// EEW と結合したイベントも含む。

final class ShakeDetectionActiveProvider
    extends
        $FunctionalProvider<
          List<ShakeDetectionEvent>,
          List<ShakeDetectionEvent>,
          List<ShakeDetectionEvent>
        >
    with $Provider<List<ShakeDetectionEvent>> {
  /// 有効期限内で、設定した表示レベル以上の揺れ検知イベント。
  ///
  /// EEW と結合したイベントも含む。
  ShakeDetectionActiveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionActiveProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionActiveHash();

  @$internal
  @override
  $ProviderElement<List<ShakeDetectionEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<ShakeDetectionEvent> create(Ref ref) {
    return shakeDetectionActive(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ShakeDetectionEvent> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ShakeDetectionEvent>>(value),
    );
  }
}

String _$shakeDetectionActiveHash() =>
    r'5faeeb8163c24ee9d1efacf8a56d41c287a52267';

/// 地図・カードに表示する揺れ検知イベント。
///
/// EEW と結合したイベントは EEW の表示に任せるため含めない。
/// デバッグ設定で有効にした場合のみ、結合したイベントも含める。

@ProviderFor(shakeDetectionVisible)
final shakeDetectionVisibleProvider = ShakeDetectionVisibleProvider._();

/// 地図・カードに表示する揺れ検知イベント。
///
/// EEW と結合したイベントは EEW の表示に任せるため含めない。
/// デバッグ設定で有効にした場合のみ、結合したイベントも含める。

final class ShakeDetectionVisibleProvider
    extends
        $FunctionalProvider<
          List<ShakeDetectionEvent>,
          List<ShakeDetectionEvent>,
          List<ShakeDetectionEvent>
        >
    with $Provider<List<ShakeDetectionEvent>> {
  /// 地図・カードに表示する揺れ検知イベント。
  ///
  /// EEW と結合したイベントは EEW の表示に任せるため含めない。
  /// デバッグ設定で有効にした場合のみ、結合したイベントも含める。
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
    r'902537183eb970cc5a4b52a27afcb3054b4fd50d';

/// 地図の自動フォーカスの対象にする揺れ検知イベント。
///
/// EEW と結合したイベントも含め、震源と揺れている範囲の両方が収まるようにする。

@ProviderFor(shakeDetectionFocusTargets)
final shakeDetectionFocusTargetsProvider =
    ShakeDetectionFocusTargetsProvider._();

/// 地図の自動フォーカスの対象にする揺れ検知イベント。
///
/// EEW と結合したイベントも含め、震源と揺れている範囲の両方が収まるようにする。

final class ShakeDetectionFocusTargetsProvider
    extends
        $FunctionalProvider<
          List<ShakeDetectionEvent>,
          List<ShakeDetectionEvent>,
          List<ShakeDetectionEvent>
        >
    with $Provider<List<ShakeDetectionEvent>> {
  /// 地図の自動フォーカスの対象にする揺れ検知イベント。
  ///
  /// EEW と結合したイベントも含め、震源と揺れている範囲の両方が収まるようにする。
  ShakeDetectionFocusTargetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionFocusTargetsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionFocusTargetsHash();

  @$internal
  @override
  $ProviderElement<List<ShakeDetectionEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<ShakeDetectionEvent> create(Ref ref) {
    return shakeDetectionFocusTargets(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ShakeDetectionEvent> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ShakeDetectionEvent>>(value),
    );
  }
}

String _$shakeDetectionFocusTargetsHash() =>
    r'dff75396d390c570dfe0c844cde61fd8152673b7';
