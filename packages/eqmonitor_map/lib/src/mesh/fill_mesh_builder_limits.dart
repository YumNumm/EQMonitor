import 'package:freezed_annotation/freezed_annotation.dart';

part 'fill_mesh_builder_limits.freezed.dart';

/// `FillMeshBuilder`がmesh生成時に適用する上限値。呼び出し側が明示し、
/// builder内部に固定fallbackは置かない
/// (`MvtDecodeLimits`と同じ運用方針。`lib/src/tile/mvt/mvt_decode_limits.dart`
/// 参照)。MVTのring/featureはPMTiles archiveから取得したuntrusted dataに
/// 由来するため、壊れた・悪意あるtileが宣言する巨大なring数でメモリを
/// 食い潰さないための運用値であって、MVT仕様が要求する値ではない。
@freezed
abstract class FillMeshBuilderLimits with _$FillMeshBuilderLimits {
  const factory({
    /// 1つのpolygon(1つの外形とその穴の組)に含められる穴数の上限。
    /// MapLibre Nativeの`fill_generator.cpp`が`limitHoles(polygon, 500)`で
    /// 行っている制限と同じ位置付け。
    required int maxHolesPerPolygon,

    /// 1つのfeatureが持つ全ring(外形+穴、複数polygon分の合算)の頂点数の
    /// 上限。三角形化前の頂点バッファ確保量を抑える早期チェックとして働く。
    required int maxVerticesPerFeature,

    /// 1つの`FillMesh` segmentに積める頂点数の上限。index bufferが
    /// `Uint16List`であるため、呼び出し側がこの値を65536以下に設定しない
    /// 場合`FillMeshBuilder`はArgumentErrorを投げる(index値がuint16の範囲を
    /// 静かに超えて壊れたmeshを生成することを避けるための防御)。
    required int maxVerticesPerSegment,

    /// 自己交差検査で調べる、X範囲が重なる非隣接辺ペア数の上限。
    required int maxIntersectionChecks,
  }) = _FillMeshBuilderLimits;
}
