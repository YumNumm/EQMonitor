// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'websocket_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$websocketHash() => r'6faaaeaa4aafed72504f15896ed0c79e4877c2b3';

/// See also [websocket].
@ProviderFor(websocket)
final websocketProvider = Provider<WebSocket>.internal(
  websocket,
  name: r'websocketProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$websocketHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WebsocketRef = ProviderRef<WebSocket>;
String _$websocketMessagesHash() => r'fef03b8990a93b2eebe2a3d330ef4d2dc40637ec';

/// See also [websocketMessages].
@ProviderFor(websocketMessages)
final websocketMessagesProvider =
    AutoDisposeStreamProvider<Map<String, dynamic>>.internal(
  websocketMessages,
  name: r'websocketMessagesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$websocketMessagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WebsocketMessagesRef
    = AutoDisposeStreamProviderRef<Map<String, dynamic>>;
String _$websocketParsedMessagesHash() =>
    r'b978f3a89cb132ddc28779f9cc05f1c70c4639ab';

/// See also [websocketParsedMessages].
@ProviderFor(websocketParsedMessages)
final websocketParsedMessagesProvider =
    AutoDisposeStreamProvider<RealtimePostgresChangesPayloadBase>.internal(
  websocketParsedMessages,
  name: r'websocketParsedMessagesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$websocketParsedMessagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WebsocketParsedMessagesRef
    = AutoDisposeStreamProviderRef<RealtimePostgresChangesPayloadBase>;
String _$websocketStatusHash() => r'0a02dad8afb47defa1ef60cc7ca9f448372ea77d';

/// See also [WebsocketStatus].
@ProviderFor(WebsocketStatus)
final websocketStatusProvider =
    AutoDisposeNotifierProvider<WebsocketStatus, ConnectionState>.internal(
  WebsocketStatus.new,
  name: r'websocketStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$websocketStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WebsocketStatus = AutoDisposeNotifier<ConnectionState>;
String _$realtimePostgresChangesPayloadTableMessageHash() =>
    r'9d1fa8be66aebe22bc08e93b11e5fd6af066fa3f';

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

abstract class _$RealtimePostgresChangesPayloadTableMessage<
        T extends V1Database>
    extends BuildlessAutoDisposeStreamNotifier<
        RealtimePostgresChangesPayloadTable<T>> {
  Stream<RealtimePostgresChangesPayloadTable<T>> build();
}

/// See also [RealtimePostgresChangesPayloadTableMessage].
@ProviderFor(RealtimePostgresChangesPayloadTableMessage)
const realtimePostgresChangesPayloadTableMessageProvider =
    RealtimePostgresChangesPayloadTableMessageFamily();

/// See also [RealtimePostgresChangesPayloadTableMessage].
class RealtimePostgresChangesPayloadTableMessageFamily extends Family {
  /// See also [RealtimePostgresChangesPayloadTableMessage].
  const RealtimePostgresChangesPayloadTableMessageFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'realtimePostgresChangesPayloadTableMessageProvider';

  /// See also [RealtimePostgresChangesPayloadTableMessage].
  RealtimePostgresChangesPayloadTableMessageProvider<T>
      call<T extends V1Database>() {
    return RealtimePostgresChangesPayloadTableMessageProvider<T>();
  }

  @visibleForOverriding
  @override
  RealtimePostgresChangesPayloadTableMessageProvider<V1Database>
      getProviderOverride(
    covariant RealtimePostgresChangesPayloadTableMessageProvider<V1Database>
        provider,
  ) {
    return call();
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      RealtimePostgresChangesPayloadTableMessage Function() create) {
    return _$RealtimePostgresChangesPayloadTableMessageFamilyOverride(
        this, create);
  }
}

class _$RealtimePostgresChangesPayloadTableMessageFamilyOverride
    implements FamilyOverride {
  _$RealtimePostgresChangesPayloadTableMessageFamilyOverride(
      this.overriddenFamily, this.create);

  final RealtimePostgresChangesPayloadTableMessage Function() create;

  @override
  final RealtimePostgresChangesPayloadTableMessageFamily overriddenFamily;

  @override
  RealtimePostgresChangesPayloadTableMessageProvider getProviderOverride(
    covariant RealtimePostgresChangesPayloadTableMessageProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [RealtimePostgresChangesPayloadTableMessage].
class RealtimePostgresChangesPayloadTableMessageProvider<T extends V1Database>
    extends AutoDisposeStreamNotifierProviderImpl<
        RealtimePostgresChangesPayloadTableMessage<T>,
        RealtimePostgresChangesPayloadTable<T>> {
  /// See also [RealtimePostgresChangesPayloadTableMessage].
  RealtimePostgresChangesPayloadTableMessageProvider()
      : this._internal(
          RealtimePostgresChangesPayloadTableMessage<T>.new,
          from: realtimePostgresChangesPayloadTableMessageProvider,
          name: r'realtimePostgresChangesPayloadTableMessageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$realtimePostgresChangesPayloadTableMessageHash,
          dependencies:
              RealtimePostgresChangesPayloadTableMessageFamily._dependencies,
          allTransitiveDependencies:
              RealtimePostgresChangesPayloadTableMessageFamily
                  ._allTransitiveDependencies,
        );

  RealtimePostgresChangesPayloadTableMessageProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
  }) : super.internal();

  @override
  Stream<RealtimePostgresChangesPayloadTable<T>> runNotifierBuild(
    covariant RealtimePostgresChangesPayloadTableMessage<T> notifier,
  ) {
    return notifier.build();
  }

  @override
  Override overrideWith(
      RealtimePostgresChangesPayloadTableMessage<T> Function() create) {
    return ProviderOverride(
      origin: this,
      override: RealtimePostgresChangesPayloadTableMessageProvider<T>._internal(
        () => create(),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
      ),
    );
  }

  @override
  () get argument {
    return ();
  }

  @override
  AutoDisposeStreamNotifierProviderElement<
      RealtimePostgresChangesPayloadTableMessage<T>,
      RealtimePostgresChangesPayloadTable<T>> createElement() {
    return _RealtimePostgresChangesPayloadTableMessageProviderElement(this);
  }

  RealtimePostgresChangesPayloadTableMessageProvider _copyWith(
    RealtimePostgresChangesPayloadTableMessage Function() create,
  ) {
    return RealtimePostgresChangesPayloadTableMessageProvider._internal(
      () => create(),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RealtimePostgresChangesPayloadTableMessageProvider &&
        other.runtimeType == runtimeType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, T.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RealtimePostgresChangesPayloadTableMessageRef<T extends V1Database>
    on AutoDisposeStreamNotifierProviderRef<
        RealtimePostgresChangesPayloadTable<T>> {}

class _RealtimePostgresChangesPayloadTableMessageProviderElement<
        T extends V1Database>
    extends AutoDisposeStreamNotifierProviderElement<
        RealtimePostgresChangesPayloadTableMessage<T>,
        RealtimePostgresChangesPayloadTable<T>>
    with RealtimePostgresChangesPayloadTableMessageRef<T> {
  _RealtimePostgresChangesPayloadTableMessageProviderElement(super.provider);
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
