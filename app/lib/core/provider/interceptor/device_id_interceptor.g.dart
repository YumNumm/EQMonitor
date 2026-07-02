// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_id_interceptor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceIdInterceptor)
final deviceIdInterceptorProvider = DeviceIdInterceptorProvider._();

final class DeviceIdInterceptorProvider
    extends
        $FunctionalProvider<
          AsyncValue<DeviceIdInterceptor>,
          DeviceIdInterceptor,
          FutureOr<DeviceIdInterceptor>
        >
    with
        $FutureModifier<DeviceIdInterceptor>,
        $FutureProvider<DeviceIdInterceptor> {
  DeviceIdInterceptorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceIdInterceptorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceIdInterceptorHash();

  @$internal
  @override
  $FutureProviderElement<DeviceIdInterceptor> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DeviceIdInterceptor> create(Ref ref) {
    return deviceIdInterceptor(ref);
  }
}

String _$deviceIdInterceptorHash() =>
    r'100206eca1ee4b75a8dfc53d8412dfed0de35cc0';
