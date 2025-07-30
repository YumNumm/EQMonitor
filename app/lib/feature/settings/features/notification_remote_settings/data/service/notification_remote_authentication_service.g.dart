// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'notification_remote_authentication_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(notificationRemoteAuthenticateService)
const notificationRemoteAuthenticateServiceProvider =
    NotificationRemoteAuthenticateServiceProvider._();

final class NotificationRemoteAuthenticateServiceProvider
    extends
        $FunctionalProvider<
          NotificationRemoteAuthenticationService,
          NotificationRemoteAuthenticationService,
          NotificationRemoteAuthenticationService
        >
    with $Provider<NotificationRemoteAuthenticationService> {
  const NotificationRemoteAuthenticateServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRemoteAuthenticateServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$notificationRemoteAuthenticateServiceHash();

  @$internal
  @override
  $ProviderElement<NotificationRemoteAuthenticationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationRemoteAuthenticationService create(Ref ref) {
    return notificationRemoteAuthenticateService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRemoteAuthenticationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<NotificationRemoteAuthenticationService>(value),
    );
  }
}

String _$notificationRemoteAuthenticateServiceHash() =>
    r'98471376ed9c8902c7243c5b897f5e8555640b48';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
