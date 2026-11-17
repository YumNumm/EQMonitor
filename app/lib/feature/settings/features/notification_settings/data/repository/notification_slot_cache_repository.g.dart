// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_slot_cache_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationSlotCacheRepository)
final notificationSlotCacheRepositoryProvider =
    NotificationSlotCacheRepositoryProvider._();

final class NotificationSlotCacheRepositoryProvider
    extends
        $FunctionalProvider<
          NotificationSlotCacheRepository,
          NotificationSlotCacheRepository,
          NotificationSlotCacheRepository
        >
    with $Provider<NotificationSlotCacheRepository> {
  NotificationSlotCacheRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationSlotCacheRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationSlotCacheRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotificationSlotCacheRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationSlotCacheRepository create(Ref ref) {
    return notificationSlotCacheRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationSlotCacheRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationSlotCacheRepository>(
        value,
      ),
    );
  }
}

String _$notificationSlotCacheRepositoryHash() =>
    r'8ccd3186151587ab849acbea94653148e0359191';
