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
class EarthquakeHistoryDetailsNotifierFamily
    extends Family<AsyncValue<EarthquakeV1Extended>> {
  /// See also [earthquakeHistoryDetailsNotifier].
  const EarthquakeHistoryDetailsNotifierFamily();

  /// See also [earthquakeHistoryDetailsNotifier].
  EarthquakeHistoryDetailsNotifierProvider call(
    String eventId,
  ) {
    return EarthquakeHistoryDetailsNotifierProvider(
      eventId,
    );
  }

  @override
  EarthquakeHistoryDetailsNotifierProvider getProviderOverride(
    covariant EarthquakeHistoryDetailsNotifierProvider provider,
  ) {
    return call(
      provider.eventId,
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
  String? get name => r'earthquakeHistoryDetailsNotifierProvider';
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
    super._createNotifier, {
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
            EarthquakeHistoryDetailsNotifierRef provider)
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
  FutureProviderElement<EarthquakeV1Extended> createElement() {
    return _EarthquakeHistoryDetailsNotifierProviderElement(this);
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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
