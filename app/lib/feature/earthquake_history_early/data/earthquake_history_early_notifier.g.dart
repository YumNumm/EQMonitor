// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'earthquake_history_early_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$earthquakeHistoryEarlyNotifierHash() =>
    r'3402547b4988d7480daf743724c7c80a18cb8ea2';

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

abstract class _$EarthquakeHistoryEarlyNotifier
    extends BuildlessAutoDisposeAsyncNotifier<
        EarthquakeHistoryEarlyNotifierState> {
  late final EarthquakeHistoryEarlyParameter parameter;

  FutureOr<EarthquakeHistoryEarlyNotifierState> build(
    EarthquakeHistoryEarlyParameter parameter,
  );
}

/// See also [EarthquakeHistoryEarlyNotifier].
@ProviderFor(EarthquakeHistoryEarlyNotifier)
const earthquakeHistoryEarlyNotifierProvider =
    EarthquakeHistoryEarlyNotifierFamily();

/// See also [EarthquakeHistoryEarlyNotifier].
class EarthquakeHistoryEarlyNotifierFamily extends Family {
  /// See also [EarthquakeHistoryEarlyNotifier].
  const EarthquakeHistoryEarlyNotifierFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'earthquakeHistoryEarlyNotifierProvider';

  /// See also [EarthquakeHistoryEarlyNotifier].
  EarthquakeHistoryEarlyNotifierProvider call(
    EarthquakeHistoryEarlyParameter parameter,
  ) {
    return EarthquakeHistoryEarlyNotifierProvider(
      parameter,
    );
  }

  @visibleForOverriding
  @override
  EarthquakeHistoryEarlyNotifierProvider getProviderOverride(
    covariant EarthquakeHistoryEarlyNotifierProvider provider,
  ) {
    return call(
      provider.parameter,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(EarthquakeHistoryEarlyNotifier Function() create) {
    return _$EarthquakeHistoryEarlyNotifierFamilyOverride(this, create);
  }
}

class _$EarthquakeHistoryEarlyNotifierFamilyOverride implements FamilyOverride {
  _$EarthquakeHistoryEarlyNotifierFamilyOverride(
      this.overriddenFamily, this.create);

  final EarthquakeHistoryEarlyNotifier Function() create;

  @override
  final EarthquakeHistoryEarlyNotifierFamily overriddenFamily;

  @override
  EarthquakeHistoryEarlyNotifierProvider getProviderOverride(
    covariant EarthquakeHistoryEarlyNotifierProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [EarthquakeHistoryEarlyNotifier].
class EarthquakeHistoryEarlyNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<EarthquakeHistoryEarlyNotifier,
        EarthquakeHistoryEarlyNotifierState> {
  /// See also [EarthquakeHistoryEarlyNotifier].
  EarthquakeHistoryEarlyNotifierProvider(
    EarthquakeHistoryEarlyParameter parameter,
  ) : this._internal(
          () => EarthquakeHistoryEarlyNotifier()..parameter = parameter,
          from: earthquakeHistoryEarlyNotifierProvider,
          name: r'earthquakeHistoryEarlyNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$earthquakeHistoryEarlyNotifierHash,
          dependencies: EarthquakeHistoryEarlyNotifierFamily._dependencies,
          allTransitiveDependencies:
              EarthquakeHistoryEarlyNotifierFamily._allTransitiveDependencies,
          parameter: parameter,
        );

  EarthquakeHistoryEarlyNotifierProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.parameter,
  }) : super.internal();

  final EarthquakeHistoryEarlyParameter parameter;

  @override
  FutureOr<EarthquakeHistoryEarlyNotifierState> runNotifierBuild(
    covariant EarthquakeHistoryEarlyNotifier notifier,
  ) {
    return notifier.build(
      parameter,
    );
  }

  @override
  Override overrideWith(EarthquakeHistoryEarlyNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: EarthquakeHistoryEarlyNotifierProvider._internal(
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
  (EarthquakeHistoryEarlyParameter,) get argument {
    return (parameter,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<EarthquakeHistoryEarlyNotifier,
      EarthquakeHistoryEarlyNotifierState> createElement() {
    return _EarthquakeHistoryEarlyNotifierProviderElement(this);
  }

  EarthquakeHistoryEarlyNotifierProvider _copyWith(
    EarthquakeHistoryEarlyNotifier Function() create,
  ) {
    return EarthquakeHistoryEarlyNotifierProvider._internal(
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
    return other is EarthquakeHistoryEarlyNotifierProvider &&
        other.parameter == parameter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, parameter.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EarthquakeHistoryEarlyNotifierRef on AutoDisposeAsyncNotifierProviderRef<
    EarthquakeHistoryEarlyNotifierState> {
  /// The parameter `parameter` of this provider.
  EarthquakeHistoryEarlyParameter get parameter;
}

class _EarthquakeHistoryEarlyNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        EarthquakeHistoryEarlyNotifier, EarthquakeHistoryEarlyNotifierState>
    with EarthquakeHistoryEarlyNotifierRef {
  _EarthquakeHistoryEarlyNotifierProviderElement(super.provider);

  @override
  EarthquakeHistoryEarlyParameter get parameter =>
      (origin as EarthquakeHistoryEarlyNotifierProvider).parameter;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
