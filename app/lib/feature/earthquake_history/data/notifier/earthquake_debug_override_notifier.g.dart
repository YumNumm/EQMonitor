// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_debug_override_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EarthquakeDebugOverrideNotifier)
final earthquakeDebugOverrideProvider =
    EarthquakeDebugOverrideNotifierFamily._();

final class EarthquakeDebugOverrideNotifierProvider
    extends $NotifierProvider<EarthquakeDebugOverrideNotifier, Earthquake?> {
  EarthquakeDebugOverrideNotifierProvider._({
    required EarthquakeDebugOverrideNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'earthquakeDebugOverrideProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$earthquakeDebugOverrideNotifierHash();

  @override
  String toString() {
    return r'earthquakeDebugOverrideProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EarthquakeDebugOverrideNotifier create() => EarthquakeDebugOverrideNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Earthquake? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Earthquake?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EarthquakeDebugOverrideNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$earthquakeDebugOverrideNotifierHash() =>
    r'a819453faefa7edf2958e25e9cedcd4892cae564';

final class EarthquakeDebugOverrideNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          EarthquakeDebugOverrideNotifier,
          Earthquake?,
          Earthquake?,
          Earthquake?,
          String
        > {
  EarthquakeDebugOverrideNotifierFamily._()
    : super(
        retry: null,
        name: r'earthquakeDebugOverrideProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EarthquakeDebugOverrideNotifierProvider call(String eventId) =>
      EarthquakeDebugOverrideNotifierProvider._(argument: eventId, from: this);

  @override
  String toString() => r'earthquakeDebugOverrideProvider';
}

abstract class _$EarthquakeDebugOverrideNotifier
    extends $Notifier<Earthquake?> {
  late final _$args = ref.$arg as String;
  String get eventId => _$args;

  Earthquake? build(String eventId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Earthquake?, Earthquake?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Earthquake?, Earthquake?>,
              Earthquake?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
