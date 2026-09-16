// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_live_activity_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugLiveActivityAction)
final debugLiveActivityActionProvider = DebugLiveActivityActionProvider._();

final class DebugLiveActivityActionProvider
    extends
        $FunctionalProvider<
          DebugLiveActivityAction,
          DebugLiveActivityAction,
          DebugLiveActivityAction
        >
    with $Provider<DebugLiveActivityAction> {
  DebugLiveActivityActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugLiveActivityActionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugLiveActivityActionHash();

  @$internal
  @override
  $ProviderElement<DebugLiveActivityAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DebugLiveActivityAction create(Ref ref) {
    return debugLiveActivityAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugLiveActivityAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugLiveActivityAction>(value),
    );
  }
}

String _$debugLiveActivityActionHash() =>
    r'a39e3641b47388d5795826aa72135a1c3a6ad5e4';
