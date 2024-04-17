// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'earthquake_history_details_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$earthquakeHistoryDetailsNotifierHash() =>
    r'bdf4df2a7b2de0b1f49e718644f7e16880f9d845';

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

abstract class _$EarthquakeHistoryDetailsNotifier
    extends BuildlessAutoDisposeAsyncNotifier<EarthquakeV1Extended> {
  late final int eventId;

  FutureOr<EarthquakeV1Extended> build(
    int eventId,
  );
}

/// See also [EarthquakeHistoryDetailsNotifier].
@ProviderFor(EarthquakeHistoryDetailsNotifier)
const earthquakeHistoryDetailsNotifierProvider =
    EarthquakeHistoryDetailsNotifierFamily();

/// See also [EarthquakeHistoryDetailsNotifier].
class EarthquakeHistoryDetailsNotifierFamily extends Family {
  /// See also [EarthquakeHistoryDetailsNotifier].
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

  /// See also [EarthquakeHistoryDetailsNotifier].
  EarthquakeHistoryDetailsNotifierProvider call(
    int eventId,
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
  Override overrideWith(EarthquakeHistoryDetailsNotifier Function() create) {
    return _$EarthquakeHistoryDetailsNotifierFamilyOverride(this, create);
  }
}

class _$EarthquakeHistoryDetailsNotifierFamilyOverride
    implements FamilyOverride {
  _$EarthquakeHistoryDetailsNotifierFamilyOverride(
      this.overriddenFamily, this.create);

  final EarthquakeHistoryDetailsNotifier Function() create;

  @override
  final EarthquakeHistoryDetailsNotifierFamily overriddenFamily;

  @override
  EarthquakeHistoryDetailsNotifierProvider getProviderOverride(
    covariant EarthquakeHistoryDetailsNotifierProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [EarthquakeHistoryDetailsNotifier].
class EarthquakeHistoryDetailsNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        EarthquakeHistoryDetailsNotifier, EarthquakeV1Extended> {
  /// See also [EarthquakeHistoryDetailsNotifier].
  EarthquakeHistoryDetailsNotifierProvider(
    int eventId,
  ) : this._internal(
          () => EarthquakeHistoryDetailsNotifier()..eventId = eventId,
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

  final int eventId;

  @override
  FutureOr<EarthquakeV1Extended> runNotifierBuild(
    covariant EarthquakeHistoryDetailsNotifier notifier,
  ) {
    return notifier.build(
      eventId,
    );
  }

  @override
  Override overrideWith(EarthquakeHistoryDetailsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: EarthquakeHistoryDetailsNotifierProvider._internal(
        () => create()..eventId = eventId,
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
  (int,) get argument {
    return (eventId,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<EarthquakeHistoryDetailsNotifier,
      EarthquakeV1Extended> createElement() {
    return _EarthquakeHistoryDetailsNotifierProviderElement(this);
  }

  EarthquakeHistoryDetailsNotifierProvider _copyWith(
    EarthquakeHistoryDetailsNotifier Function() create,
  ) {
    return EarthquakeHistoryDetailsNotifierProvider._internal(
      () => create()..eventId = eventId,
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
    on AutoDisposeAsyncNotifierProviderRef<EarthquakeV1Extended> {
  /// The parameter `eventId` of this provider.
  int get eventId;
}

class _EarthquakeHistoryDetailsNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        EarthquakeHistoryDetailsNotifier,
        EarthquakeV1Extended> with EarthquakeHistoryDetailsNotifierRef {
  _EarthquakeHistoryDetailsNotifierProviderElement(super.provider);

  @override
  int get eventId =>
      (origin as EarthquakeHistoryDetailsNotifierProvider).eventId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
