// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_info.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(androidDeviceInfo)
final androidDeviceInfoProvider = AndroidDeviceInfoProvider._();

final class AndroidDeviceInfoProvider
    extends
        $FunctionalProvider<
          AndroidDeviceInfo,
          AndroidDeviceInfo,
          AndroidDeviceInfo
        >
    with $Provider<AndroidDeviceInfo> {
  AndroidDeviceInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'androidDeviceInfoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$androidDeviceInfoHash();

  @$internal
  @override
  $ProviderElement<AndroidDeviceInfo> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AndroidDeviceInfo create(Ref ref) {
    return androidDeviceInfo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AndroidDeviceInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AndroidDeviceInfo>(value),
    );
  }
}

String _$androidDeviceInfoHash() => r'02f1a66ec8a7e96d418eb9cb0a981fd40d5d2523';

@ProviderFor(iosDeviceInfo)
final iosDeviceInfoProvider = IosDeviceInfoProvider._();

final class IosDeviceInfoProvider
    extends $FunctionalProvider<IosDeviceInfo, IosDeviceInfo, IosDeviceInfo>
    with $Provider<IosDeviceInfo> {
  IosDeviceInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'iosDeviceInfoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$iosDeviceInfoHash();

  @$internal
  @override
  $ProviderElement<IosDeviceInfo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IosDeviceInfo create(Ref ref) {
    return iosDeviceInfo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IosDeviceInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IosDeviceInfo>(value),
    );
  }
}

String _$iosDeviceInfoHash() => r'5c95b3efca6425549ed7e884f54f041a61267149';
