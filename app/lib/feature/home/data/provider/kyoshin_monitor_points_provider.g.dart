// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_points_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kyoshinMonitorPoints)
final kyoshinMonitorPointsProvider = KyoshinMonitorPointsProvider._();

final class KyoshinMonitorPointsProvider
    extends
        $FunctionalProvider<
          List<Feature<Point>>,
          List<Feature<Point>>,
          List<Feature<Point>>
        >
    with $Provider<List<Feature<Point>>> {
  KyoshinMonitorPointsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorPointsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorPointsHash();

  @$internal
  @override
  $ProviderElement<List<Feature<Point>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<Feature<Point>> create(Ref ref) {
    return kyoshinMonitorPoints(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Feature<Point>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Feature<Point>>>(value),
    );
  }
}

String _$kyoshinMonitorPointsHash() =>
    r'54556d428791f259ac74a87cc925bb7c5479dbe6';
