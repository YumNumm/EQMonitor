// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'earthquake_history_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$earthquakeV1ExtendedHash() =>
    r'0e75d744275dd72ce35fa905707e3b3c9758308d';

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

/// See also [earthquakeV1Extended].
@ProviderFor(earthquakeV1Extended)
const earthquakeV1ExtendedProvider = EarthquakeV1ExtendedFamily();

/// See also [earthquakeV1Extended].
class EarthquakeV1ExtendedFamily extends Family {
  /// See also [earthquakeV1Extended].
  const EarthquakeV1ExtendedFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'earthquakeV1ExtendedProvider';

  /// See also [earthquakeV1Extended].
  EarthquakeV1ExtendedProvider call(
    EarthquakeV1 data,
  ) {
    return EarthquakeV1ExtendedProvider(
      data,
    );
  }

  @visibleForOverriding
  @override
  EarthquakeV1ExtendedProvider getProviderOverride(
    covariant EarthquakeV1ExtendedProvider provider,
  ) {
    return call(
      provider.data,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<EarthquakeV1Extended> Function(EarthquakeV1ExtendedRef ref)
          create) {
    return _$EarthquakeV1ExtendedFamilyOverride(this, create);
  }
}

class _$EarthquakeV1ExtendedFamilyOverride implements FamilyOverride {
  _$EarthquakeV1ExtendedFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<EarthquakeV1Extended> Function(EarthquakeV1ExtendedRef ref)
      create;

  @override
  final EarthquakeV1ExtendedFamily overriddenFamily;

  @override
  EarthquakeV1ExtendedProvider getProviderOverride(
    covariant EarthquakeV1ExtendedProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [earthquakeV1Extended].
class EarthquakeV1ExtendedProvider
    extends AutoDisposeFutureProvider<EarthquakeV1Extended> {
  /// See also [earthquakeV1Extended].
  EarthquakeV1ExtendedProvider(
    EarthquakeV1 data,
  ) : this._internal(
          (ref) => earthquakeV1Extended(
            ref as EarthquakeV1ExtendedRef,
            data,
          ),
          from: earthquakeV1ExtendedProvider,
          name: r'earthquakeV1ExtendedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$earthquakeV1ExtendedHash,
          dependencies: EarthquakeV1ExtendedFamily._dependencies,
          allTransitiveDependencies:
              EarthquakeV1ExtendedFamily._allTransitiveDependencies,
          data: data,
        );

  EarthquakeV1ExtendedProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.data,
  }) : super.internal();

  final EarthquakeV1 data;

