// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'travel_time_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(travelTimeDataSource)
const travelTimeDataSourceProvider = TravelTimeDataSourceProvider._();

final class TravelTimeDataSourceProvider
    extends $FunctionalProvider<TravelTimeDataSource, TravelTimeDataSource>
    with $Provider<TravelTimeDataSource> {
  const TravelTimeDataSourceProvider._()
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
      providerOverride: $ValueProvider<TravelTimeDataSource>(value),
    );
  }
}

String _$travelTimeDataSourceHash() =>
    r'0672ad590917e5110439b14dfb400d5652082d8f';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
