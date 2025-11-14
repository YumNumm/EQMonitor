// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_remote_settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationRemoteSettingsNotifier)
const notificationRemoteSettingsProvider =
    NotificationRemoteSettingsNotifierProvider._();

final class NotificationRemoteSettingsNotifierProvider
    extends
        $AsyncNotifierProvider<
          NotificationRemoteSettingsNotifier,
          NotificationRemoteSettingsState
        > {
  const NotificationRemoteSettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRemoteSettingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$notificationRemoteSettingsNotifierHash();

  @$internal
  @override
  NotificationRemoteSettingsNotifier create() =>
      NotificationRemoteSettingsNotifier();
}

String _$notificationRemoteSettingsNotifierHash() =>
    r'c219f16f61b06266efcef029662d988e721ded8f';

abstract class _$NotificationRemoteSettingsNotifier
    extends $AsyncNotifier<NotificationRemoteSettingsState> {
  FutureOr<NotificationRemoteSettingsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<NotificationRemoteSettingsState>,
              NotificationRemoteSettingsState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<NotificationRemoteSettingsState>,
                NotificationRemoteSettingsState
              >,
              AsyncValue<NotificationRemoteSettingsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
