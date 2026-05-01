// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eqmonitor_realtime_event_mapper.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eqMonitorRealtimeEventMapper)
final eqMonitorRealtimeEventMapperProvider =
    EqMonitorRealtimeEventMapperProvider._();

final class EqMonitorRealtimeEventMapperProvider
    extends
        $FunctionalProvider<
          EqMonitorRealtimeEventMapper,
          EqMonitorRealtimeEventMapper,
          EqMonitorRealtimeEventMapper
        >
    with $Provider<EqMonitorRealtimeEventMapper> {
  EqMonitorRealtimeEventMapperProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eqMonitorRealtimeEventMapperProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eqMonitorRealtimeEventMapperHash();

  @$internal
  @override
  $ProviderElement<EqMonitorRealtimeEventMapper> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EqMonitorRealtimeEventMapper create(Ref ref) {
    return eqMonitorRealtimeEventMapper(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EqMonitorRealtimeEventMapper value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EqMonitorRealtimeEventMapper>(value),
    );
  }
}

String _$eqMonitorRealtimeEventMapperHash() =>
    r'cd9b3dbca30c7a755cfe43b1bbb935a1e54e9cbd';
