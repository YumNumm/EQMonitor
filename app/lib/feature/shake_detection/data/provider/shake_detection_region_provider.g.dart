// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_region_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 揺れ検知の範囲の要約に使う、観測点と地域名の対応。
///
/// 観測点の地域コードは地震情報の細分区域で、名前は震度観測点のパラメータから引く。
/// イベントによらず同じ内容のため、一度だけ読み込んで保持する。

@ProviderFor(shakeDetectionRegionCatalog)
final shakeDetectionRegionCatalogProvider =
    ShakeDetectionRegionCatalogProvider._();

/// 揺れ検知の範囲の要約に使う、観測点と地域名の対応。
///
/// 観測点の地域コードは地震情報の細分区域で、名前は震度観測点のパラメータから引く。
/// イベントによらず同じ内容のため、一度だけ読み込んで保持する。

final class ShakeDetectionRegionCatalogProvider
    extends
        $FunctionalProvider<
          AsyncValue<ShakeDetectionRegionCatalog>,
          ShakeDetectionRegionCatalog,
          FutureOr<ShakeDetectionRegionCatalog>
        >
    with
        $FutureModifier<ShakeDetectionRegionCatalog>,
        $FutureProvider<ShakeDetectionRegionCatalog> {
  /// 揺れ検知の範囲の要約に使う、観測点と地域名の対応。
  ///
  /// 観測点の地域コードは地震情報の細分区域で、名前は震度観測点のパラメータから引く。
  /// イベントによらず同じ内容のため、一度だけ読み込んで保持する。
  ShakeDetectionRegionCatalogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionRegionCatalogProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionRegionCatalogHash();

  @$internal
  @override
  $FutureProviderElement<ShakeDetectionRegionCatalog> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ShakeDetectionRegionCatalog> create(Ref ref) {
    return shakeDetectionRegionCatalog(ref);
  }
}

String _$shakeDetectionRegionCatalogHash() =>
    r'65c3b885e7ed53f4601ed684cb650ae3ae203e93';

/// 揺れ検知イベントの最大レベルで揺れた範囲の要約。対応表が未読込の間は `null`。
///
/// イベントは毎フレーム更新される。非同期にすると更新のたびに読み込み中を
/// 挟み、カードの範囲の行が 1 フレーム消えるため、同期的に計算する。

@ProviderFor(shakeDetectionEventRegions)
final shakeDetectionEventRegionsProvider = ShakeDetectionEventRegionsFamily._();

/// 揺れ検知イベントの最大レベルで揺れた範囲の要約。対応表が未読込の間は `null`。
///
/// イベントは毎フレーム更新される。非同期にすると更新のたびに読み込み中を
/// 挟み、カードの範囲の行が 1 フレーム消えるため、同期的に計算する。

final class ShakeDetectionEventRegionsProvider
    extends
        $FunctionalProvider<
          ShakeDetectionRegionSummary?,
          ShakeDetectionRegionSummary?,
          ShakeDetectionRegionSummary?
        >
    with $Provider<ShakeDetectionRegionSummary?> {
  /// 揺れ検知イベントの最大レベルで揺れた範囲の要約。対応表が未読込の間は `null`。
  ///
  /// イベントは毎フレーム更新される。非同期にすると更新のたびに読み込み中を
  /// 挟み、カードの範囲の行が 1 フレーム消えるため、同期的に計算する。
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
  $ProviderElement<ShakeDetectionRegionSummary?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShakeDetectionRegionSummary? create(Ref ref) {
    final argument = this.argument as ShakeDetectionEvent;
    return shakeDetectionEventRegions(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShakeDetectionRegionSummary? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShakeDetectionRegionSummary?>(value),
    );
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
    r'652efbd513707210e699dd01b2fae373ace975b0';

/// 揺れ検知イベントの最大レベルで揺れた範囲の要約。対応表が未読込の間は `null`。
///
/// イベントは毎フレーム更新される。非同期にすると更新のたびに読み込み中を
/// 挟み、カードの範囲の行が 1 フレーム消えるため、同期的に計算する。

final class ShakeDetectionEventRegionsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          ShakeDetectionRegionSummary?,
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

  /// 揺れ検知イベントの最大レベルで揺れた範囲の要約。対応表が未読込の間は `null`。
  ///
  /// イベントは毎フレーム更新される。非同期にすると更新のたびに読み込み中を
  /// 挟み、カードの範囲の行が 1 フレーム消えるため、同期的に計算する。

  ShakeDetectionEventRegionsProvider call(ShakeDetectionEvent event) =>
      ShakeDetectionEventRegionsProvider._(argument: event, from: this);

  @override
  String toString() => r'shakeDetectionEventRegionsProvider';
}
