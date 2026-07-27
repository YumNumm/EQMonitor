// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'asset_pack_manifest_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Reads the Asset Pack `manifest.json` via [AssetPackRepository].
///
/// Errors with [AssetPackNotReadyException] (surfaced as `AsyncError`) when
/// the pack is not downloaded yet or is missing/corrupt — callers such as the
/// settings footer should treat that as an informational "未取得" state rather
/// than a hard error.

@ProviderFor(assetPackManifest)
final assetPackManifestProvider = AssetPackManifestProvider._();

/// Reads the Asset Pack `manifest.json` via [AssetPackRepository].
///
/// Errors with [AssetPackNotReadyException] (surfaced as `AsyncError`) when
/// the pack is not downloaded yet or is missing/corrupt — callers such as the
/// settings footer should treat that as an informational "未取得" state rather
/// than a hard error.

final class AssetPackManifestProvider
    extends
        $FunctionalProvider<
          AsyncValue<AssetPackManifest>,
          AssetPackManifest,
          FutureOr<AssetPackManifest>
        >
    with
        $FutureModifier<AssetPackManifest>,
        $FutureProvider<AssetPackManifest> {
  /// Reads the Asset Pack `manifest.json` via [AssetPackRepository].
  ///
  /// Errors with [AssetPackNotReadyException] (surfaced as `AsyncError`) when
  /// the pack is not downloaded yet or is missing/corrupt — callers such as the
  /// settings footer should treat that as an informational "未取得" state rather
  /// than a hard error.
  AssetPackManifestProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assetPackManifestProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assetPackManifestHash();

  @$internal
  @override
  $FutureProviderElement<AssetPackManifest> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AssetPackManifest> create(Ref ref) {
    return assetPackManifest(ref);
  }
}

String _$assetPackManifestHash() => r'88fbb99e869be3f9ddf568374bcea80cd097f00d';
