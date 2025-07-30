// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'estimated_intensity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(EstimatedIntensity)
const estimatedIntensityProvider = EstimatedIntensityProvider._();

final class EstimatedIntensityProvider
    extends
        $AsyncNotifierProvider<
          EstimatedIntensity,
          List<EstimatedIntensityPoint>
        > {
  const EstimatedIntensityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'estimatedIntensityProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$estimatedIntensityHash();

  @$internal
  @override
  EstimatedIntensity create() => EstimatedIntensity();
}

String _$estimatedIntensityHash() =>
    r'd60154c92ffedbd45ee522e8f26d8000cc8c74fd';

abstract class _$EstimatedIntensity
    extends $AsyncNotifier<List<EstimatedIntensityPoint>> {
  FutureOr<List<EstimatedIntensityPoint>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<EstimatedIntensityPoint>>,
              List<EstimatedIntensityPoint>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<EstimatedIntensityPoint>>,
                List<EstimatedIntensityPoint>
              >,
              AsyncValue<List<EstimatedIntensityPoint>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(estimatedIntensityCity)
const estimatedIntensityCityProvider = EstimatedIntensityCityProvider._();

final class EstimatedIntensityCityProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, double>>,
          Map<String, double>,
          Stream<Map<String, double>>
        >
    with
        $FutureModifier<Map<String, double>>,
        $StreamProvider<Map<String, double>> {
  const EstimatedIntensityCityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'estimatedIntensityCityProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$estimatedIntensityCityHash();

  @$internal
  @override
  $StreamProviderElement<Map<String, double>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Map<String, double>> create(Ref ref) {
    return estimatedIntensityCity(ref);
  }
}

String _$estimatedIntensityCityHash() =>
    r'd260dc423fc1c3c73e9ce87ab6e57ac836789ae0';

@ProviderFor(estimatedIntensityRegion)
const estimatedIntensityRegionProvider = EstimatedIntensityRegionProvider._();

final class EstimatedIntensityRegionProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, double>>,
          Map<String, double>,
          Stream<Map<String, double>>
        >
    with
        $FutureModifier<Map<String, double>>,
        $StreamProvider<Map<String, double>> {
  const EstimatedIntensityRegionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'estimatedIntensityRegionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$estimatedIntensityRegionHash();

  @$internal
  @override
  $StreamProviderElement<Map<String, double>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Map<String, double>> create(Ref ref) {
    return estimatedIntensityRegion(ref);
  }
}

String _$estimatedIntensityRegionHash() =>
    r'9d8f0d110d42dace397d6484c8079b9e3fe4f397';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
