import 'package:freezed_annotation/freezed_annotation.dart';

part 'pmtiles_v3_limits.freezed.dart';

/// Archive-agnostic上限値。呼び出し側が明示し、decoder内部に固定fallbackは
/// 置かない。値そのものはPMTiles v3の仕様上の要求ではなく、この reader
/// 実装が安全に走査できる範囲を決める運用値であり、既存の
/// `seismicity_pmtiles` が使っていた固定値をそのまま引数化したもの。
@freezed
abstract class PmTilesV3Limits with _$PmTilesV3Limits {
  const factory PmTilesV3Limits({
    /// directory treeを辿る最大深さ。3を超えるarchiveは corrupt として拒否する。
    required int maxDirectoryDepth,

    /// root directoryが収まっているべき先頭からのwindow長（byte）。
    required int rootDirectoryWindowLength,
  }) = _PmTilesV3Limits;
}
