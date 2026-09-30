// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_sound_operation_coordinator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationSoundOperationCoordinator)
final notificationSoundOperationCoordinatorProvider =
    NotificationSoundOperationCoordinatorProvider._();

final class NotificationSoundOperationCoordinatorProvider
    extends
        $FunctionalProvider<
          NotificationSoundOperationCoordinator,
          NotificationSoundOperationCoordinator,
          NotificationSoundOperationCoordinator
        >
    with $Provider<NotificationSoundOperationCoordinator> {
  NotificationSoundOperationCoordinatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationSoundOperationCoordinatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$notificationSoundOperationCoordinatorHash();

  @$internal
  @override
  $ProviderElement<NotificationSoundOperationCoordinator> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationSoundOperationCoordinator create(Ref ref) {
    return notificationSoundOperationCoordinator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationSoundOperationCoordinator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<NotificationSoundOperationCoordinator>(value),
    );
  }
}

String _$notificationSoundOperationCoordinatorHash() =>
    r'2fe819b1b4ba78a73b4ec7fbf5431fd6ec7734f4';
