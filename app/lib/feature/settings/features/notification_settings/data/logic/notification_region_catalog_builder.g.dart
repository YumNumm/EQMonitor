// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_region_catalog_builder.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationRegionCatalogBuilder)
final notificationRegionCatalogBuilderProvider =
    NotificationRegionCatalogBuilderProvider._();

final class NotificationRegionCatalogBuilderProvider
    extends
        $FunctionalProvider<
          NotificationRegionCatalogBuilder,
          NotificationRegionCatalogBuilder,
          NotificationRegionCatalogBuilder
        >
    with $Provider<NotificationRegionCatalogBuilder> {
  NotificationRegionCatalogBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRegionCatalogBuilderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationRegionCatalogBuilderHash();

  @$internal
  @override
  $ProviderElement<NotificationRegionCatalogBuilder> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationRegionCatalogBuilder create(Ref ref) {
    return notificationRegionCatalogBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRegionCatalogBuilder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationRegionCatalogBuilder>(
        value,
      ),
    );
  }
}

String _$notificationRegionCatalogBuilderHash() =>
    r'b6395a89034d6df6c1d4a25c4d85488f91ea3fbf';
