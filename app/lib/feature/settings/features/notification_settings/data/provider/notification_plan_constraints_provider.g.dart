// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_plan_constraints_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationPlanConstraints)
final notificationPlanConstraintsProvider =
    NotificationPlanConstraintsProvider._();

final class NotificationPlanConstraintsProvider
    extends
        $FunctionalProvider<
          AsyncValue<api.PlanConstraints>,
          AsyncValue<api.PlanConstraints>,
          AsyncValue<api.PlanConstraints>
        >
    with $Provider<AsyncValue<api.PlanConstraints>> {
  NotificationPlanConstraintsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPlanConstraintsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationPlanConstraintsHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<api.PlanConstraints>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<api.PlanConstraints> create(Ref ref) {
    return notificationPlanConstraints(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<api.PlanConstraints> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<api.PlanConstraints>>(
        value,
      ),
    );
  }
}

String _$notificationPlanConstraintsHash() =>
    r'dea573ec9af6cd9269506b190de5738ea073fd85';
