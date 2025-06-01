// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'notification_remote_settings_saved_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(notificationRemoteSettingsHasChangedFromSavedState)
const notificationRemoteSettingsHasChangedFromSavedStateProvider =
    NotificationRemoteSettingsHasChangedFromSavedStateProvider._();

final class NotificationRemoteSettingsHasChangedFromSavedStateProvider
    extends $FunctionalProvider<bool, bool>
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
      providerOverride: $ValueProvider<bool>(value),
    );
  }
}

String _$notificationRemoteSettingsHasChangedFromSavedStateHash() =>
    r'c04adf9bbda4cbfdbdfd8034f0604d332adaa85f';

@ProviderFor(NotificationRemoteSettingsSavedStateNotifier)
const notificationRemoteSettingsSavedStateNotifierProvider =
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
        name: r'notificationRemoteSettingsSavedStateNotifierProvider',
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

  @$internal
  @override
  $AsyncNotifierProviderElement<
    NotificationRemoteSettingsSavedStateNotifier,
    NotificationRemoteSettingsState
  >
  $createElement($ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(pointer);
}

String _$notificationRemoteSettingsSavedStateNotifierHash() =>
    r'025f0ceee184a458195f2fc5ed2a87e8c80efea4';

abstract class _$NotificationRemoteSettingsSavedStateNotifier
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
