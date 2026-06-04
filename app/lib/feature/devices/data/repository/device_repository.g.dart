// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceRepository)
final deviceRepositoryProvider = DeviceRepositoryProvider._();

final class DeviceRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<DeviceRepository>,
          DeviceRepository,
          FutureOr<DeviceRepository>
        >
    with $FutureModifier<DeviceRepository>, $FutureProvider<DeviceRepository> {
  DeviceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<DeviceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DeviceRepository> create(Ref ref) {
    return deviceRepository(ref);
  }
}

String _$deviceRepositoryHash() => r'a22e0ec8ecf7988430309cb7794c0d8b3f4b8dbc';
