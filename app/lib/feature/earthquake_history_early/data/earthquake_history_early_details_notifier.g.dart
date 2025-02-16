// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'earthquake_history_early_details_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$earthquakeHistoryEarlyEventHash() =>
    r'45706d786f53b6d4c9396fbe2ac974d757ec1014';

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

/// See also [earthquakeHistoryEarlyEvent].
@ProviderFor(earthquakeHistoryEarlyEvent)
const earthquakeHistoryEarlyEventProvider =
    EarthquakeHistoryEarlyEventFamily();

/// See also [earthquakeHistoryEarlyEvent].
class EarthquakeHistoryEarlyEventFamily
    extends Family<AsyncValue<EarthquakeEarlyEvent>> {
  /// See also [earthquakeHistoryEarlyEvent].
  const EarthquakeHistoryEarlyEventFamily();

  /// See also [earthquakeHistoryEarlyEvent].
  EarthquakeHistoryEarlyEventProvider call(String id) {
    return EarthquakeHistoryEarlyEventProvider(id);
  }

  @override
  EarthquakeHistoryEarlyEventProvider getProviderOverride(
    covariant EarthquakeHistoryEarlyEventProvider provider,
  ) {
    return call(provider.id);
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
      r'earthquakeHistoryEarlyEventProvider';
}

/// See also [earthquakeHistoryEarlyEvent].
class EarthquakeHistoryEarlyEventProvider
    extends
        AutoDisposeFutureProvider<EarthquakeEarlyEvent> {
  /// See also [earthquakeHistoryEarlyEvent].
  EarthquakeHistoryEarlyEventProvider(String id)
    : this._internal(
        (ref) => earthquakeHistoryEarlyEvent(
          ref as EarthquakeHistoryEarlyEventRef,
          id,
        ),
        from: earthquakeHistoryEarlyEventProvider,
        name: r'earthquakeHistoryEarlyEventProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$earthquakeHistoryEarlyEventHash,
        dependencies:
            EarthquakeHistoryEarlyEventFamily._dependencies,
        allTransitiveDependencies:
            EarthquakeHistoryEarlyEventFamily
                ._allTransitiveDependencies,
        id: id,
      );

  EarthquakeHistoryEarlyEventProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<EarthquakeEarlyEvent> Function(
      EarthquakeHistoryEarlyEventRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override:
          EarthquakeHistoryEarlyEventProvider._internal(
            (ref) => create(
              ref as EarthquakeHistoryEarlyEventRef,
            ),
            from: from,
            name: null,
            dependencies: null,
            allTransitiveDependencies: null,
            debugGetCreateSourceHash: null,
            id: id,
          ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<EarthquakeEarlyEvent>
  createElement() {
    return _EarthquakeHistoryEarlyEventProviderElement(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EarthquakeHistoryEarlyEventProvider &&
        other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EarthquakeHistoryEarlyEventRef
    on AutoDisposeFutureProviderRef<EarthquakeEarlyEvent> {
  /// The parameter `id` of this provider.
  String get id;
}

class _EarthquakeHistoryEarlyEventProviderElement
    extends
        AutoDisposeFutureProviderElement<
          EarthquakeEarlyEvent
        >
    with EarthquakeHistoryEarlyEventRef {
  _EarthquakeHistoryEarlyEventProviderElement(
    super.provider,
  );

  @override
  String get id =>
      (origin as EarthquakeHistoryEarlyEventProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