  @override
  Override overrideWith(
    FutureOr<EarthquakeV1Extended> Function(EarthquakeV1ExtendedRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EarthquakeV1ExtendedProvider._internal(
        (ref) => create(ref as EarthquakeV1ExtendedRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        data: data,
      ),
    );
  }

  @override
  (EarthquakeV1,) get argument {
    return (data,);
  }

  @override
  AutoDisposeFutureProviderElement<EarthquakeV1Extended> createElement() {
    return _EarthquakeV1ExtendedProviderElement(this);
  }

  EarthquakeV1ExtendedProvider _copyWith(
    FutureOr<EarthquakeV1Extended> Function(EarthquakeV1ExtendedRef ref) create,
  ) {
    return EarthquakeV1ExtendedProvider._internal(
      (ref) => create(ref as EarthquakeV1ExtendedRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      data: data,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EarthquakeV1ExtendedProvider && other.data == data;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, data.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EarthquakeV1ExtendedRef
    on AutoDisposeFutureProviderRef<EarthquakeV1Extended> {
  /// The parameter `data` of this provider.
  EarthquakeV1 get data;
}

class _EarthquakeV1ExtendedProviderElement
    extends AutoDisposeFutureProviderElement<EarthquakeV1Extended>
    with EarthquakeV1ExtendedRef {
  _EarthquakeV1ExtendedProviderElement(super.provider);

  @override
  EarthquakeV1 get data => (origin as EarthquakeV1ExtendedProvider).data;
}

String _$earthquakeHistoryNotifierHash() =>
    r'b2bc6ab9c72033f805fc7ae772cf8b2365b84997';

abstract class _$EarthquakeHistoryNotifier
    extends BuildlessAutoDisposeAsyncNotifier<EarthquakeHistoryNotifierState> {
  late final EarthquakeHistoryParameter parameter;

  FutureOr<EarthquakeHistoryNotifierState> build(
    EarthquakeHistoryParameter parameter,
  );
}

/// See also [EarthquakeHistoryNotifier].
@ProviderFor(EarthquakeHistoryNotifier)
const earthquakeHistoryNotifierProvider = EarthquakeHistoryNotifierFamily();

/// See also [EarthquakeHistoryNotifier].
class EarthquakeHistoryNotifierFamily extends Family {
  /// See also [EarthquakeHistoryNotifier].
  const EarthquakeHistoryNotifierFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'earthquakeHistoryNotifierProvider';

  /// See also [EarthquakeHistoryNotifier].
  EarthquakeHistoryNotifierProvider call(
    EarthquakeHistoryParameter parameter,
  ) {
    return EarthquakeHistoryNotifierProvider(
      parameter,
    );
  }

  @visibleForOverriding
  @override
  EarthquakeHistoryNotifierProvider getProviderOverride(
    covariant EarthquakeHistoryNotifierProvider provider,
  ) {
    return call(
      provider.parameter,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(EarthquakeHistoryNotifier Function() create) {
    return _$EarthquakeHistoryNotifierFamilyOverride(this, create);
  }
}

class _$EarthquakeHistoryNotifierFamilyOverride implements FamilyOverride {
  _$EarthquakeHistoryNotifierFamilyOverride(this.overriddenFamily, this.create);

  final EarthquakeHistoryNotifier Function() create;

  @override
  final EarthquakeHistoryNotifierFamily overriddenFamily;

  @override
  EarthquakeHistoryNotifierProvider getProviderOverride(
    covariant EarthquakeHistoryNotifierProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [EarthquakeHistoryNotifier].
class EarthquakeHistoryNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<EarthquakeHistoryNotifier,
        EarthquakeHistoryNotifierState> {
  /// See also [EarthquakeHistoryNotifier].
  EarthquakeHistoryNotifierProvider(
    EarthquakeHistoryParameter parameter,
  ) : this._internal(
          () => EarthquakeHistoryNotifier()..parameter = parameter,
          from: earthquakeHistoryNotifierProvider,
          name: r'earthquakeHistoryNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$earthquakeHistoryNotifierHash,
          dependencies: EarthquakeHistoryNotifierFamily._dependencies,
          allTransitiveDependencies:
              EarthquakeHistoryNotifierFamily._allTransitiveDependencies,
          parameter: parameter,
        );

  EarthquakeHistoryNotifierProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.parameter,
  }) : super.internal();

  final EarthquakeHistoryParameter parameter;

  @override
  FutureOr<EarthquakeHistoryNotifierState> runNotifierBuild(
    covariant EarthquakeHistoryNotifier notifier,
  ) {
    return notifier.build(
      parameter,
    );
  }

  @override
  Override overrideWith(EarthquakeHistoryNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: EarthquakeHistoryNotifierProvider._internal(
        () => create()..parameter = parameter,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        parameter: parameter,
      ),
    );
  }

  @override
  (EarthquakeHistoryParameter,) get argument {
    return (parameter,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<EarthquakeHistoryNotifier,
      EarthquakeHistoryNotifierState> createElement() {
    return _EarthquakeHistoryNotifierProviderElement(this);
  }

  EarthquakeHistoryNotifierProvider _copyWith(
    EarthquakeHistoryNotifier Function() create,
  ) {
    return EarthquakeHistoryNotifierProvider._internal(
      () => create()..parameter = parameter,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      parameter: parameter,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EarthquakeHistoryNotifierProvider &&
        other.parameter == parameter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, parameter.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EarthquakeHistoryNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<EarthquakeHistoryNotifierState> {
  /// The parameter `parameter` of this provider.
  EarthquakeHistoryParameter get parameter;
}

class _EarthquakeHistoryNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<EarthquakeHistoryNotifier,
        EarthquakeHistoryNotifierState> with EarthquakeHistoryNotifierRef {
  _EarthquakeHistoryNotifierProviderElement(super.provider);

  @override
  EarthquakeHistoryParameter get parameter =>
      (origin as EarthquakeHistoryNotifierProvider).parameter;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
