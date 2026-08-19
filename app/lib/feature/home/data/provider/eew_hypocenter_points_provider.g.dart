// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_hypocenter_points_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eewHypocenterPoints)
final eewHypocenterPointsProvider = EewHypocenterPointsProvider._();

final class EewHypocenterPointsProvider
    extends
        $FunctionalProvider<
          List<Feature<Point>>,
          List<Feature<Point>>,
          List<Feature<Point>>
        >
    with $Provider<List<Feature<Point>>> {
  EewHypocenterPointsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewHypocenterPointsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewHypocenterPointsHash();

  @$internal
  @override
  $ProviderElement<List<Feature<Point>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<Feature<Point>> create(Ref ref) {
    return eewHypocenterPoints(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Feature<Point>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Feature<Point>>>(value),
    );
  }
}

String _$eewHypocenterPointsHash() =>
    r'71e0ab2830cefe23f4177a5b31caed4765baba96';
