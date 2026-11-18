// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_mode_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugModeAction)
final debugModeActionProvider = DebugModeActionProvider._();

final class DebugModeActionProvider
    extends
        $FunctionalProvider<DebugModeAction, DebugModeAction, DebugModeAction>
    with $Provider<DebugModeAction> {
  DebugModeActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugModeActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugModeActionHash();

  @$internal
  @override
  $ProviderElement<DebugModeAction> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DebugModeAction create(Ref ref) {
    return debugModeAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugModeAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugModeAction>(value),
    );
  }
}

String _$debugModeActionHash() => r'3e5b9515286c0c72a2d39d58501a7df056c23452';
