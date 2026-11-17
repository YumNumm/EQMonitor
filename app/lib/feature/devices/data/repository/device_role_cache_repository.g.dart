// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_role_cache_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceRoleCacheRepository)
final deviceRoleCacheRepositoryProvider = DeviceRoleCacheRepositoryProvider._();

final class DeviceRoleCacheRepositoryProvider
    extends
        $FunctionalProvider<
          DeviceRoleCacheRepository,
          DeviceRoleCacheRepository,
          DeviceRoleCacheRepository
        >
    with $Provider<DeviceRoleCacheRepository> {
  DeviceRoleCacheRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceRoleCacheRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceRoleCacheRepositoryHash();

  @$internal
  @override
  $ProviderElement<DeviceRoleCacheRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceRoleCacheRepository create(Ref ref) {
    return deviceRoleCacheRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceRoleCacheRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceRoleCacheRepository>(value),
    );
  }
}

String _$deviceRoleCacheRepositoryHash() =>
    r'a732a7b5ba2f6ea966ec95622d897042844755d2';
