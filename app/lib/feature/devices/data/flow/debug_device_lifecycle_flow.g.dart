// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_device_lifecycle_flow.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugDeviceLifecycleFlow)
final debugDeviceLifecycleFlowProvider = DebugDeviceLifecycleFlowProvider._();

final class DebugDeviceLifecycleFlowProvider
    extends
        $FunctionalProvider<
          DebugDeviceLifecycleFlow,
          DebugDeviceLifecycleFlow,
          DebugDeviceLifecycleFlow
        >
    with $Provider<DebugDeviceLifecycleFlow> {
  DebugDeviceLifecycleFlowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugDeviceLifecycleFlowProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugDeviceLifecycleFlowHash();

  @$internal
  @override
  $ProviderElement<DebugDeviceLifecycleFlow> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DebugDeviceLifecycleFlow create(Ref ref) {
    return debugDeviceLifecycleFlow(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugDeviceLifecycleFlow value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugDeviceLifecycleFlow>(value),
    );
  }
}

String _$debugDeviceLifecycleFlowHash() =>
    r'd25aed33d91a808779961748f83856174b98b1cb';
