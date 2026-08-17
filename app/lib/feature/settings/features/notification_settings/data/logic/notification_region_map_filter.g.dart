// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_region_map_filter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationRegionMapFilter)
final notificationRegionMapFilterProvider =
    NotificationRegionMapFilterProvider._();

final class NotificationRegionMapFilterProvider
    extends
        $FunctionalProvider<
          NotificationRegionMapFilter,
          NotificationRegionMapFilter,
          NotificationRegionMapFilter
        >
    with $Provider<NotificationRegionMapFilter> {
  NotificationRegionMapFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRegionMapFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationRegionMapFilterHash();

  @$internal
  @override
  $ProviderElement<NotificationRegionMapFilter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationRegionMapFilter create(Ref ref) {
    return notificationRegionMapFilter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRegionMapFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationRegionMapFilter>(value),
    );
  }
}

String _$notificationRegionMapFilterHash() =>
    r'f05c0aaff2abbd1314b0da902815c470c4ae8879';
