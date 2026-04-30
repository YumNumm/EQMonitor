// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_region_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 揺れ検知イベントのバウンディングボックス内に含まれる観測点の
/// region 文字列を都道府県ごとにグループ化して返す。
///
/// キー: 都道府県名（例: "岩手県"）
/// 値: 地域名のリスト（例: ["沿岸北部", "内陸北部"]）

@ProviderFor(shakeDetectionRegions)
final shakeDetectionRegionsProvider = ShakeDetectionRegionsFamily._();

/// 揺れ検知イベントのバウンディングボックス内に含まれる観測点の
/// region 文字列を都道府県ごとにグループ化して返す。
///
/// キー: 都道府県名（例: "岩手県"）
/// 値: 地域名のリスト（例: ["沿岸北部", "内陸北部"]）

final class ShakeDetectionRegionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, List<String>>>,
          Map<String, List<String>>,
          FutureOr<Map<String, List<String>>>
        >
    with
        $FutureModifier<Map<String, List<String>>>,
        $FutureProvider<Map<String, List<String>>> {
  /// 揺れ検知イベントのバウンディングボックス内に含まれる観測点の
  /// region 文字列を都道府県ごとにグループ化して返す。
  ///
  /// キー: 都道府県名（例: "岩手県"）
  /// 値: 地域名のリスト（例: ["沿岸北部", "内陸北部"]）
  ShakeDetectionRegionsProvider._({
    required ShakeDetectionRegionsFamily super.from,
    required ShakeDetectionEvent super.argument,
  }) : super(
         retry: null,
         name: r'shakeDetectionRegionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionRegionsHash();

  @override
  String toString() {
    return r'shakeDetectionRegionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<String, List<String>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, List<String>>> create(Ref ref) {
    final argument = this.argument as ShakeDetectionEvent;
    return shakeDetectionRegions(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ShakeDetectionRegionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$shakeDetectionRegionsHash() =>
    r'42a90a2e0c925afec52726adefd1ec577a145f28';

/// 揺れ検知イベントのバウンディングボックス内に含まれる観測点の
/// region 文字列を都道府県ごとにグループ化して返す。
///
/// キー: 都道府県名（例: "岩手県"）
/// 値: 地域名のリスト（例: ["沿岸北部", "内陸北部"]）

final class ShakeDetectionRegionsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Map<String, List<String>>>,
          ShakeDetectionEvent
        > {
  ShakeDetectionRegionsFamily._()
    : super(
        retry: null,
        name: r'shakeDetectionRegionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 揺れ検知イベントのバウンディングボックス内に含まれる観測点の
  /// region 文字列を都道府県ごとにグループ化して返す。
  ///
  /// キー: 都道府県名（例: "岩手県"）
  /// 値: 地域名のリスト（例: ["沿岸北部", "内陸北部"]）

  ShakeDetectionRegionsProvider call(ShakeDetectionEvent event) =>
      ShakeDetectionRegionsProvider._(argument: event, from: this);

  @override
  String toString() => r'shakeDetectionRegionsProvider';
}
