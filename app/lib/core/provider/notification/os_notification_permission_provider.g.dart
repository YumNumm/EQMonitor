// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'os_notification_permission_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(osNotificationPermission)
final osNotificationPermissionProvider = OsNotificationPermissionProvider._();

final class OsNotificationPermissionProvider
    extends
        $FunctionalProvider<
          AsyncValue<OsNotificationPermission>,
          OsNotificationPermission,
          FutureOr<OsNotificationPermission>
        >
    with
        $FutureModifier<OsNotificationPermission>,
        $FutureProvider<OsNotificationPermission> {
  OsNotificationPermissionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'osNotificationPermissionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$osNotificationPermissionHash();

  @$internal
  @override
  $FutureProviderElement<OsNotificationPermission> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<OsNotificationPermission> create(Ref ref) {
    return osNotificationPermission(ref);
  }
}

String _$osNotificationPermissionHash() =>
    r'596815cffcd5b1230ea4a422dcc80df1c5ea740f';
