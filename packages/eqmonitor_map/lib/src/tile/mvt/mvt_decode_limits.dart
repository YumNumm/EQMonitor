import 'package:freezed_annotation/freezed_annotation.dart';

part 'mvt_decode_limits.freezed.dart';

/// MVT decode時の上限値。呼び出し側が明示し、decoder内部に固定fallbackは
/// 置かない。tile bytesはPMTiles archiveから取得したuntrusted dataであり、
/// 壊れた・悪意あるtileが宣言する巨大なcount値でメモリを食い潰さないための
/// 運用値であって、MVT仕様が要求する値ではない。
@freezed
abstract class MvtDecodeLimits with _$MvtDecodeLimits {
  const factory MvtDecodeLimits({
    /// 1つのtileに含められるlayer数の上限。
    required int maxLayers,

    /// 1つのlayerに含められるfeature数の上限。
    required int maxFeaturesPerLayer,

    /// 1つのfeatureに含められるring(パーツ)数の上限。
    required int maxRingsPerFeature,

    /// 1つのringに含められる頂点数の上限。
    required int maxVerticesPerRing,

    /// 1つのfeatureのgeometry commandが繰り返す操作回数の総和の上限。
    /// ring/頂点の上限はバッファへ積んだ後に効くのに対し、この上限は
    /// 単一のcommand headerが巨大なcountを宣言した時点で、頂点を読み出す
    /// 前に打ち切るための早期チェックとして働く。
    required int maxCommandsPerFeature,

    /// layer名のUTF-8 byte長の上限。length-delimitedフィールドの長さを
    /// 読んだ直後、文字列本体を読み出す前に検証する。
    required int maxLayerNameBytes,
  }) = _MvtDecodeLimits;
}
