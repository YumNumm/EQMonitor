// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'eew_hypocenter_layer_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eewHypocenterLayerControllerHash() =>
    r'fab6bcc3fe7379f77aa02fd13f197361d109358e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$EewHypocenterLayerController
    extends BuildlessAutoDisposeNotifier<EewHypocenterLayer> {
  late final EewHypocenterIcon icon;

  EewHypocenterLayer build(
    EewHypocenterIcon icon,
  );
}

/// See also [EewHypocenterLayerController].
@ProviderFor(EewHypocenterLayerController)
const eewHypocenterLayerControllerProvider =
    EewHypocenterLayerControllerFamily();

/// See also [EewHypocenterLayerController].
class EewHypocenterLayerControllerFamily extends Family<EewHypocenterLayer> {
  /// See also [EewHypocenterLayerController].
  const EewHypocenterLayerControllerFamily();

  /// See also [EewHypocenterLayerController].
  EewHypocenterLayerControllerProvider call(
    EewHypocenterIcon icon,
  ) {
    return EewHypocenterLayerControllerProvider(
      icon,
    );
  }

  @override
  EewHypocenterLayerControllerProvider getProviderOverride(
    covariant EewHypocenterLayerControllerProvider provider,
  ) {
    return call(
      provider.icon,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'eewHypocenterLayerControllerProvider';
}

/// See also [EewHypocenterLayerController].
class EewHypocenterLayerControllerProvider
    extends AutoDisposeNotifierProviderImpl<EewHypocenterLayerController,
        EewHypocenterLayer> {
  /// See also [EewHypocenterLayerController].
  EewHypocenterLayerControllerProvider(
    EewHypocenterIcon icon,
  ) : this._internal(
          () => EewHypocenterLayerController()..icon = icon,
          from: eewHypocenterLayerControllerProvider,
          name: r'eewHypocenterLayerControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eewHypocenterLayerControllerHash,
          dependencies: EewHypocenterLayerControllerFamily._dependencies,
          allTransitiveDependencies:
              EewHypocenterLayerControllerFamily._allTransitiveDependencies,
          icon: icon,
        );

  EewHypocenterLayerControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.icon,
  }) : super.internal();

  final EewHypocenterIcon icon;

  @override
  EewHypocenterLayer runNotifierBuild(
    covariant EewHypocenterLayerController notifier,
  ) {
    return notifier.build(
      icon,
    );
  }

  @override
  Override overrideWith(EewHypocenterLayerController Function() create) {
    return ProviderOverride(
      origin: this,
      override: EewHypocenterLayerControllerProvider._internal(
        () => create()..icon = icon,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        icon: icon,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<EewHypocenterLayerController,
      EewHypocenterLayer> createElement() {
    return _EewHypocenterLayerControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EewHypocenterLayerControllerProvider && other.icon == icon;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, icon.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EewHypocenterLayerControllerRef
    on AutoDisposeNotifierProviderRef<EewHypocenterLayer> {
  /// The parameter `icon` of this provider.
  EewHypocenterIcon get icon;
}

class _EewHypocenterLayerControllerProviderElement
    extends AutoDisposeNotifierProviderElement<EewHypocenterLayerController,
        EewHypocenterLayer> with EewHypocenterLayerControllerRef {
  _EewHypocenterLayerControllerProviderElement(super.provider);

  @override
  EewHypocenterIcon get icon =>
      (origin as EewHypocenterLayerControllerProvider).icon;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
