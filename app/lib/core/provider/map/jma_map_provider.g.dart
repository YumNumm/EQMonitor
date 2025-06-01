// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'jma_map_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(jmaMap)
const jmaMapProvider = JmaMapProvider._();

final class JmaMapProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<JmaMapType, JmaMap_JmaMapData>>,
          FutureOr<Map<JmaMapType, JmaMap_JmaMapData>>
        >
    with
        $FutureModifier<Map<JmaMapType, JmaMap_JmaMapData>>,
        $FutureProvider<Map<JmaMapType, JmaMap_JmaMapData>> {
  const JmaMapProvider._()
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

String _$jmaMapHash() => r'66b616db96254fccfe0395f10acb8e5f759d03ba';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
