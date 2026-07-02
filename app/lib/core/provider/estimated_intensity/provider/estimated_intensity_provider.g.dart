// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'estimated_intensity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EstimatedIntensity)
final estimatedIntensityProvider = EstimatedIntensityProvider._();

final class EstimatedIntensityProvider
    extends
        $AsyncNotifierProvider<
          EstimatedIntensity,
          List<EstimatedIntensityPoint>
        > {
  EstimatedIntensityProvider._()
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
    r'4ee4711d1fda87afcf37419f0659a942a9aacc9b';

abstract class _$EstimatedIntensity
    extends $AsyncNotifier<List<EstimatedIntensityPoint>> {
  FutureOr<List<EstimatedIntensityPoint>> build();
  @$mustCallSuper
  @override
  void runBuild() {
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
    element.handleCreate(ref, build);
  }
}

@ProviderFor(estimatedIntensityCity)
final estimatedIntensityCityProvider = EstimatedIntensityCityProvider._();

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
  EstimatedIntensityCityProvider._()
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
final estimatedIntensityRegionProvider = EstimatedIntensityRegionProvider._();

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
  EstimatedIntensityRegionProvider._()
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
    r'f19dde479df6980a12d1c76c937a707400ef7bc1';
