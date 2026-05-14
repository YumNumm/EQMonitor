// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_activity_token_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(liveActivityTokenSyncService)
final liveActivityTokenSyncServiceProvider =
    LiveActivityTokenSyncServiceProvider._();

final class LiveActivityTokenSyncServiceProvider
    extends
        $FunctionalProvider<
          AsyncValue<LiveActivityTokenSyncService>,
          LiveActivityTokenSyncService,
          FutureOr<LiveActivityTokenSyncService>
        >
    with
        $FutureModifier<LiveActivityTokenSyncService>,
        $FutureProvider<LiveActivityTokenSyncService> {
  LiveActivityTokenSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveActivityTokenSyncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveActivityTokenSyncServiceHash();

  @$internal
  @override
  $FutureProviderElement<LiveActivityTokenSyncService> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LiveActivityTokenSyncService> create(Ref ref) {
    return liveActivityTokenSyncService(ref);
  }
}

String _$liveActivityTokenSyncServiceHash() =>
    r'39aee792feecfe3fea375cae077ab120f9a5631a';

/// iOS のみ: Live Activity update token を監視してサーバへ同期する。
/// main.dart で read することで起動時にリッスンが開始される。

@ProviderFor(liveActivityTokenSyncWiring)
final liveActivityTokenSyncWiringProvider =
    LiveActivityTokenSyncWiringProvider._();

/// iOS のみ: Live Activity update token を監視してサーバへ同期する。
/// main.dart で read することで起動時にリッスンが開始される。

final class LiveActivityTokenSyncWiringProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// iOS のみ: Live Activity update token を監視してサーバへ同期する。
  /// main.dart で read することで起動時にリッスンが開始される。
  LiveActivityTokenSyncWiringProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveActivityTokenSyncWiringProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveActivityTokenSyncWiringHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return liveActivityTokenSyncWiring(ref);
  }
}

String _$liveActivityTokenSyncWiringHash() =>
    r'e23d56281b7262a132cdbd524cb938262ec64044';
