// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_sound_options.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationSoundOptions)
final notificationSoundOptionsProvider = NotificationSoundOptionsProvider._();

final class NotificationSoundOptionsProvider
    extends
        $FunctionalProvider<
          List<NotificationSoundSelection>,
          List<NotificationSoundSelection>,
          List<NotificationSoundSelection>
        >
    with $Provider<List<NotificationSoundSelection>> {
  NotificationSoundOptionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationSoundOptionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationSoundOptionsHash();

  @$internal
  @override
  $ProviderElement<List<NotificationSoundSelection>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<NotificationSoundSelection> create(Ref ref) {
    return notificationSoundOptions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<NotificationSoundSelection> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<NotificationSoundSelection>>(
        value,
      ),
    );
  }
}

String _$notificationSoundOptionsHash() =>
    r'2fe12d108844b3f365e4313d03f1958ce8e5aed2';
