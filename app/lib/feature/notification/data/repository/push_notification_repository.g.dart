// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'push_notification_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pushNotificationRepository)
final pushNotificationRepositoryProvider =
    PushNotificationRepositoryProvider._();

final class PushNotificationRepositoryProvider
    extends
        $FunctionalProvider<
          PushNotificationRepository,
          PushNotificationRepository,
          PushNotificationRepository
        >
    with $Provider<PushNotificationRepository> {
  PushNotificationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushNotificationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushNotificationRepositoryHash();

  @$internal
  @override
  $ProviderElement<PushNotificationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PushNotificationRepository create(Ref ref) {
    return pushNotificationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PushNotificationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PushNotificationRepository>(value),
    );
  }
}

String _$pushNotificationRepositoryHash() =>
    r'5efdd26888ce50cf9d38c56972f38196ad82860a';
