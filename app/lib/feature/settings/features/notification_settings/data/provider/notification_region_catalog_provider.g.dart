// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_region_catalog_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationRegionCatalog)
final notificationRegionCatalogProvider = NotificationRegionCatalogProvider._();

final class NotificationRegionCatalogProvider
    extends
        $FunctionalProvider<
          AsyncValue<NotificationRegionCatalog>,
          NotificationRegionCatalog,
          FutureOr<NotificationRegionCatalog>
        >
    with
        $FutureModifier<NotificationRegionCatalog>,
        $FutureProvider<NotificationRegionCatalog> {
  NotificationRegionCatalogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRegionCatalogProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationRegionCatalogHash();

  @$internal
  @override
  $FutureProviderElement<NotificationRegionCatalog> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NotificationRegionCatalog> create(Ref ref) {
    return notificationRegionCatalog(ref);
  }
}

String _$notificationRegionCatalogHash() =>
    r'1b198d32091fa414010f5ce7f3497571a4e62894';
