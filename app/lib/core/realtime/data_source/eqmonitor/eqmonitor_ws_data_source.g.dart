// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eqmonitor_ws_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eqMonitorWsDataSource)
final eqMonitorWsDataSourceProvider = EqMonitorWsDataSourceProvider._();

final class EqMonitorWsDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<RealtimeEvent>,
          RealtimeEvent,
          Stream<RealtimeEvent>
        >
    with $FutureModifier<RealtimeEvent>, $StreamProvider<RealtimeEvent> {
  EqMonitorWsDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eqMonitorWsDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eqMonitorWsDataSourceHash();

  @$internal
  @override
  $StreamProviderElement<RealtimeEvent> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<RealtimeEvent> create(Ref ref) {
    return eqMonitorWsDataSource(ref);
  }
}

String _$eqMonitorWsDataSourceHash() =>
    r'01e392ea2eeb9e3018fc557d6c5c97d8f70dfd5c';
