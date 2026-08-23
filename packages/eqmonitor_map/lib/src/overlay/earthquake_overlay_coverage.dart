import 'package:flutter/foundation.dart';

/// 可視範囲における地震overlayの準備状況。
@immutable
sealed class EarthquakeOverlayCoverage {
  const EarthquakeOverlayCoverage();

  const factory EarthquakeOverlayCoverage.hidden() = EarthquakeOverlayHidden;

  const factory EarthquakeOverlayCoverage.incomplete({
    required int requestedTileCount,
    required int readyTileCount,
    required int missingOrInvalidCodeCount,
  }) = EarthquakeOverlayIncomplete;

  const factory EarthquakeOverlayCoverage.complete({
    required int requestedTileCount,
  }) = EarthquakeOverlayComplete;

  /// tile準備数とcodeの妥当性からcoverageを導出する。
  factory EarthquakeOverlayCoverage.fromCounts({
    required int requestedTileCount,
    required int readyTileCount,
    required int missingOrInvalidCodeCount,
  }) {
    if (requestedTileCount < 0) {
      throw ArgumentError.value(requestedTileCount, 'requestedTileCount');
    }
    if (readyTileCount < 0 || readyTileCount > requestedTileCount) {
      throw ArgumentError.value(readyTileCount, 'readyTileCount');
    }
    if (missingOrInvalidCodeCount < 0) {
      throw ArgumentError.value(
        missingOrInvalidCodeCount,
        'missingOrInvalidCodeCount',
      );
    }
    if (requestedTileCount == 0) {
      return const EarthquakeOverlayCoverage.hidden();
    }
    if (readyTileCount < requestedTileCount || missingOrInvalidCodeCount > 0) {
      return EarthquakeOverlayCoverage.incomplete(
        requestedTileCount: requestedTileCount,
        readyTileCount: readyTileCount,
        missingOrInvalidCodeCount: missingOrInvalidCodeCount,
      );
    }
    return EarthquakeOverlayCoverage.complete(
      requestedTileCount: requestedTileCount,
    );
  }
}

/// Sceneへcommit済みのoverlay identityとcoverageを一体で表す通知値。
///
/// [EarthquakeOverlayCoverageSnapshot.hidden]はcommit済みoverlayがない状態、
/// 通常constructorでcoverageが[EarthquakeOverlayHidden]なら、該当overlayを
/// backgroundなどで一時的に描画していない状態を表す。
@immutable
final class EarthquakeOverlayCoverageSnapshot {
  const EarthquakeOverlayCoverageSnapshot({
    required String this.sourceId,
    required int this.revision,
    required this.coverage,
  });

  const EarthquakeOverlayCoverageSnapshot.hidden()
    : sourceId = null,
      revision = null,
      coverage = const EarthquakeOverlayCoverage.hidden();

  final String? sourceId;
  final int? revision;
  final EarthquakeOverlayCoverage coverage;

  @override
  bool operator ==(Object other) =>
      other is EarthquakeOverlayCoverageSnapshot &&
      other.sourceId == sourceId &&
      other.revision == revision &&
      other.coverage == coverage;

  @override
  int get hashCode => Object.hash(sourceId, revision, coverage);
}

/// overlayが非表示で、可視tileを要求していない状態。
final class EarthquakeOverlayHidden extends EarthquakeOverlayCoverage {
  const EarthquakeOverlayHidden();

  @override
  bool operator ==(Object other) => other is EarthquakeOverlayHidden;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// 可視tileまたは区域codeが不足している状態。
final class EarthquakeOverlayIncomplete extends EarthquakeOverlayCoverage {
  const EarthquakeOverlayIncomplete({
    required this.requestedTileCount,
    required this.readyTileCount,
    required this.missingOrInvalidCodeCount,
  });

  final int requestedTileCount;
  final int readyTileCount;
  final int missingOrInvalidCodeCount;

  @override
  bool operator ==(Object other) =>
      other is EarthquakeOverlayIncomplete &&
      other.requestedTileCount == requestedTileCount &&
      other.readyTileCount == readyTileCount &&
      other.missingOrInvalidCodeCount == missingOrInvalidCodeCount;

  @override
  int get hashCode => Object.hash(
    EarthquakeOverlayIncomplete,
    requestedTileCount,
    readyTileCount,
    missingOrInvalidCodeCount,
  );
}

/// 全ての可視tileと区域codeが揃っている状態。
final class EarthquakeOverlayComplete extends EarthquakeOverlayCoverage {
  const EarthquakeOverlayComplete({required this.requestedTileCount});

  final int requestedTileCount;

  @override
  bool operator ==(Object other) =>
      other is EarthquakeOverlayComplete &&
      other.requestedTileCount == requestedTileCount;

  @override
  int get hashCode => Object.hash(
    EarthquakeOverlayComplete,
    requestedTileCount,
  );
}
