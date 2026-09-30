// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'custom_notification_sound_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(customNotificationSoundAction)
final customNotificationSoundActionProvider =
    CustomNotificationSoundActionProvider._();

final class CustomNotificationSoundActionProvider
    extends
        $FunctionalProvider<
          CustomNotificationSoundAction,
          CustomNotificationSoundAction,
          CustomNotificationSoundAction
        >
    with $Provider<CustomNotificationSoundAction> {
  CustomNotificationSoundActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customNotificationSoundActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customNotificationSoundActionHash();

  @$internal
  @override
  $ProviderElement<CustomNotificationSoundAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CustomNotificationSoundAction create(Ref ref) {
    return customNotificationSoundAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CustomNotificationSoundAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CustomNotificationSoundAction>(
        value,
      ),
    );
  }
}

String _$customNotificationSoundActionHash() =>
    r'7cf7b85f7d8380d9f98fd6a95e75ad9e0ddc35f2';
