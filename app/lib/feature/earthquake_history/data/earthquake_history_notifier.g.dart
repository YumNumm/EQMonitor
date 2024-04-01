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
class EarthquakeV1ExtendedFamily
    extends Family<AsyncValue<EarthquakeV1Extended>> {
  /// See also [earthquakeV1Extended].
  const EarthquakeV1ExtendedFamily();

  /// See also [earthquakeV1Extended].
  EarthquakeV1ExtendedProvider call(
    EarthquakeV1 data,
  ) {
    return EarthquakeV1ExtendedProvider(
      data,
    );
  }

  @override
  EarthquakeV1ExtendedProvider getProviderOverride(
    covariant EarthquakeV1ExtendedProvider provider,
  ) {
    return call(
      provider.data,
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
  String? get name => r'earthquakeV1ExtendedProvider';
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
    super._createNotifier, {
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
    FutureOr<EarthquakeV1Extended> Function(EarthquakeV1ExtendedRef provider)
        create,
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
  AutoDisposeFutureProviderElement<EarthquakeV1Extended> createElement() {
    return _EarthquakeV1ExtendedProviderElement(this);
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
    r'89f651d42728dc94a396c3d5ea5063a0f63c0762';

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
class EarthquakeHistoryNotifierFamily
    extends Family<AsyncValue<EarthquakeHistoryNotifierState>> {
  /// See also [EarthquakeHistoryNotifier].
  const EarthquakeHistoryNotifierFamily();

  /// See also [EarthquakeHistoryNotifier].
  EarthquakeHistoryNotifierProvider call(
    EarthquakeHistoryParameter parameter,
  ) {
    return EarthquakeHistoryNotifierProvider(
      parameter,
    );
  }

  @override
  EarthquakeHistoryNotifierProvider getProviderOverride(
    covariant EarthquakeHistoryNotifierProvider provider,
  ) {
    return call(
      provider.parameter,
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
  String? get name => r'earthquakeHistoryNotifierProvider';
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
    super._createNotifier, {
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
  AutoDisposeAsyncNotifierProviderElement<EarthquakeHistoryNotifier,
      EarthquakeHistoryNotifierState> createElement() {
    return _EarthquakeHistoryNotifierProviderElement(this);
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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
