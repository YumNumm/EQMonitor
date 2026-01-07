// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_activity_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Live Activityのプロバイダー
/// iOS専用機能のため、iOSでのみ初期化される

@ProviderFor(liveActivities)
final liveActivitiesProvider = LiveActivitiesProvider._();

/// Live Activityのプロバイダー
/// iOS専用機能のため、iOSでのみ初期化される

final class LiveActivitiesProvider
    extends $FunctionalProvider<LiveActivities, LiveActivities, LiveActivities>
    with $Provider<LiveActivities> {
  /// Live Activityのプロバイダー
  /// iOS専用機能のため、iOSでのみ初期化される
  LiveActivitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveActivitiesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveActivitiesHash();

  @$internal
  @override
  $ProviderElement<LiveActivities> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LiveActivities create(Ref ref) {
    return liveActivities(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveActivities value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveActivities>(value),
    );
  }
}

String _$liveActivitiesHash() => r'a759beb41a39c3a5c65ed13973c18b351bb61e99';

/// Live Activity管理Provider
/// pushToStartトークンとupdateTokenの管理を行う

@ProviderFor(LiveActivityManager)
final liveActivityManagerProvider = LiveActivityManagerProvider._();

/// Live Activity管理Provider
/// pushToStartトークンとupdateTokenの管理を行う
final class LiveActivityManagerProvider
    extends $AsyncNotifierProvider<LiveActivityManager, void> {
  /// Live Activity管理Provider
  /// pushToStartトークンとupdateTokenの管理を行う
  LiveActivityManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveActivityManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveActivityManagerHash();

  @$internal
  @override
  LiveActivityManager create() => LiveActivityManager();
}

String _$liveActivityManagerHash() =>
    r'f1cbb43b7b5623a2116948fd6d1d398b82ce03ec';

/// Live Activity管理Provider
/// pushToStartトークンとupdateTokenの管理を行う

abstract class _$LiveActivityManager extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
