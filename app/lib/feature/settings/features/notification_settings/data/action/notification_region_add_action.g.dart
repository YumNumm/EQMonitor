// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_region_add_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationRegionAddAction)
final notificationRegionAddActionProvider =
    NotificationRegionAddActionProvider._();

final class NotificationRegionAddActionProvider
    extends
        $FunctionalProvider<
          NotificationRegionAddAction,
          NotificationRegionAddAction,
          NotificationRegionAddAction
        >
    with $Provider<NotificationRegionAddAction> {
  NotificationRegionAddActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRegionAddActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationRegionAddActionHash();

  @$internal
  @override
  $ProviderElement<NotificationRegionAddAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationRegionAddAction create(Ref ref) {
    return notificationRegionAddAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRegionAddAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationRegionAddAction>(value),
    );
  }
}

String _$notificationRegionAddActionHash() =>
    r'35f32a035274dde2d47b560d2ea182bb37698f8c';
