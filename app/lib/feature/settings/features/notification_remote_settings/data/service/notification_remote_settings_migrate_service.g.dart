// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_remote_settings_migrate_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(NotificationRemoteSettingsInitialSetupNotifier)
const notificationRemoteSettingsInitialSetupNotifierProvider =
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
        name: r'notificationRemoteSettingsInitialSetupNotifierProvider',
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
    r'898fb6f7e6ab9ab4d02f9e7bbd1ec2e99ba35ace';

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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
