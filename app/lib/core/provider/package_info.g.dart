// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'package_info.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(packageInfo)
const packageInfoProvider = PackageInfoProvider._();

final class PackageInfoProvider
    extends $FunctionalProvider<PackageInfo, PackageInfo, PackageInfo>
    with $Provider<PackageInfo> {
  const PackageInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'packageInfoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$packageInfoHash();

  @$internal
  @override
  $ProviderElement<PackageInfo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PackageInfo create(Ref ref) {
    return packageInfo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PackageInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PackageInfo>(value),
    );
  }
}

String _$packageInfoHash() => r'41becc3addedc53e378ee1d1462ccfd8ccf6cce1';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
