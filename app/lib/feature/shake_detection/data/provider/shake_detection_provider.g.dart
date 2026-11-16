// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 端末内で検知した揺れのうち確定したもの。表示中の EEW と結合できたイベントには
/// `correlatedEewEventId` が入る。

@ProviderFor(shakeDetection)
final shakeDetectionProvider = ShakeDetectionProvider._();

/// 端末内で検知した揺れのうち確定したもの。表示中の EEW と結合できたイベントには
/// `correlatedEewEventId` が入る。

final class ShakeDetectionProvider
    extends
        $FunctionalProvider<
          List<ShakeDetectionEvent>,
          List<ShakeDetectionEvent>,
          List<ShakeDetectionEvent>
        >
    with $Provider<List<ShakeDetectionEvent>> {
  /// 端末内で検知した揺れのうち確定したもの。表示中の EEW と結合できたイベントには
  /// `correlatedEewEventId` が入る。
  ShakeDetectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionHash();

  @$internal
  @override
  $ProviderElement<List<ShakeDetectionEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<ShakeDetectionEvent> create(Ref ref) {
    return shakeDetection(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ShakeDetectionEvent> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ShakeDetectionEvent>>(value),
    );
  }
}

String _$shakeDetectionHash() => r'df1b0ff338d3c20f3145bc0d227681e6569ef375';
