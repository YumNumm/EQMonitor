// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'asset_pack_debug_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Reads native diagnostics for the app-bundled Asset Pack.

@ProviderFor(assetPackDiagnostics)
final assetPackDiagnosticsProvider = AssetPackDiagnosticsProvider._();

/// Reads native diagnostics for the app-bundled Asset Pack.

final class AssetPackDiagnosticsProvider
    extends
        $FunctionalProvider<
          AsyncValue<AssetPackDiagnostics>,
          AssetPackDiagnostics,
          FutureOr<AssetPackDiagnostics>
        >
    with
        $FutureModifier<AssetPackDiagnostics>,
        $FutureProvider<AssetPackDiagnostics> {
  /// Reads native diagnostics for the app-bundled Asset Pack.
  AssetPackDiagnosticsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assetPackDiagnosticsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assetPackDiagnosticsHash();

  @$internal
  @override
  $FutureProviderElement<AssetPackDiagnostics> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AssetPackDiagnostics> create(Ref ref) {
    return assetPackDiagnostics(ref);
  }
}

String _$assetPackDiagnosticsHash() =>
    r'40c7c32b335640919509c430d2098c0034a67166';
