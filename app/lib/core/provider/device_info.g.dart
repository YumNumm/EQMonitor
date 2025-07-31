// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_info.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(androidDeviceInfo)
const androidDeviceInfoProvider = AndroidDeviceInfoProvider._();

final class AndroidDeviceInfoProvider
    extends
        $FunctionalProvider<
          AndroidDeviceInfo,
          AndroidDeviceInfo,
          AndroidDeviceInfo
        >
    with $Provider<AndroidDeviceInfo> {
  const AndroidDeviceInfoProvider._()
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
const iosDeviceInfoProvider = IosDeviceInfoProvider._();

final class IosDeviceInfoProvider
    extends $FunctionalProvider<IosDeviceInfo, IosDeviceInfo, IosDeviceInfo>
    with $Provider<IosDeviceInfo> {
  const IosDeviceInfoProvider._()
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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
