// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'eew_estimated_intensity_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eewEstimatedIntensityLayerControllerHash() =>
    r'e7d1b6f1913930349b3a31fb5d84a4ff0e7cd30b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash =
        0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff &
        (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$EewEstimatedIntensityLayerController
    extends BuildlessNotifier<EewEstimatedIntensityLayer> {
  late final JmaForecastIntensity intensity;

  EewEstimatedIntensityLayer build(
    JmaForecastIntensity intensity,
  );
}

/// See also [EewEstimatedIntensityLayerController].
@ProviderFor(EewEstimatedIntensityLayerController)
const eewEstimatedIntensityLayerControllerProvider =
    EewEstimatedIntensityLayerControllerFamily();

/// See also [EewEstimatedIntensityLayerController].
class EewEstimatedIntensityLayerControllerFamily
    extends Family<EewEstimatedIntensityLayer> {
  /// See also [EewEstimatedIntensityLayerController].
  const EewEstimatedIntensityLayerControllerFamily();

  /// See also [EewEstimatedIntensityLayerController].
  EewEstimatedIntensityLayerControllerProvider call(
    JmaForecastIntensity intensity,
  ) {
    return EewEstimatedIntensityLayerControllerProvider(
      intensity,
    );
  }

  @override
  EewEstimatedIntensityLayerControllerProvider
  getProviderOverride(
    covariant EewEstimatedIntensityLayerControllerProvider
    provider,
  ) {
    return call(provider.intensity);
  }

  static const Iterable<ProviderOrFamily>? _dependencies =
      null;

  @override
  Iterable<ProviderOrFamily>? get dependencies =>
      _dependencies;

  static const Iterable<ProviderOrFamily>?
  _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>?
  get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name =>
      r'eewEstimatedIntensityLayerControllerProvider';
}

/// See also [EewEstimatedIntensityLayerController].
class EewEstimatedIntensityLayerControllerProvider
    extends
        NotifierProviderImpl<
          EewEstimatedIntensityLayerController,
          EewEstimatedIntensityLayer
        > {
  /// See also [EewEstimatedIntensityLayerController].
  EewEstimatedIntensityLayerControllerProvider(
    JmaForecastIntensity intensity,
  ) : this._internal(
        () =>
            EewEstimatedIntensityLayerController()
              ..intensity = intensity,
        from: eewEstimatedIntensityLayerControllerProvider,
        name:
            r'eewEstimatedIntensityLayerControllerProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$eewEstimatedIntensityLayerControllerHash,
        dependencies:
            EewEstimatedIntensityLayerControllerFamily
                ._dependencies,
        allTransitiveDependencies:
            EewEstimatedIntensityLayerControllerFamily
                ._allTransitiveDependencies,
        intensity: intensity,
      );

  EewEstimatedIntensityLayerControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.intensity,
  }) : super.internal();

  final JmaForecastIntensity intensity;

  @override
  EewEstimatedIntensityLayer runNotifierBuild(
    covariant EewEstimatedIntensityLayerController notifier,
  ) {
    return notifier.build(intensity);
  }

  @override
  Override overrideWith(
    EewEstimatedIntensityLayerController Function() create,
  ) {
    return ProviderOverride(
      origin: this,
      override:
          EewEstimatedIntensityLayerControllerProvider._internal(
            () => create()..intensity = intensity,
            from: from,
            name: null,
            dependencies: null,
            allTransitiveDependencies: null,
            debugGetCreateSourceHash: null,
            intensity: intensity,
          ),
    );
  }

  @override
  NotifierProviderElement<
    EewEstimatedIntensityLayerController,
    EewEstimatedIntensityLayer
  >
  createElement() {
    return _EewEstimatedIntensityLayerControllerProviderElement(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return other
            is EewEstimatedIntensityLayerControllerProvider &&
        other.intensity == intensity;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, intensity.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EewEstimatedIntensityLayerControllerRef
    on NotifierProviderRef<EewEstimatedIntensityLayer> {
  /// The parameter `intensity` of this provider.
  JmaForecastIntensity get intensity;
}

class _EewEstimatedIntensityLayerControllerProviderElement
    extends
        NotifierProviderElement<
          EewEstimatedIntensityLayerController,
          EewEstimatedIntensityLayer
        >
    with EewEstimatedIntensityLayerControllerRef {
  _EewEstimatedIntensityLayerControllerProviderElement(
    super.provider,
  );

  @override
  JmaForecastIntensity get intensity =>
      (origin as EewEstimatedIntensityLayerControllerProvider)
          .intensity;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
