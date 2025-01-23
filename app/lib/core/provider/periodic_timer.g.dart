// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'periodic_timer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$periodicTimerHash() => r'd0ba8e774a2bb19048648aa7512e8b18d5d28ba8';

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

abstract class _$PeriodicTimer
    extends BuildlessAutoDisposeStreamNotifier<void> {
  late final Key key;

  Stream<void> build(
    Key key,
  );
}

/// See also [PeriodicTimer].
@ProviderFor(PeriodicTimer)
const periodicTimerProvider = PeriodicTimerFamily();

/// See also [PeriodicTimer].
class PeriodicTimerFamily extends Family<AsyncValue<void>> {
  /// See also [PeriodicTimer].
  const PeriodicTimerFamily();

  /// See also [PeriodicTimer].
  PeriodicTimerProvider call(
    Key key,
  ) {
    return PeriodicTimerProvider(
      key,
    );
  }

  @override
  PeriodicTimerProvider getProviderOverride(
    covariant PeriodicTimerProvider provider,
  ) {
    return call(
      provider.key,
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
  String? get name => r'periodicTimerProvider';
}

/// See also [PeriodicTimer].
class PeriodicTimerProvider
    extends AutoDisposeStreamNotifierProviderImpl<PeriodicTimer, void> {
  /// See also [PeriodicTimer].
  PeriodicTimerProvider(
    Key key,
  ) : this._internal(
          () => PeriodicTimer()..key = key,
          from: periodicTimerProvider,
          name: r'periodicTimerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$periodicTimerHash,
          dependencies: PeriodicTimerFamily._dependencies,
          allTransitiveDependencies:
              PeriodicTimerFamily._allTransitiveDependencies,
          key: key,
        );

  PeriodicTimerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.key,
  }) : super.internal();

  final Key key;

  @override
  Stream<void> runNotifierBuild(
    covariant PeriodicTimer notifier,
  ) {
    return notifier.build(
      key,
    );
  }

  @override
  Override overrideWith(PeriodicTimer Function() create) {
    return ProviderOverride(
      origin: this,
      override: PeriodicTimerProvider._internal(
        () => create()..key = key,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        key: key,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<PeriodicTimer, void>
      createElement() {
    return _PeriodicTimerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PeriodicTimerProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PeriodicTimerRef on AutoDisposeStreamNotifierProviderRef<void> {
  /// The parameter `key` of this provider.
  Key get key;
}

class _PeriodicTimerProviderElement
    extends AutoDisposeStreamNotifierProviderElement<PeriodicTimer, void>
    with PeriodicTimerRef {
  _PeriodicTimerProviderElement(super.provider);

  @override
  Key get key => (origin as PeriodicTimerProvider).key;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
