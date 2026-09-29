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
    r'3e8e3fd854a7fb46fdbd26e834884fd457cc0d13';

abstract class _$EqMonitorWsDataSource extends $StreamNotifier<RealtimeEvent> {
  Stream<RealtimeEvent> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<RealtimeEvent>, RealtimeEvent>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RealtimeEvent>, RealtimeEvent>,
              AsyncValue<RealtimeEvent>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
