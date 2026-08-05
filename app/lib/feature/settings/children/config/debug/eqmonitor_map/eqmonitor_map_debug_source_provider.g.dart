// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eqmonitor_map_debug_source_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// デバッグページが`BaseMapView`へ渡す[VerifiedPmTilesSource]を組み立てる。
///
/// 通常は`AssetPackRepository.resolveAsset(AssetPackAssetId.baseMapPmtiles)`
/// が返す検証済み`File`をそのまま使う。Asset Packが未準備
/// ([AssetPackNotReadyException])の場合だけ、このデバッグページに限定した
/// override([_resolveDebugOverride])を試し、それも無ければ例外をそのまま
/// 再送出する(brief要求「AssetPackNotReadyExceptionはエラー表示へ流し、
/// 地図を空で描かない」)。

@ProviderFor(eqmonitorMapDebugSource)
final eqmonitorMapDebugSourceProvider = EqmonitorMapDebugSourceProvider._();

/// デバッグページが`BaseMapView`へ渡す[VerifiedPmTilesSource]を組み立てる。
///
/// 通常は`AssetPackRepository.resolveAsset(AssetPackAssetId.baseMapPmtiles)`
/// が返す検証済み`File`をそのまま使う。Asset Packが未準備
/// ([AssetPackNotReadyException])の場合だけ、このデバッグページに限定した
/// override([_resolveDebugOverride])を試し、それも無ければ例外をそのまま
/// 再送出する(brief要求「AssetPackNotReadyExceptionはエラー表示へ流し、
/// 地図を空で描かない」)。

final class EqmonitorMapDebugSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<VerifiedPmTilesSource>,
          VerifiedPmTilesSource,
          FutureOr<VerifiedPmTilesSource>
        >
    with
        $FutureModifier<VerifiedPmTilesSource>,
        $FutureProvider<VerifiedPmTilesSource> {
  /// デバッグページが`BaseMapView`へ渡す[VerifiedPmTilesSource]を組み立てる。
  ///
  /// 通常は`AssetPackRepository.resolveAsset(AssetPackAssetId.baseMapPmtiles)`
  /// が返す検証済み`File`をそのまま使う。Asset Packが未準備
  /// ([AssetPackNotReadyException])の場合だけ、このデバッグページに限定した
  /// override([_resolveDebugOverride])を試し、それも無ければ例外をそのまま
  /// 再送出する(brief要求「AssetPackNotReadyExceptionはエラー表示へ流し、
  /// 地図を空で描かない」)。
  EqmonitorMapDebugSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eqmonitorMapDebugSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eqmonitorMapDebugSourceHash();

  @$internal
  @override
  $FutureProviderElement<VerifiedPmTilesSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<VerifiedPmTilesSource> create(Ref ref) {
    return eqmonitorMapDebugSource(ref);
  }
}

String _$eqmonitorMapDebugSourceHash() =>
    r'80ca4a37528748e31f8bf0757bebde1386f32da5';
