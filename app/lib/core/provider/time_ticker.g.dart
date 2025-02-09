// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'time_ticker.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timeTickerHash() => r'e07001e8fe705386ea328936b8d5064182b4f9cb';

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

/// See also [timeTicker].
@ProviderFor(timeTicker)
const timeTickerProvider = TimeTickerFamily();

/// See also [timeTicker].
class TimeTickerFamily extends Family<AsyncValue<DateTime>> {
  /// See also [timeTicker].
  const TimeTickerFamily();

  /// See also [timeTicker].
  TimeTickerProvider call([
    Duration duration = const Duration(seconds: 1),
  ]) {
    return TimeTickerProvider(
      duration,
    );
  }

  @override
  TimeTickerProvider getProviderOverride(
    covariant TimeTickerProvider provider,
  ) {
    return call(
      provider.duration,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies =
      const <ProviderOrFamily>[];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      const <ProviderOrFamily>{};

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'timeTickerProvider';
}

/// See also [timeTicker].
class TimeTickerProvider extends StreamProvider<DateTime> {
  /// See also [timeTicker].
  TimeTickerProvider([
    Duration duration = const Duration(seconds: 1),
  ]) : this._internal(
          (ref) => timeTicker(
            ref as TimeTickerRef,
            duration,
          ),
          from: timeTickerProvider,
          name: r'timeTickerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$timeTickerHash,
          dependencies: TimeTickerFamily._dependencies,
          allTransitiveDependencies:
              TimeTickerFamily._allTransitiveDependencies,
          duration: duration,
        );

  TimeTickerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.duration,
  }) : super.internal();

  final Duration duration;

  @override
  Override overrideWith(
    Stream<DateTime> Function(TimeTickerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TimeTickerProvider._internal(
        (ref) => create(ref as TimeTickerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        duration: duration,
      ),
    );
  }

  @override
  StreamProviderElement<DateTime> createElement() {
    return _TimeTickerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TimeTickerProvider && other.duration == duration;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, duration.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TimeTickerRef on StreamProviderRef<DateTime> {
  /// The parameter `duration` of this provider.
  Duration get duration;
}

class _TimeTickerProviderElement extends StreamProviderElement<DateTime>
    with TimeTickerRef {
  _TimeTickerProviderElement(super.provider);

  @override
  Duration get duration => (origin as TimeTickerProvider).duration;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
