// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_location_consumers_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceLocationConsumersRepository)
final deviceLocationConsumersRepositoryProvider =
    DeviceLocationConsumersRepositoryProvider._();

final class DeviceLocationConsumersRepositoryProvider
    extends
        $FunctionalProvider<
          DeviceLocationConsumersRepository,
          DeviceLocationConsumersRepository,
          DeviceLocationConsumersRepository
        >
    with $Provider<DeviceLocationConsumersRepository> {
  DeviceLocationConsumersRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceLocationConsumersRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$deviceLocationConsumersRepositoryHash();

  @$internal
  @override
  $ProviderElement<DeviceLocationConsumersRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceLocationConsumersRepository create(Ref ref) {
    return deviceLocationConsumersRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceLocationConsumersRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceLocationConsumersRepository>(
        value,
      ),
    );
  }
}

String _$deviceLocationConsumersRepositoryHash() =>
    r'973b12fa658b49569f5cfe7e927864e61169bbf4';
