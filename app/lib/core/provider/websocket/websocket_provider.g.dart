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
String _$websocketTableMessagesHash() =>
    r'a2cc8d87641f64a119a88fc5c9c7b716dd25476f';

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

/// See also [websocketTableMessages].
@ProviderFor(websocketTableMessages)
const websocketTableMessagesProvider = WebsocketTableMessagesFamily();

/// See also [websocketTableMessages].
class WebsocketTableMessagesFamily extends Family {
  /// See also [websocketTableMessages].
  const WebsocketTableMessagesFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'websocketTableMessagesProvider';

  /// See also [websocketTableMessages].
  WebsocketTableMessagesProvider<T> call<T extends V1Database>() {
    return WebsocketTableMessagesProvider<T>();
  }

  @visibleForOverriding
  @override
  WebsocketTableMessagesProvider<V1Database> getProviderOverride(
    covariant WebsocketTableMessagesProvider<V1Database> provider,
  ) {
    return call();
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      Stream<RealtimePostgresChangesPayloadTable<T>>
              Function<T extends V1Database>(WebsocketTableMessagesRef ref)
          create) {
    return _$WebsocketTableMessagesFamilyOverride(this, create);
  }
}

class _$WebsocketTableMessagesFamilyOverride implements FamilyOverride {
  _$WebsocketTableMessagesFamilyOverride(this.overriddenFamily, this.create);

  final Stream<RealtimePostgresChangesPayloadTable<T>>
      Function<T extends V1Database>(WebsocketTableMessagesRef ref) create;

  @override
  final WebsocketTableMessagesFamily overriddenFamily;

  @override
  WebsocketTableMessagesProvider getProviderOverride(
    covariant WebsocketTableMessagesProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [websocketTableMessages].
class WebsocketTableMessagesProvider<T extends V1Database>
    extends AutoDisposeStreamProvider<RealtimePostgresChangesPayloadTable<T>> {
  /// See also [websocketTableMessages].
  WebsocketTableMessagesProvider()
      : this._internal(
          (ref) => websocketTableMessages<T>(
            ref as WebsocketTableMessagesRef<T>,
          ),
          from: websocketTableMessagesProvider,
          name: r'websocketTableMessagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$websocketTableMessagesHash,
          dependencies: WebsocketTableMessagesFamily._dependencies,
          allTransitiveDependencies:
              WebsocketTableMessagesFamily._allTransitiveDependencies,
        );

  WebsocketTableMessagesProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
  }) : super.internal();

  @override
  Override overrideWith(
    Stream<RealtimePostgresChangesPayloadTable<T>> Function(
            WebsocketTableMessagesRef<T> ref)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WebsocketTableMessagesProvider<T>._internal(
        (ref) => create(ref as WebsocketTableMessagesRef<T>),
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
  AutoDisposeStreamProviderElement<RealtimePostgresChangesPayloadTable<T>>
      createElement() {
    return _WebsocketTableMessagesProviderElement(this);
  }

  WebsocketTableMessagesProvider _copyWith(
    Stream<RealtimePostgresChangesPayloadTable<T>>
            Function<T extends V1Database>(WebsocketTableMessagesRef ref)
        create,
  ) {
    return WebsocketTableMessagesProvider._internal(
      (ref) => create(ref as WebsocketTableMessagesRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WebsocketTableMessagesProvider &&
        other.runtimeType == runtimeType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, T.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WebsocketTableMessagesRef<T extends V1Database>
    on AutoDisposeStreamProviderRef<RealtimePostgresChangesPayloadTable<T>> {}

class _WebsocketTableMessagesProviderElement<T extends V1Database>
    extends AutoDisposeStreamProviderElement<
        RealtimePostgresChangesPayloadTable<T>>
    with WebsocketTableMessagesRef<T> {
  _WebsocketTableMessagesProviderElement(super.provider);
}

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
