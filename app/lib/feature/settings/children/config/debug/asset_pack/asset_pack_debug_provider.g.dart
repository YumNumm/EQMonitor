// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'asset_pack_debug_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Builds [AssetPackDebugInfo] for the Asset Pack debug page.
///
/// Errors with [AssetPackNotReadyException] (surfaced as `AsyncError`) when the
/// pack is unavailable; the debug page renders the exception message in that
/// case rather than treating it as a fatal error.

@ProviderFor(assetPackDebugInfo)
final assetPackDebugInfoProvider = AssetPackDebugInfoProvider._();

/// Builds [AssetPackDebugInfo] for the Asset Pack debug page.
///
/// Errors with [AssetPackNotReadyException] (surfaced as `AsyncError`) when the
/// pack is unavailable; the debug page renders the exception message in that
/// case rather than treating it as a fatal error.

final class AssetPackDebugInfoProvider
    extends
        $FunctionalProvider<
          AsyncValue<AssetPackDebugInfo>,
          AssetPackDebugInfo,
          FutureOr<AssetPackDebugInfo>
        >
    with
        $FutureModifier<AssetPackDebugInfo>,
        $FutureProvider<AssetPackDebugInfo> {
  /// Builds [AssetPackDebugInfo] for the Asset Pack debug page.
  ///
  /// Errors with [AssetPackNotReadyException] (surfaced as `AsyncError`) when the
  /// pack is unavailable; the debug page renders the exception message in that
  /// case rather than treating it as a fatal error.
  AssetPackDebugInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assetPackDebugInfoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assetPackDebugInfoHash();

  @$internal
  @override
  $FutureProviderElement<AssetPackDebugInfo> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AssetPackDebugInfo> create(Ref ref) {
    return assetPackDebugInfo(ref);
  }
}

String _$assetPackDebugInfoHash() =>
    r'0f0cb1f10f28cfc414f70b0f11642ca46a2a7b16';
