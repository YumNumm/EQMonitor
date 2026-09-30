// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_sound_platform.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(customNotificationSoundsSupported)
final customNotificationSoundsSupportedProvider =
    CustomNotificationSoundsSupportedProvider._();

final class CustomNotificationSoundsSupportedProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  CustomNotificationSoundsSupportedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customNotificationSoundsSupportedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$customNotificationSoundsSupportedHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return customNotificationSoundsSupported(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$customNotificationSoundsSupportedHash() =>
    r'05cf5e6a398a9ce39813e3c0d6648d9fa18a3dc8';
