// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_remote_settings_migrate_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationRemoteSettingsInitialSetupNotifier)
const notificationRemoteSettingsInitialSetupProvider =
    NotificationRemoteSettingsInitialSetupNotifierProvider._();

final class NotificationRemoteSettingsInitialSetupNotifierProvider
    extends
        $StreamNotifierProvider<
          NotificationRemoteSettingsInitialSetupNotifier,
          NotificationRemoteSettingsSetupState
        > {
  const NotificationRemoteSettingsInitialSetupNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRemoteSettingsInitialSetupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$notificationRemoteSettingsInitialSetupNotifierHash();

  @$internal
  @override
  NotificationRemoteSettingsInitialSetupNotifier create() =>
      NotificationRemoteSettingsInitialSetupNotifier();
}

String _$notificationRemoteSettingsInitialSetupNotifierHash() =>
    r'e92eb5b717a70864b9b7b2ee8b325c16af1dff58';

abstract class _$NotificationRemoteSettingsInitialSetupNotifier
    extends $StreamNotifier<NotificationRemoteSettingsSetupState> {
  Stream<NotificationRemoteSettingsSetupState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<NotificationRemoteSettingsSetupState>,
              NotificationRemoteSettingsSetupState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<NotificationRemoteSettingsSetupState>,
                NotificationRemoteSettingsSetupState
              >,
              AsyncValue<NotificationRemoteSettingsSetupState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
