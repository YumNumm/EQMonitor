// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'jma_map_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(jmaMap)
final jmaMapProvider = JmaMapProvider._();

final class JmaMapProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<JmaMapType, JmaMap_JmaMapData>>,
          Map<JmaMapType, JmaMap_JmaMapData>,
          FutureOr<Map<JmaMapType, JmaMap_JmaMapData>>
        >
    with
        $FutureModifier<Map<JmaMapType, JmaMap_JmaMapData>>,
        $FutureProvider<Map<JmaMapType, JmaMap_JmaMapData>> {
  JmaMapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jmaMapProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jmaMapHash();

  @$internal
  @override
  $FutureProviderElement<Map<JmaMapType, JmaMap_JmaMapData>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<JmaMapType, JmaMap_JmaMapData>> create(Ref ref) {
    return jmaMap(ref);
  }
}

String _$jmaMapHash() => r'8c7b3c7bfc1bb8730e36e67c0c7a5d3644773974';
