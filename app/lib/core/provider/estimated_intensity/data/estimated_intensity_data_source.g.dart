// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'estimated_intensity_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(estimatedIntensityDataSource)
final estimatedIntensityDataSourceProvider =
    EstimatedIntensityDataSourceProvider._();

final class EstimatedIntensityDataSourceProvider
    extends
        $FunctionalProvider<
          EstimatedIntensityDataSource,
          EstimatedIntensityDataSource,
          EstimatedIntensityDataSource
        >
    with $Provider<EstimatedIntensityDataSource> {
  EstimatedIntensityDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'estimatedIntensityDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$estimatedIntensityDataSourceHash();

  @$internal
  @override
  $ProviderElement<EstimatedIntensityDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EstimatedIntensityDataSource create(Ref ref) {
    return estimatedIntensityDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EstimatedIntensityDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EstimatedIntensityDataSource>(value),
    );
  }
}

String _$estimatedIntensityDataSourceHash() =>
    r'a8dc59d604c60eb6292bd73c63664558890fd43c';
