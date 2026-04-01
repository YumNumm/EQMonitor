// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_points_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kyoshinMonitorObservationGeoJson)
final kyoshinMonitorObservationGeoJsonProvider =
    KyoshinMonitorObservationGeoJsonProvider._();

final class KyoshinMonitorObservationGeoJsonProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  KyoshinMonitorObservationGeoJsonProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorObservationGeoJsonProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorObservationGeoJsonHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return kyoshinMonitorObservationGeoJson(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$kyoshinMonitorObservationGeoJsonHash() =>
    r'9bbb89a19ab3081240c78d9d1672305ab4dff458';
