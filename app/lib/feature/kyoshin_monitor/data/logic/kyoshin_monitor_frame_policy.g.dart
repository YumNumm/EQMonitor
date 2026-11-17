// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_frame_policy.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kyoshinMonitorFramePolicy)
final kyoshinMonitorFramePolicyProvider = KyoshinMonitorFramePolicyProvider._();

final class KyoshinMonitorFramePolicyProvider
    extends
        $FunctionalProvider<
          KyoshinMonitorFramePolicy,
          KyoshinMonitorFramePolicy,
          KyoshinMonitorFramePolicy
        >
    with $Provider<KyoshinMonitorFramePolicy> {
  KyoshinMonitorFramePolicyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorFramePolicyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorFramePolicyHash();

  @$internal
  @override
  $ProviderElement<KyoshinMonitorFramePolicy> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  KyoshinMonitorFramePolicy create(Ref ref) {
    return kyoshinMonitorFramePolicy(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KyoshinMonitorFramePolicy value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KyoshinMonitorFramePolicy>(value),
    );
  }
}

String _$kyoshinMonitorFramePolicyHash() =>
    r'aadf5fdf287aaf59f14571beda2620141c5ea65e';
