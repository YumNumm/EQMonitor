// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_remote_settings_saved_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationRemoteSettingsHasChangedFromSavedState)
const notificationRemoteSettingsHasChangedFromSavedStateProvider =
    NotificationRemoteSettingsHasChangedFromSavedStateProvider._();

final class NotificationRemoteSettingsHasChangedFromSavedStateProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const NotificationRemoteSettingsHasChangedFromSavedStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRemoteSettingsHasChangedFromSavedStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$notificationRemoteSettingsHasChangedFromSavedStateHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return notificationRemoteSettingsHasChangedFromSavedState(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$notificationRemoteSettingsHasChangedFromSavedStateHash() =>
    r'b72f7eaad0a8e883c6afc2565bb82dafaac2de03';

@ProviderFor(NotificationRemoteSettingsSavedStateNotifier)
const notificationRemoteSettingsSavedStateProvider =
    NotificationRemoteSettingsSavedStateNotifierProvider._();

final class NotificationRemoteSettingsSavedStateNotifierProvider
    extends
        $AsyncNotifierProvider<
          NotificationRemoteSettingsSavedStateNotifier,
          NotificationRemoteSettingsState
        > {
  const NotificationRemoteSettingsSavedStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRemoteSettingsSavedStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$notificationRemoteSettingsSavedStateNotifierHash();

  @$internal
  @override
  NotificationRemoteSettingsSavedStateNotifier create() =>
      NotificationRemoteSettingsSavedStateNotifier();
}

String _$notificationRemoteSettingsSavedStateNotifierHash() =>
    r'87a8cf986cfedcd4dec8b6c72acd94650ba67308';

abstract class _$NotificationRemoteSettingsSavedStateNotifier
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
