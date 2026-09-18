// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_activity_local_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(liveActivityLocalController)
final liveActivityLocalControllerProvider =
    LiveActivityLocalControllerProvider._();

final class LiveActivityLocalControllerProvider
    extends
        $FunctionalProvider<
          LiveActivityLocalController,
          LiveActivityLocalController,
          LiveActivityLocalController
        >
    with $Provider<LiveActivityLocalController> {
  LiveActivityLocalControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveActivityLocalControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveActivityLocalControllerHash();

  @$internal
  @override
  $ProviderElement<LiveActivityLocalController> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LiveActivityLocalController create(Ref ref) {
    return liveActivityLocalController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveActivityLocalController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveActivityLocalController>(value),
    );
  }
}

String _$liveActivityLocalControllerHash() =>
    r'502948be0a460ea23fa891121a39cf0d1583dfdb';
