// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_region_search.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationRegionSearch)
final notificationRegionSearchProvider = NotificationRegionSearchProvider._();

final class NotificationRegionSearchProvider
    extends
        $FunctionalProvider<
          NotificationRegionSearch,
          NotificationRegionSearch,
          NotificationRegionSearch
        >
    with $Provider<NotificationRegionSearch> {
  NotificationRegionSearchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRegionSearchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationRegionSearchHash();

  @$internal
  @override
  $ProviderElement<NotificationRegionSearch> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationRegionSearch create(Ref ref) {
    return notificationRegionSearch(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRegionSearch value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationRegionSearch>(value),
    );
  }
}

String _$notificationRegionSearchHash() =>
    r'69671fb5a5e768f992d8bbc196c6c7db3b7ebfd9';
