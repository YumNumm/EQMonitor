// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_auth_token_interceptor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceAuthTokenInterceptor)
final deviceAuthTokenInterceptorProvider =
    DeviceAuthTokenInterceptorProvider._();

final class DeviceAuthTokenInterceptorProvider
    extends
        $FunctionalProvider<
          AsyncValue<DeviceAuthTokenInterceptor>,
          DeviceAuthTokenInterceptor,
          FutureOr<DeviceAuthTokenInterceptor>
        >
    with
        $FutureModifier<DeviceAuthTokenInterceptor>,
        $FutureProvider<DeviceAuthTokenInterceptor> {
  DeviceAuthTokenInterceptorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceAuthTokenInterceptorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceAuthTokenInterceptorHash();

  @$internal
  @override
  $FutureProviderElement<DeviceAuthTokenInterceptor> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DeviceAuthTokenInterceptor> create(Ref ref) {
    return deviceAuthTokenInterceptor(ref);
  }
}

String _$deviceAuthTokenInterceptorHash() =>
    r'5f747ed181b91d1dd0b29fb3761530b4df3fbea4';
