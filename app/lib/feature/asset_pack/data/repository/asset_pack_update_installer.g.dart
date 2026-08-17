// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'asset_pack_update_installer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(assetPackUpdateInstaller)
final assetPackUpdateInstallerProvider = AssetPackUpdateInstallerProvider._();

final class AssetPackUpdateInstallerProvider
    extends
        $FunctionalProvider<
          AsyncValue<AssetPackUpdateInstaller>,
          AssetPackUpdateInstaller,
          FutureOr<AssetPackUpdateInstaller>
        >
    with
        $FutureModifier<AssetPackUpdateInstaller>,
        $FutureProvider<AssetPackUpdateInstaller> {
  AssetPackUpdateInstallerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assetPackUpdateInstallerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assetPackUpdateInstallerHash();

  @$internal
  @override
  $FutureProviderElement<AssetPackUpdateInstaller> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AssetPackUpdateInstaller> create(Ref ref) {
    return assetPackUpdateInstaller(ref);
  }
}

String _$assetPackUpdateInstallerHash() =>
    r'bf14b7863fb0135194126bed8cd5976f375c566e';
