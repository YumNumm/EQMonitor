// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'map_style_util.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mapStyleUtil)
final mapStyleUtilProvider = MapStyleUtilProvider._();

final class MapStyleUtilProvider
    extends $FunctionalProvider<MapStyleUtil, MapStyleUtil, MapStyleUtil>
    with $Provider<MapStyleUtil> {
  MapStyleUtilProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapStyleUtilProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapStyleUtilHash();

  @$internal
  @override
  $ProviderElement<MapStyleUtil> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MapStyleUtil create(Ref ref) {
    return mapStyleUtil(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapStyleUtil value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapStyleUtil>(value),
    );
  }
}

String _$mapStyleUtilHash() => r'05c10dc5205b4e5891b3c211b5dc9564f5929b0f';
