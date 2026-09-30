// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_sound_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationSoundDataSource)
final notificationSoundDataSourceProvider =
    NotificationSoundDataSourceProvider._();

final class NotificationSoundDataSourceProvider
    extends
        $FunctionalProvider<
          NotificationSoundDataSource,
          NotificationSoundDataSource,
          NotificationSoundDataSource
        >
    with $Provider<NotificationSoundDataSource> {
  NotificationSoundDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationSoundDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationSoundDataSourceHash();

  @$internal
  @override
  $ProviderElement<NotificationSoundDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationSoundDataSource create(Ref ref) {
    return notificationSoundDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationSoundDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationSoundDataSource>(value),
    );
  }
}

String _$notificationSoundDataSourceHash() =>
    r'992db67fc1e0d2552a41371ae0c64920823849e8';
