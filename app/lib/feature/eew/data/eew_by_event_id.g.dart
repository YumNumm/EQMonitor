// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'eew_by_event_id.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eewsByEventIdHash() => r'b57fe47c5a2108c48cec9ac7d79448bc48969b22';

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

abstract class _$EewsByEventId
    extends BuildlessAutoDisposeAsyncNotifier<List<EewV1>> {
  late final String eventId;

  FutureOr<List<EewV1>> build(String eventId);
}

/// See also [EewsByEventId].
@ProviderFor(EewsByEventId)
const eewsByEventIdProvider = EewsByEventIdFamily();

/// See also [EewsByEventId].
class EewsByEventIdFamily extends Family<AsyncValue<List<EewV1>>> {
  /// See also [EewsByEventId].
  const EewsByEventIdFamily();

  /// See also [EewsByEventId].
  EewsByEventIdProvider call(String eventId) {
    return EewsByEventIdProvider(eventId);
  }

  @override
  EewsByEventIdProvider getProviderOverride(
    covariant EewsByEventIdProvider provider,
  ) {
    return call(provider.eventId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'eewsByEventIdProvider';
}

/// See also [EewsByEventId].
class EewsByEventIdProvider
    extends AutoDisposeAsyncNotifierProviderImpl<EewsByEventId, List<EewV1>> {
  /// See also [EewsByEventId].
  EewsByEventIdProvider(String eventId)
    : this._internal(
        () => EewsByEventId()..eventId = eventId,
        from: eewsByEventIdProvider,
        name: r'eewsByEventIdProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$eewsByEventIdHash,
        dependencies: EewsByEventIdFamily._dependencies,
        allTransitiveDependencies:
            EewsByEventIdFamily._allTransitiveDependencies,
        eventId: eventId,
      );

  EewsByEventIdProvider._internal(
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
  FutureOr<List<EewV1>> runNotifierBuild(covariant EewsByEventId notifier) {
    return notifier.build(eventId);
  }

  @override
  Override overrideWith(EewsByEventId Function() create) {
    return ProviderOverride(
      origin: this,
      override: EewsByEventIdProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<EewsByEventId, List<EewV1>>
  createElement() {
    return _EewsByEventIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EewsByEventIdProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EewsByEventIdRef on AutoDisposeAsyncNotifierProviderRef<List<EewV1>> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _EewsByEventIdProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<EewsByEventId, List<EewV1>>
    with EewsByEventIdRef {
  _EewsByEventIdProviderElement(super.provider);

  @override
  String get eventId => (origin as EewsByEventIdProvider).eventId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
