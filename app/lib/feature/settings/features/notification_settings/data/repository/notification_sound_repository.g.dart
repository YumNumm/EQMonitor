// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_sound_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationSoundRepository)
final notificationSoundRepositoryProvider =
    NotificationSoundRepositoryProvider._();

final class NotificationSoundRepositoryProvider
    extends
        $FunctionalProvider<
          NotificationSoundRepository,
          NotificationSoundRepository,
          NotificationSoundRepository
        >
    with $Provider<NotificationSoundRepository> {
  NotificationSoundRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationSoundRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationSoundRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotificationSoundRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationSoundRepository create(Ref ref) {
    return notificationSoundRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationSoundRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationSoundRepository>(value),
    );
  }
}

String _$notificationSoundRepositoryHash() =>
    r'3da836769c0d0c8dbe01b7dfb405c8a4b5b73b70';
