// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eqmonitor_ws_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EqMonitorWsDataSource)
final eqMonitorWsDataSourceProvider = EqMonitorWsDataSourceProvider._();

final class EqMonitorWsDataSourceProvider
    extends $StreamNotifierProvider<EqMonitorWsDataSource, RealtimeEvent> {
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
  EqMonitorWsDataSource create() => EqMonitorWsDataSource();
}

String _$eqMonitorWsDataSourceHash() =>
    r'a028b331b38f2509cc44db4f084fb575fb112aa8';

abstract class _$EqMonitorWsDataSource extends $StreamNotifier<RealtimeEvent> {
  Stream<RealtimeEvent> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<RealtimeEvent>, RealtimeEvent>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RealtimeEvent>, RealtimeEvent>,
              AsyncValue<RealtimeEvent>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
