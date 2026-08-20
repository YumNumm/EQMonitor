// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eqmonitor_ws_ping_probe.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EqmonitorWsPingProbe)
final eqmonitorWsPingProbeProvider = EqmonitorWsPingProbeProvider._();

final class EqmonitorWsPingProbeProvider
    extends $NotifierProvider<EqmonitorWsPingProbe, WsRttSample?> {
  EqmonitorWsPingProbeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eqmonitorWsPingProbeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eqmonitorWsPingProbeHash();

  @$internal
  @override
  EqmonitorWsPingProbe create() => EqmonitorWsPingProbe();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WsRttSample? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WsRttSample?>(value),
    );
  }
}

String _$eqmonitorWsPingProbeHash() =>
    r'14db96f94ad9ff95725d03f1f57607f3bdc13011';

abstract class _$EqmonitorWsPingProbe extends $Notifier<WsRttSample?> {
  WsRttSample? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<WsRttSample?, WsRttSample?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WsRttSample?, WsRttSample?>,
              WsRttSample?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
