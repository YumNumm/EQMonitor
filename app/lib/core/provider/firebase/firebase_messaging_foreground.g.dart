// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'firebase_messaging_foreground.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localNotificationRepository)
final localNotificationRepositoryProvider =
    LocalNotificationRepositoryProvider._();

final class LocalNotificationRepositoryProvider
    extends
        $FunctionalProvider<
          LocalNotificationRepository,
          LocalNotificationRepository,
          LocalNotificationRepository
        >
    with $Provider<LocalNotificationRepository> {
  LocalNotificationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localNotificationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localNotificationRepositoryHash();

  @$internal
  @override
  $ProviderElement<LocalNotificationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalNotificationRepository create(Ref ref) {
    return localNotificationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalNotificationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalNotificationRepository>(value),
    );
  }
}

String _$localNotificationRepositoryHash() =>
    r'9aa39e789894537147b41cc7c1bbf7f2ebcd5de9';

@ProviderFor(firebaseMessagingForeground)
final firebaseMessagingForegroundProvider =
    FirebaseMessagingForegroundProvider._();

final class FirebaseMessagingForegroundProvider
    extends
        $FunctionalProvider<
          AsyncValue<RemoteMessage>,
          RemoteMessage,
          Stream<RemoteMessage>
        >
    with $FutureModifier<RemoteMessage>, $StreamProvider<RemoteMessage> {
  FirebaseMessagingForegroundProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseMessagingForegroundProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseMessagingForegroundHash();

  @$internal
  @override
  $StreamProviderElement<RemoteMessage> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<RemoteMessage> create(Ref ref) {
    return firebaseMessagingForeground(ref);
  }
}

String _$firebaseMessagingForegroundHash() =>
    r'b048aee1df71b5dba87082ccf9a8293792540aa8';
