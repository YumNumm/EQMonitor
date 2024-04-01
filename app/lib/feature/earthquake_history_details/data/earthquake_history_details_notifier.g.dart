// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'earthquake_history_details_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$earthquakeHistoryDetailsNotifierHash() =>
    r'e5ebdd73e7eb20ea51d9bb5298315f11f1d8d8f5';

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

/// See also [earthquakeHistoryDetailsNotifier].
@ProviderFor(earthquakeHistoryDetailsNotifier)
const earthquakeHistoryDetailsNotifierProvider =
    EarthquakeHistoryDetailsNotifierFamily();

/// See also [earthquakeHistoryDetailsNotifier].
class EarthquakeHistoryDetailsNotifierFamily extends Family {
  /// See also [earthquakeHistoryDetailsNotifier].
  const EarthquakeHistoryDetailsNotifierFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'earthquakeHistoryDetailsNotifierProvider';

  /// See also [earthquakeHistoryDetailsNotifier].
  EarthquakeHistoryDetailsNotifierProvider call(
    String eventId,
  ) {
    return EarthquakeHistoryDetailsNotifierProvider(
      eventId,
    );
  }

  @visibleForOverriding
  @override
  EarthquakeHistoryDetailsNotifierProvider getProviderOverride(
    covariant EarthquakeHistoryDetailsNotifierProvider provider,
  ) {
    return call(
      provider.eventId,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<EarthquakeV1Extended> Function(
              EarthquakeHistoryDetailsNotifierRef ref)
          create) {
    return _$EarthquakeHistoryDetailsNotifierFamilyOverride(this, create);
  }
}

class _$EarthquakeHistoryDetailsNotifierFamilyOverride
    implements FamilyOverride {
  _$EarthquakeHistoryDetailsNotifierFamilyOverride(
      this.overriddenFamily, this.create);

  final FutureOr<EarthquakeV1Extended> Function(
      EarthquakeHistoryDetailsNotifierRef ref) create;

  @override
  final EarthquakeHistoryDetailsNotifierFamily overriddenFamily;

  @override
  EarthquakeHistoryDetailsNotifierProvider getProviderOverride(
    covariant EarthquakeHistoryDetailsNotifierProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [earthquakeHistoryDetailsNotifier].
class EarthquakeHistoryDetailsNotifierProvider
    extends FutureProvider<EarthquakeV1Extended> {
  /// See also [earthquakeHistoryDetailsNotifier].
  EarthquakeHistoryDetailsNotifierProvider(
    String eventId,
  ) : this._internal(
          (ref) => earthquakeHistoryDetailsNotifier(
            ref as EarthquakeHistoryDetailsNotifierRef,
            eventId,
          ),
          from: earthquakeHistoryDetailsNotifierProvider,
          name: r'earthquakeHistoryDetailsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$earthquakeHistoryDetailsNotifierHash,
          dependencies: EarthquakeHistoryDetailsNotifierFamily._dependencies,
          allTransitiveDependencies:
              EarthquakeHistoryDetailsNotifierFamily._allTransitiveDependencies,
          eventId: eventId,
        );

  EarthquakeHistoryDetailsNotifierProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventId,
  }) : super.internal();

  final String eventId;

  @override
  Override overrideWith(
    FutureOr<EarthquakeV1Extended> Function(
            EarthquakeHistoryDetailsNotifierRef ref)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EarthquakeHistoryDetailsNotifierProvider._internal(
        (ref) => create(ref as EarthquakeHistoryDetailsNotifierRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventId: eventId,
      ),
    );
  }

  @override
  (String,) get argument {
    return (eventId,);
  }

  @override
  FutureProviderElement<EarthquakeV1Extended> createElement() {
    return _EarthquakeHistoryDetailsNotifierProviderElement(this);
  }

  EarthquakeHistoryDetailsNotifierProvider _copyWith(
    FutureOr<EarthquakeV1Extended> Function(
            EarthquakeHistoryDetailsNotifierRef ref)
        create,
  ) {
    return EarthquakeHistoryDetailsNotifierProvider._internal(
      (ref) => create(ref as EarthquakeHistoryDetailsNotifierRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      eventId: eventId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EarthquakeHistoryDetailsNotifierProvider &&
        other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EarthquakeHistoryDetailsNotifierRef
    on FutureProviderRef<EarthquakeV1Extended> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _EarthquakeHistoryDetailsNotifierProviderElement
    extends FutureProviderElement<EarthquakeV1Extended>
    with EarthquakeHistoryDetailsNotifierRef {
  _EarthquakeHistoryDetailsNotifierProviderElement(super.provider);

  @override
  String get eventId =>
      (origin as EarthquakeHistoryDetailsNotifierProvider).eventId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
