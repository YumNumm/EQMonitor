// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_permission_dialog.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationPermissionDialogAction)
final notificationPermissionDialogActionProvider =
    NotificationPermissionDialogActionProvider._();

final class NotificationPermissionDialogActionProvider
    extends
        $FunctionalProvider<
          NotificationPermissionDialogAction,
          NotificationPermissionDialogAction,
          NotificationPermissionDialogAction
        >
    with $Provider<NotificationPermissionDialogAction> {
  NotificationPermissionDialogActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPermissionDialogActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$notificationPermissionDialogActionHash();

  @$internal
  @override
  $ProviderElement<NotificationPermissionDialogAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationPermissionDialogAction create(Ref ref) {
    return notificationPermissionDialogAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationPermissionDialogAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationPermissionDialogAction>(
        value,
      ),
    );
  }
}

String _$notificationPermissionDialogActionHash() =>
    r'7945a0e623170c3abb103812a4f2ac1afb226f04';
