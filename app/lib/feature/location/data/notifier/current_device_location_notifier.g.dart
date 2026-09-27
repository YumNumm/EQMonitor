// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'current_device_location_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentDeviceLocation)
final currentDeviceLocationProvider = CurrentDeviceLocationProvider._();

final class CurrentDeviceLocationProvider
    extends
        $AsyncNotifierProvider<CurrentDeviceLocation, DeviceLocationPayload?> {
  CurrentDeviceLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentDeviceLocationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentDeviceLocationHash();

  @$internal
  @override
  CurrentDeviceLocation create() => CurrentDeviceLocation();
}

String _$currentDeviceLocationHash() =>
    r'f9499bb3122da1ba7792af1701fdd5854d35496f';

abstract class _$CurrentDeviceLocation
    extends $AsyncNotifier<DeviceLocationPayload?> {
  FutureOr<DeviceLocationPayload?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<DeviceLocationPayload?>, DeviceLocationPayload?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<DeviceLocationPayload?>,
                DeviceLocationPayload?
              >,
              AsyncValue<DeviceLocationPayload?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
