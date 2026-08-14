import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_tile_pipeline_budget.freezed.dart';

/// tile pipeline(decode worker / cache / scheduler)へ呼び出し側が渡す
/// version 付き資源上限。
///
/// Global Constraints「上限・budget は呼び出し側が渡す version 付き設定。
/// decoder 内部の隠れた固定 fallback 禁止」に従い、全フィールドを必須にして
/// package 内に暗黙の既定値を持たせない。[schemaVersion]は呼び出し側の設定
/// スキーマ進化を追跡するためのもので、package はこの値を解釈せず保持だけ
/// する(将来の後方互換判定は呼び出し側の責務)。
///
/// [maxGpuUploadBytesPerFrame]のみ optional。GPU アップロード上限を課さない
/// 環境(未計測・非対象プラットフォーム)では`null`を渡す。存在する場合は
/// 正の値でなければならない。
///
/// `copyWith`は生成しない。生成すると
/// `budget.copyWith(maxInFlightDecodes: 0)`のように
/// [createMapTilePipelineBudget]の検証を迂回した budget を作れてしまい、
/// scheduler / cache がこの型の保証外の上限を受け取るため。値を変えるときは
/// 必ず[createMapTilePipelineBudget]から作り直す。
@Freezed(copyWith: false)
abstract class MapTilePipelineBudget with _$MapTilePipelineBudget {
  const factory MapTilePipelineBudget._({
    required int schemaVersion,
    required int maxInFlightDecodes,
    required int maxCacheEntries,
    required int maxPinnedEntries,
    required int cpuWorkUnitsPerFrame,
    required int? maxGpuUploadBytesPerFrame,
  }) = _MapTilePipelineBudget;
}

/// [MapTilePipelineBudget]を構造不変条件付きで生成する。違反時は
/// [ArgumentError](releaseでも必ず送出)。
MapTilePipelineBudget createMapTilePipelineBudget({
  required int schemaVersion,
  required int maxInFlightDecodes,
  required int maxCacheEntries,
  required int maxPinnedEntries,
  required int cpuWorkUnitsPerFrame,
  required int? maxGpuUploadBytesPerFrame,
}) {
  if (schemaVersion <= 0) {
    throw ArgumentError.value(schemaVersion, 'schemaVersion', 'must be > 0');
  }
  if (maxInFlightDecodes <= 0) {
    throw ArgumentError.value(
      maxInFlightDecodes,
      'maxInFlightDecodes',
      'must be > 0',
    );
  }
  if (maxCacheEntries <= 0) {
    throw ArgumentError.value(
      maxCacheEntries,
      'maxCacheEntries',
      'must be > 0',
    );
  }
  if (maxPinnedEntries < 0) {
    throw ArgumentError.value(
      maxPinnedEntries,
      'maxPinnedEntries',
      'must be >= 0',
    );
  }
  if (maxPinnedEntries > maxCacheEntries) {
    throw ArgumentError.value(
      maxPinnedEntries,
      'maxPinnedEntries',
      'must not exceed maxCacheEntries',
    );
  }
  if (cpuWorkUnitsPerFrame <= 0) {
    throw ArgumentError.value(
      cpuWorkUnitsPerFrame,
      'cpuWorkUnitsPerFrame',
      'must be > 0',
    );
  }
  if (maxGpuUploadBytesPerFrame != null && maxGpuUploadBytesPerFrame <= 0) {
    throw ArgumentError.value(
      maxGpuUploadBytesPerFrame,
      'maxGpuUploadBytesPerFrame',
      'must be > 0 when present',
    );
  }

  return MapTilePipelineBudget._(
    schemaVersion: schemaVersion,
    maxInFlightDecodes: maxInFlightDecodes,
    maxCacheEntries: maxCacheEntries,
    maxPinnedEntries: maxPinnedEntries,
    cpuWorkUnitsPerFrame: cpuWorkUnitsPerFrame,
    maxGpuUploadBytesPerFrame: maxGpuUploadBytesPerFrame,
  );
}
