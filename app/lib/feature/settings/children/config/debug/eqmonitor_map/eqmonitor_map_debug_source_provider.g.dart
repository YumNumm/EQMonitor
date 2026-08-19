// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eqmonitor_map_debug_source_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// デバッグページが`BaseMapView`へ渡す[VerifiedPmTilesSource]と、その
/// archiveの実際のzoom範囲を組み立てる。
///
/// 通常は`AssetPackRepository.resolveAsset(AssetPackAssetId.baseMapPmtiles)`
/// が返す検証済み`File`をそのまま使う。Asset Packが未準備
/// ([AssetPackNotReadyException])の場合だけ、このデバッグページに限定した
/// override([EqmonitorMapDebugSourceResolver.resolveDebugOverride])を試し、
/// それも無ければ例外をそのまま再送出する(brief要求
/// 「AssetPackNotReadyExceptionはエラー表示へ流し、地図を空で描かない」)。

@ProviderFor(eqmonitorMapDebugSource)
final eqmonitorMapDebugSourceProvider = EqmonitorMapDebugSourceProvider._();

/// デバッグページが`BaseMapView`へ渡す[VerifiedPmTilesSource]と、その
/// archiveの実際のzoom範囲を組み立てる。
///
/// 通常は`AssetPackRepository.resolveAsset(AssetPackAssetId.baseMapPmtiles)`
/// が返す検証済み`File`をそのまま使う。Asset Packが未準備
/// ([AssetPackNotReadyException])の場合だけ、このデバッグページに限定した
/// override([EqmonitorMapDebugSourceResolver.resolveDebugOverride])を試し、
/// それも無ければ例外をそのまま再送出する(brief要求
/// 「AssetPackNotReadyExceptionはエラー表示へ流し、地図を空で描かない」)。

final class EqmonitorMapDebugSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<EqmonitorMapDebugSource>,
          EqmonitorMapDebugSource,
          FutureOr<EqmonitorMapDebugSource>
        >
    with
        $FutureModifier<EqmonitorMapDebugSource>,
        $FutureProvider<EqmonitorMapDebugSource> {
  /// デバッグページが`BaseMapView`へ渡す[VerifiedPmTilesSource]と、その
  /// archiveの実際のzoom範囲を組み立てる。
  ///
  /// 通常は`AssetPackRepository.resolveAsset(AssetPackAssetId.baseMapPmtiles)`
  /// が返す検証済み`File`をそのまま使う。Asset Packが未準備
  /// ([AssetPackNotReadyException])の場合だけ、このデバッグページに限定した
  /// override([EqmonitorMapDebugSourceResolver.resolveDebugOverride])を試し、
  /// それも無ければ例外をそのまま再送出する(brief要求
  /// 「AssetPackNotReadyExceptionはエラー表示へ流し、地図を空で描かない」)。
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
  $FutureProviderElement<EqmonitorMapDebugSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EqmonitorMapDebugSource> create(Ref ref) {
    return eqmonitorMapDebugSource(ref);
  }
}

String _$eqmonitorMapDebugSourceHash() =>
    r'a317276730d17bb184db48c0596f12fc0ebaccb7';
