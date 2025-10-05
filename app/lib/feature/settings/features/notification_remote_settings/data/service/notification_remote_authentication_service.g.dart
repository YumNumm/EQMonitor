// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_remote_authentication_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
    r'0d2182d09d47b433e16ff97a206bce5198d0b6b1';
