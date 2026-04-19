// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_map_focus_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EarthquakeHistoryMapFocus)
final earthquakeHistoryMapFocusProvider = EarthquakeHistoryMapFocusFamily._();

final class EarthquakeHistoryMapFocusProvider
    extends
        $NotifierProvider<
          EarthquakeHistoryMapFocus,
          EarthquakeIntensityMapFocus?
        > {
  EarthquakeHistoryMapFocusProvider._({
    required EarthquakeHistoryMapFocusFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'earthquakeHistoryMapFocusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$earthquakeHistoryMapFocusHash();

  @override
  String toString() {
    return r'earthquakeHistoryMapFocusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EarthquakeHistoryMapFocus create() => EarthquakeHistoryMapFocus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EarthquakeIntensityMapFocus? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EarthquakeIntensityMapFocus?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EarthquakeHistoryMapFocusProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$earthquakeHistoryMapFocusHash() =>
    r'e2a2b9997e9611b030946578af284d4a915b0d0c';

final class EarthquakeHistoryMapFocusFamily extends $Family
    with
        $ClassFamilyOverride<
          EarthquakeHistoryMapFocus,
          EarthquakeIntensityMapFocus?,
          EarthquakeIntensityMapFocus?,
          EarthquakeIntensityMapFocus?,
          String
        > {
  EarthquakeHistoryMapFocusFamily._()
    : super(
        retry: null,
        name: r'earthquakeHistoryMapFocusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EarthquakeHistoryMapFocusProvider call(String eventId) =>
      EarthquakeHistoryMapFocusProvider._(argument: eventId, from: this);

  @override
  String toString() => r'earthquakeHistoryMapFocusProvider';
}

abstract class _$EarthquakeHistoryMapFocus
    extends $Notifier<EarthquakeIntensityMapFocus?> {
  late final _$args = ref.$arg as String;
  String get eventId => _$args;

  EarthquakeIntensityMapFocus? build(String eventId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<EarthquakeIntensityMapFocus?, EarthquakeIntensityMapFocus?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                EarthquakeIntensityMapFocus?,
                EarthquakeIntensityMapFocus?
              >,
              EarthquakeIntensityMapFocus?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
