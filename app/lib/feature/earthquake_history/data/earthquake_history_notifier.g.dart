// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'earthquake_history_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$earthquakeHistoryNotifierHash() =>
    r'0558495367cf559e0a8f2f28015969529fb40043';

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

abstract class _$EarthquakeHistoryNotifier
    extends BuildlessAutoDisposeAsyncNotifier<
        (List<EarthquakeV1Extended>, int totalCount)> {
  late final EarthquakeHistoryParameter parameter;

  FutureOr<(List<EarthquakeV1Extended>, int totalCount)> build(
    EarthquakeHistoryParameter parameter,
  );
}

/// See also [EarthquakeHistoryNotifier].
@ProviderFor(EarthquakeHistoryNotifier)
const earthquakeHistoryNotifierProvider = EarthquakeHistoryNotifierFamily();

/// See also [EarthquakeHistoryNotifier].
class EarthquakeHistoryNotifierFamily
    extends Family<AsyncValue<(List<EarthquakeV1Extended>, int totalCount)>> {
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
        (List<EarthquakeV1Extended>, int totalCount)> {
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
  FutureOr<(List<EarthquakeV1Extended>, int totalCount)> runNotifierBuild(
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
      (List<EarthquakeV1Extended>, int totalCount)> createElement() {
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

mixin EarthquakeHistoryNotifierRef on AutoDisposeAsyncNotifierProviderRef<
    (List<EarthquakeV1Extended>, int totalCount)> {
  /// The parameter `parameter` of this provider.
  EarthquakeHistoryParameter get parameter;
}

class _EarthquakeHistoryNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<EarthquakeHistoryNotifier,
        (List<EarthquakeV1Extended>, int totalCount)>
    with EarthquakeHistoryNotifierRef {
  _EarthquakeHistoryNotifierProviderElement(super.provider);

  @override
  EarthquakeHistoryParameter get parameter =>
      (origin as EarthquakeHistoryNotifierProvider).parameter;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
