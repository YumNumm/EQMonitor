// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'notification_local_settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(NotificationLocalSettingsNotifier)
const notificationLocalSettingsNotifierProvider =
    NotificationLocalSettingsNotifierProvider._();

final class NotificationLocalSettingsNotifierProvider
    extends
        $AsyncNotifierProvider<
          NotificationLocalSettingsNotifier,
          NotificationLocalSettingsModel
        > {
  const NotificationLocalSettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationLocalSettingsNotifierProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$notificationLocalSettingsNotifierHash();

  @$internal
  @override
  NotificationLocalSettingsNotifier create() =>
      NotificationLocalSettingsNotifier();

  @$internal
  @override
  $AsyncNotifierProviderElement<
    NotificationLocalSettingsNotifier,
    NotificationLocalSettingsModel
  >
  $createElement($ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(pointer);
}

String _$notificationLocalSettingsNotifierHash() =>
    r'7a81c66a60719bd428a39ec75b436274673bbf6c';

abstract class _$NotificationLocalSettingsNotifier
    extends $AsyncNotifier<NotificationLocalSettingsModel> {
  FutureOr<NotificationLocalSettingsModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<NotificationLocalSettingsModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NotificationLocalSettingsModel>>,
              AsyncValue<NotificationLocalSettingsModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
