// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

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
        isAutoDispose: false,
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

  @$internal
  @override
  $StreamNotifierProviderElement<
    NotificationRemoteSettingsInitialSetupNotifier,
    NotificationRemoteSettingsSetupState
  >
  $createElement($ProviderPointer pointer) =>
      $StreamNotifierProviderElement(pointer);
}

String _$notificationRemoteSettingsInitialSetupNotifierHash() =>
    r'c07726a8460cb9b4374dd27e333e424aa428d827';

abstract class _$NotificationRemoteSettingsInitialSetupNotifier
    extends $StreamNotifier<NotificationRemoteSettingsSetupState> {
  Stream<NotificationRemoteSettingsSetupState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<NotificationRemoteSettingsSetupState>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NotificationRemoteSettingsSetupState>>,
              AsyncValue<NotificationRemoteSettingsSetupState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
