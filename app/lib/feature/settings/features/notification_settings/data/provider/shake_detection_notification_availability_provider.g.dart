// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_notification_availability_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(isShakeDetectionNotificationAvailable)
final isShakeDetectionNotificationAvailableProvider =
    IsShakeDetectionNotificationAvailableProvider._();

final class IsShakeDetectionNotificationAvailableProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  IsShakeDetectionNotificationAvailableProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isShakeDetectionNotificationAvailableProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$isShakeDetectionNotificationAvailableHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return isShakeDetectionNotificationAvailable(ref);
  }
}

String _$isShakeDetectionNotificationAvailableHash() =>
    r'83829d67b1b095c31fed2dac6bb1f4c9931f85c2';
