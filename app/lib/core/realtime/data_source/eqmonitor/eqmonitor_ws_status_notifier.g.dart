// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eqmonitor_ws_status_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EqMonitorWsStatus)
final eqMonitorWsStatusProvider = EqMonitorWsStatusProvider._();

final class EqMonitorWsStatusProvider
    extends $NotifierProvider<EqMonitorWsStatus, EqMonitorWsStatusState> {
  EqMonitorWsStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eqMonitorWsStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eqMonitorWsStatusHash();

  @$internal
  @override
  EqMonitorWsStatus create() => EqMonitorWsStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EqMonitorWsStatusState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EqMonitorWsStatusState>(value),
    );
  }
}

String _$eqMonitorWsStatusHash() => r'7fec0f7f6666d4d3356cdbd1b903f2e29545fb55';

abstract class _$EqMonitorWsStatus extends $Notifier<EqMonitorWsStatusState> {
  EqMonitorWsStatusState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<EqMonitorWsStatusState, EqMonitorWsStatusState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EqMonitorWsStatusState, EqMonitorWsStatusState>,
              EqMonitorWsStatusState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
