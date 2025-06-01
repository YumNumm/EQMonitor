// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'notification_remote_settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(NotificationRemoteSettingsNotifier)
const notificationRemoteSettingsNotifierProvider =
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
        name: r'notificationRemoteSettingsNotifierProvider',
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

  @$internal
  @override
  $AsyncNotifierProviderElement<
    NotificationRemoteSettingsNotifier,
    NotificationRemoteSettingsState
  >
  $createElement($ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(pointer);
}

String _$notificationRemoteSettingsNotifierHash() =>
    r'b48de9bf3bc6eead56c4350b5f3dfa81154a92ac';

abstract class _$NotificationRemoteSettingsNotifier
    extends $AsyncNotifier<NotificationRemoteSettingsState> {
  FutureOr<NotificationRemoteSettingsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<NotificationRemoteSettingsState>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NotificationRemoteSettingsState>>,
              AsyncValue<NotificationRemoteSettingsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
