// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'travel_time_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(travelTimeDataSource)
final travelTimeDataSourceProvider = TravelTimeDataSourceProvider._();

final class TravelTimeDataSourceProvider
    extends
        $FunctionalProvider<
          TravelTimeDataSource,
          TravelTimeDataSource,
          TravelTimeDataSource
        >
    with $Provider<TravelTimeDataSource> {
  TravelTimeDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'travelTimeDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$travelTimeDataSourceHash();

  @$internal
  @override
  $ProviderElement<TravelTimeDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TravelTimeDataSource create(Ref ref) {
    return travelTimeDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TravelTimeDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TravelTimeDataSource>(value),
    );
  }
}

String _$travelTimeDataSourceHash() =>
    r'0672ad590917e5110439b14dfb400d5652082d8f';
