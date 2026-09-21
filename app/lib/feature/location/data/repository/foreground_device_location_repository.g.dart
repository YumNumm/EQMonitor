// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'foreground_device_location_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(foregroundDeviceLocationRepository)
final foregroundDeviceLocationRepositoryProvider =
    ForegroundDeviceLocationRepositoryProvider._();

final class ForegroundDeviceLocationRepositoryProvider
    extends
        $FunctionalProvider<
          ForegroundDeviceLocationRepository,
          ForegroundDeviceLocationRepository,
          ForegroundDeviceLocationRepository
        >
    with $Provider<ForegroundDeviceLocationRepository> {
  ForegroundDeviceLocationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'foregroundDeviceLocationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$foregroundDeviceLocationRepositoryHash();

  @$internal
  @override
  $ProviderElement<ForegroundDeviceLocationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ForegroundDeviceLocationRepository create(Ref ref) {
    return foregroundDeviceLocationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ForegroundDeviceLocationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ForegroundDeviceLocationRepository>(
        value,
      ),
    );
  }
}

String _$foregroundDeviceLocationRepositoryHash() =>
    r'8f592332dba92087c8e562e4d5539e09d0f74718';
