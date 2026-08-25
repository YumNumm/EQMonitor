import 'package:freezed_annotation/freezed_annotation.dart';

part 'pmtiles_v3_limits.freezed.dart';

/// Archive-agnostic上限値。呼び出し側が明示し、decoder内部に固定fallbackは
/// 置かない。値そのものはPMTiles v3の仕様上の要求ではなく、この reader
/// 実装が安全に走査できる範囲を決める運用値であり、既存の
/// `seismicity_pmtiles` が使っていた固定値をそのまま引数化したもの。
@freezed
abstract class PmTilesV3Limits with _$PmTilesV3Limits {
  const factory({
    /// directory treeを辿る最大深さ。3を超えるarchiveは corrupt として拒否する。
    required int maxDirectoryDepth,

    /// root directoryが収まっているべき先頭からのwindow長（byte）。
    required int rootDirectoryWindowLength,

    /// root/leaf directoryの圧縮済みbyte列1件あたりの上限。
    required int maxDirectoryEncodedBytes,

    /// root/leaf directoryの展開済みbyte列1件あたりの上限。
    required int maxDirectoryDecodedBytes,

    /// tile payloadの圧縮済みbyte列1件あたりの上限。
    required int maxTileEncodedBytes,

    /// tile payloadの展開済みbyte列1件あたりの上限。
    required int maxTileDecodedBytes,

    /// `open`時にarchive全体のleaf directoryをeagerに走査し、clustered
    /// ordering・件数などをarchive全体について再検証するかどうか。
    ///
    /// 既定は`false`（何もscanしない）。安全な既定値である理由は、
    /// 「eager検証を省いても安全だから」ではなく、設計正本
    /// (`docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md`)
    /// が「runtimeはheader/metadataの整合と各tile読み取り時のbounded検証を
    /// 正とし、archive全体をscanしてglobal coverageや件数を再検証すること
    /// はしない」と定めているためである。archive全体の整合性検証は
    /// producer/release validatorの責務であり、runtimeが毎回開くたびに
    /// 全leaf directoryを読む契約はここでは負わない。
    ///
    /// `true`にすると、rootおよびすべてのleaf directoryを`open`時に走査し、
    /// `clustered`ヘッダが`true`の場合は`PmTilesV3ClusteredOrdering`で
    /// content配置の整合まで検証する。producer契約がclustered orderingと
    /// tile件数の一致を保証しているarchive（例: `seismicity_pmtiles`が
    /// 生成するarchive）でのみ有効化すること。
    @Default(false) bool validateEntireArchiveEagerly,
  }) = _PmTilesV3Limits;
}
