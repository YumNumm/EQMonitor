// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'asset_pack_debug_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 本番と同じ解決経路で、いま有効な Asset Pack の状態を読み出す。

@ProviderFor(assetPackDiagnostics)
final assetPackDiagnosticsProvider = AssetPackDiagnosticsProvider._();

/// 本番と同じ解決経路で、いま有効な Asset Pack の状態を読み出す。

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
  /// 本番と同じ解決経路で、いま有効な Asset Pack の状態を読み出す。
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
    r'8b3675f8c360372e68222d5b779403b061cdb9b2';
