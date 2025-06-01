// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'kyoshin_monitor_maintenance_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(kyoshinMonitorMaintenance)
const kyoshinMonitorMaintenanceProvider = KyoshinMonitorMaintenanceProvider._();

final class KyoshinMonitorMaintenanceProvider
    extends
        $FunctionalProvider<
          AsyncValue<kmoni_api.MaintenanceMessage>,
          FutureOr<kmoni_api.MaintenanceMessage>
        >
    with
        $FutureModifier<kmoni_api.MaintenanceMessage>,
        $FutureProvider<kmoni_api.MaintenanceMessage> {
  const KyoshinMonitorMaintenanceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorMaintenanceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorMaintenanceHash();

  @$internal
  @override
  $FutureProviderElement<kmoni_api.MaintenanceMessage> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<kmoni_api.MaintenanceMessage> create(Ref ref) {
    return kyoshinMonitorMaintenance(ref);
  }
}

String _$kyoshinMonitorMaintenanceHash() =>
    r'53cc188e79c961b1c1e80d0b8017dc16c9847536';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
