// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_region_map_selection_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationRegionMapSelectionController)
final notificationRegionMapSelectionControllerProvider =
    NotificationRegionMapSelectionControllerProvider._();

final class NotificationRegionMapSelectionControllerProvider
    extends
        $NotifierProvider<
          NotificationRegionMapSelectionController,
          NotificationRegionMapSelection
        > {
  NotificationRegionMapSelectionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRegionMapSelectionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$notificationRegionMapSelectionControllerHash();

  @$internal
  @override
  NotificationRegionMapSelectionController create() =>
      NotificationRegionMapSelectionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRegionMapSelection value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationRegionMapSelection>(
        value,
      ),
    );
  }
}

String _$notificationRegionMapSelectionControllerHash() =>
    r'd6ee21cf1c47b2116caf02d4cfcdb91661c1b128';

abstract class _$NotificationRegionMapSelectionController
    extends $Notifier<NotificationRegionMapSelection> {
  NotificationRegionMapSelection build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              NotificationRegionMapSelection,
              NotificationRegionMapSelection
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                NotificationRegionMapSelection,
                NotificationRegionMapSelection
              >,
              NotificationRegionMapSelection,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
