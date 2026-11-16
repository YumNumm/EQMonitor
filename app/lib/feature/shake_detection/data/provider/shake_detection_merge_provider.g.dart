// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_merge_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 地図・カードに表示する揺れ検知イベント。
///
/// EEW と結合したイベント、期限切れのイベント、設定した表示レベル未満の
/// イベントは含めない。

@ProviderFor(shakeDetectionVisible)
final shakeDetectionVisibleProvider = ShakeDetectionVisibleProvider._();

/// 地図・カードに表示する揺れ検知イベント。
///
/// EEW と結合したイベント、期限切れのイベント、設定した表示レベル未満の
/// イベントは含めない。

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
  /// EEW と結合したイベント、期限切れのイベント、設定した表示レベル未満の
  /// イベントは含めない。
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
    r'd6511d9a2255471308d21249a4f8e3872d2e5746';

/// 地図の自動フォーカスの対象にする揺れ検知イベント。

@ProviderFor(shakeDetectionFocusTargets)
final shakeDetectionFocusTargetsProvider =
    ShakeDetectionFocusTargetsProvider._();

/// 地図の自動フォーカスの対象にする揺れ検知イベント。

final class ShakeDetectionFocusTargetsProvider
    extends
        $FunctionalProvider<
          List<ShakeDetectionEvent>,
          List<ShakeDetectionEvent>,
          List<ShakeDetectionEvent>
        >
    with $Provider<List<ShakeDetectionEvent>> {
  /// 地図の自動フォーカスの対象にする揺れ検知イベント。
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
    r'2f0914f052dfe7433fc7ceabeffd6d00b1e2f5d4';
