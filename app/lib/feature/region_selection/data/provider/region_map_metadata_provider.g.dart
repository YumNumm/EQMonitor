// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'region_map_metadata_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(regionMapMetadata)
final regionMapMetadataProvider = RegionMapMetadataProvider._();

final class RegionMapMetadataProvider
    extends
        $FunctionalProvider<
          AsyncValue<RegionMapMetadata>,
          RegionMapMetadata,
          FutureOr<RegionMapMetadata>
        >
    with
        $FutureModifier<RegionMapMetadata>,
        $FutureProvider<RegionMapMetadata> {
  RegionMapMetadataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'regionMapMetadataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$regionMapMetadataHash();

  @$internal
  @override
  $FutureProviderElement<RegionMapMetadata> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RegionMapMetadata> create(Ref ref) {
    return regionMapMetadata(ref);
  }
}

String _$regionMapMetadataHash() => r'b14983d4af65582d3688d4ad0c97b65226ac08f5';
