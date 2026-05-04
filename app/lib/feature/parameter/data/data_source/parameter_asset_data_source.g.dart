// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'parameter_asset_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(parameterAssetDataSource)
final parameterAssetDataSourceProvider = ParameterAssetDataSourceProvider._();

final class ParameterAssetDataSourceProvider
    extends
        $FunctionalProvider<
          ParameterAssetDataSource,
          ParameterAssetDataSource,
          ParameterAssetDataSource
        >
    with $Provider<ParameterAssetDataSource> {
  ParameterAssetDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parameterAssetDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parameterAssetDataSourceHash();

  @$internal
  @override
  $ProviderElement<ParameterAssetDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ParameterAssetDataSource create(Ref ref) {
    return parameterAssetDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ParameterAssetDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ParameterAssetDataSource>(value),
    );
  }
}

String _$parameterAssetDataSourceHash() =>
    r'09a70d25b33baf8510574fe3298ed9d7f9b3da2a';
