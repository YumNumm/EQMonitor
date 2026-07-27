// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_monitor_exit_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(liveMonitorExitAction)
final liveMonitorExitActionProvider = LiveMonitorExitActionProvider._();

final class LiveMonitorExitActionProvider
    extends
        $FunctionalProvider<
          LiveMonitorExitAction,
          LiveMonitorExitAction,
          LiveMonitorExitAction
        >
    with $Provider<LiveMonitorExitAction> {
  LiveMonitorExitActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveMonitorExitActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveMonitorExitActionHash();

  @$internal
  @override
  $ProviderElement<LiveMonitorExitAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LiveMonitorExitAction create(Ref ref) {
    return liveMonitorExitAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveMonitorExitAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveMonitorExitAction>(value),
    );
  }
}

String _$liveMonitorExitActionHash() =>
    r'679f89a013fe42389945672039ebdb2d8b5191ce';
