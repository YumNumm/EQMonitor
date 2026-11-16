// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_region_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 揺れ検知イベントの最大レベルで揺れた都道府県と地域。

@ProviderFor(shakeDetectionEventRegions)
final shakeDetectionEventRegionsProvider = ShakeDetectionEventRegionsFamily._();

/// 揺れ検知イベントの最大レベルで揺れた都道府県と地域。

final class ShakeDetectionEventRegionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ShakeDetectionRegionGroup>>,
          List<ShakeDetectionRegionGroup>,
          FutureOr<List<ShakeDetectionRegionGroup>>
        >
    with
        $FutureModifier<List<ShakeDetectionRegionGroup>>,
        $FutureProvider<List<ShakeDetectionRegionGroup>> {
  /// 揺れ検知イベントの最大レベルで揺れた都道府県と地域。
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
  $FutureProviderElement<List<ShakeDetectionRegionGroup>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ShakeDetectionRegionGroup>> create(Ref ref) {
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
    r'13e9092bb34717393f6366a67e6e04649db6df4a';

/// 揺れ検知イベントの最大レベルで揺れた都道府県と地域。

final class ShakeDetectionEventRegionsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<ShakeDetectionRegionGroup>>,
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

  /// 揺れ検知イベントの最大レベルで揺れた都道府県と地域。

  ShakeDetectionEventRegionsProvider call(ShakeDetectionEvent event) =>
      ShakeDetectionEventRegionsProvider._(argument: event, from: this);

  @override
  String toString() => r'shakeDetectionEventRegionsProvider';
}
