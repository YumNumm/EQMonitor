// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceAuthRepository)
final deviceAuthRepositoryProvider = DeviceAuthRepositoryProvider._();

final class DeviceAuthRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<DeviceAuthRepository>,
          DeviceAuthRepository,
          FutureOr<DeviceAuthRepository>
        >
    with
        $FutureModifier<DeviceAuthRepository>,
        $FutureProvider<DeviceAuthRepository> {
  DeviceAuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceAuthRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceAuthRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<DeviceAuthRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DeviceAuthRepository> create(Ref ref) {
    return deviceAuthRepository(ref);
  }
}

String _$deviceAuthRepositoryHash() =>
    r'f3d024596e2b87aa6d11c7c577b2104984121a08';
