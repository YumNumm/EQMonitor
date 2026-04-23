// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_activity_token_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(liveActivityPushTokenUpdates)
final liveActivityPushTokenUpdatesProvider =
    LiveActivityPushTokenUpdatesProvider._();

final class LiveActivityPushTokenUpdatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<LiveActivityTokenUpdate>,
          LiveActivityTokenUpdate,
          Stream<LiveActivityTokenUpdate>
        >
    with
        $FutureModifier<LiveActivityTokenUpdate>,
        $StreamProvider<LiveActivityTokenUpdate> {
  LiveActivityPushTokenUpdatesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveActivityPushTokenUpdatesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveActivityPushTokenUpdatesHash();

  @$internal
  @override
  $StreamProviderElement<LiveActivityTokenUpdate> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<LiveActivityTokenUpdate> create(Ref ref) {
    return liveActivityPushTokenUpdates(ref);
  }
}

String _$liveActivityPushTokenUpdatesHash() =>
    r'9e02e397b3c2e6b4a68227f264a047df13adbc39';
