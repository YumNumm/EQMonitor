// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_sound_usage_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationSoundUsageRepository)
final notificationSoundUsageRepositoryProvider =
    NotificationSoundUsageRepositoryProvider._();

final class NotificationSoundUsageRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<NotificationSoundUsageRepository>,
          NotificationSoundUsageRepository,
          FutureOr<NotificationSoundUsageRepository>
        >
    with
        $FutureModifier<NotificationSoundUsageRepository>,
        $FutureProvider<NotificationSoundUsageRepository> {
  NotificationSoundUsageRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationSoundUsageRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationSoundUsageRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<NotificationSoundUsageRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NotificationSoundUsageRepository> create(Ref ref) {
    return notificationSoundUsageRepository(ref);
  }
}

String _$notificationSoundUsageRepositoryHash() =>
    r'ae276f706ad417360f9b4a93f9dfe1bf16f6df04';
