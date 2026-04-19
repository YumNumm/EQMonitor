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
          AsyncValue<PushNotificationRepository>,
          PushNotificationRepository,
          FutureOr<PushNotificationRepository>
        >
    with
        $FutureModifier<PushNotificationRepository>,
        $FutureProvider<PushNotificationRepository> {
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
  $FutureProviderElement<PushNotificationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PushNotificationRepository> create(Ref ref) {
    return pushNotificationRepository(ref);
  }
}

String _$pushNotificationRepositoryHash() =>
    r'a7d7237834f60f8e2518ce39e8e46b68f4142624';
