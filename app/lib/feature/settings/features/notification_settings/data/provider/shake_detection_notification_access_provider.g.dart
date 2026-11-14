// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_notification_access_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shakeDetectionNotificationAccess)
final shakeDetectionNotificationAccessProvider =
    ShakeDetectionNotificationAccessProvider._();

final class ShakeDetectionNotificationAccessProvider
    extends
        $FunctionalProvider<
          ShakeDetectionNotificationAccess,
          ShakeDetectionNotificationAccess,
          ShakeDetectionNotificationAccess
        >
    with $Provider<ShakeDetectionNotificationAccess> {
  ShakeDetectionNotificationAccessProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionNotificationAccessProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionNotificationAccessHash();

  @$internal
  @override
  $ProviderElement<ShakeDetectionNotificationAccess> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShakeDetectionNotificationAccess create(Ref ref) {
    return shakeDetectionNotificationAccess(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShakeDetectionNotificationAccess value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShakeDetectionNotificationAccess>(
        value,
      ),
    );
  }
}

String _$shakeDetectionNotificationAccessHash() =>
    r'55b90ce5478876790698b271b50473366114cab8';
