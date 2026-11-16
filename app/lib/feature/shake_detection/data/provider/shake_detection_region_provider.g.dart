// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_region_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 揺れ検知イベントの最大レベルで揺れた範囲の要約。
///
/// 観測点の地域コードは地震情報の細分区域で、名前は震度観測点のパラメータから引く。

@ProviderFor(shakeDetectionEventRegions)
final shakeDetectionEventRegionsProvider = ShakeDetectionEventRegionsFamily._();

/// 揺れ検知イベントの最大レベルで揺れた範囲の要約。
///
/// 観測点の地域コードは地震情報の細分区域で、名前は震度観測点のパラメータから引く。

final class ShakeDetectionEventRegionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<ShakeDetectionRegionSummary>,
          ShakeDetectionRegionSummary,
          FutureOr<ShakeDetectionRegionSummary>
        >
    with
        $FutureModifier<ShakeDetectionRegionSummary>,
        $FutureProvider<ShakeDetectionRegionSummary> {
  /// 揺れ検知イベントの最大レベルで揺れた範囲の要約。
  ///
  /// 観測点の地域コードは地震情報の細分区域で、名前は震度観測点のパラメータから引く。
  ShakeDetectionEventRegionsProvider._({
    required ShakeDetectionEventRegionsFamily super.from,
    required ShakeDetectionEvent super.argument,
  }) : super(
         retry: null,
         name: r'shakeDetectionEventRegionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionEventRegionsHash();

  @override
  String toString() {
    return r'shakeDetectionEventRegionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ShakeDetectionRegionSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ShakeDetectionRegionSummary> create(Ref ref) {
    final argument = this.argument as ShakeDetectionEvent;
    return shakeDetectionEventRegions(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ShakeDetectionEventRegionsProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$shakeDetectionEventRegionsHash() =>
    r'02bd877420372b9f11f45a97f9fce8455fa16c13';

/// 揺れ検知イベントの最大レベルで揺れた範囲の要約。
///
/// 観測点の地域コードは地震情報の細分区域で、名前は震度観測点のパラメータから引く。

final class ShakeDetectionEventRegionsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<ShakeDetectionRegionSummary>,
          ShakeDetectionEvent
        > {
  ShakeDetectionEventRegionsFamily._()
    : super(
        retry: null,
        name: r'shakeDetectionEventRegionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 揺れ検知イベントの最大レベルで揺れた範囲の要約。
  ///
  /// 観測点の地域コードは地震情報の細分区域で、名前は震度観測点のパラメータから引く。

  ShakeDetectionEventRegionsProvider call(ShakeDetectionEvent event) =>
      ShakeDetectionEventRegionsProvider._(argument: event, from: this);

  @override
  String toString() => r'shakeDetectionEventRegionsProvider';
}
