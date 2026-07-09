// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_permission_banner_dismissed_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationPermissionBannerDismissed)
final notificationPermissionBannerDismissedProvider =
    NotificationPermissionBannerDismissedProvider._();

final class NotificationPermissionBannerDismissedProvider
    extends
        $AsyncNotifierProvider<NotificationPermissionBannerDismissed, bool> {
  NotificationPermissionBannerDismissedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPermissionBannerDismissedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$notificationPermissionBannerDismissedHash();

  @$internal
  @override
  NotificationPermissionBannerDismissed create() =>
      NotificationPermissionBannerDismissed();
}

String _$notificationPermissionBannerDismissedHash() =>
    r'17edfcff025dadcc1de0069084f6e06fce08927d';

abstract class _$NotificationPermissionBannerDismissed
    extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
