import 'package:eqmonitor_map/src/overlay/map_overlay_version_stamp.dart';
import 'package:flutter/foundation.dart';

/// 可視範囲における地震overlayの準備状況。
@immutable
sealed class EarthquakeOverlayCoverage {
  const EarthquakeOverlayCoverage();

  const factory EarthquakeOverlayCoverage.hidden() = EarthquakeOverlayHidden;

  const factory EarthquakeOverlayCoverage.loading() = EarthquakeOverlayLoading;

  const factory EarthquakeOverlayCoverage.incomplete({
    required int requestedTileCount,
    required int readyTileCount,
    required int missingOrInvalidCodeCount,
  }) = EarthquakeOverlayIncomplete;

  const factory EarthquakeOverlayCoverage.complete({
    required int requestedTileCount,
  }) = EarthquakeOverlayComplete;

  /// 可視範囲について確認済みの診断だけからcoverageを導出する。
  factory EarthquakeOverlayCoverage.fromDiagnostic(
    EarthquakeOverlayCoverageDiagnostic diagnostic,
  ) {
    if (diagnostic.visibleCanonicalTileCount == 0) {
      return const EarthquakeOverlayCoverage.hidden();
    }
    if (diagnostic.pendingTileCount > 0) {
      return const EarthquakeOverlayCoverage.loading();
    }
    final incomplete =
        diagnostic.sourceLayerAbsentTileCount > 0 ||
        diagnostic.missingOrInvalidPropertyFeatureCount > 0 ||
        diagnostic.decodeOrSchemaFailureTileCount > 0 ||
        diagnostic.requiredCodeUnresolvedCount > 0;
    if (incomplete) {
      return EarthquakeOverlayCoverage.incomplete(
        requestedTileCount: diagnostic.visibleCanonicalTileCount,
        readyTileCount:
            diagnostic.visibleCanonicalTileCount -
            diagnostic.sourceLayerAbsentTileCount -
            diagnostic.decodeOrSchemaFailureTileCount,
        missingOrInvalidCodeCount:
            diagnostic.missingOrInvalidPropertyFeatureCount +
            diagnostic.requiredCodeUnresolvedCount,
      );
    }
    return EarthquakeOverlayCoverage.complete(
      requestedTileCount: diagnostic.visibleCanonicalTileCount,
    );
  }

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
    required MapOverlayVersionStamp this.versionStamp,
    required this.coverage,
    this.diagnostic = const EarthquakeOverlayCoverageDiagnostic.empty(),
  });

  const EarthquakeOverlayCoverageSnapshot.hidden()
    : versionStamp = null,
      coverage = const EarthquakeOverlayCoverage.hidden(),
      diagnostic = const EarthquakeOverlayCoverageDiagnostic.empty();

  final MapOverlayVersionStamp? versionStamp;
  final EarthquakeOverlayCoverage coverage;
  final EarthquakeOverlayCoverageDiagnostic diagnostic;

  @override
  bool operator ==(Object other) =>
      other is EarthquakeOverlayCoverageSnapshot &&
      other.versionStamp == versionStamp &&
      other.coverage == coverage &&
      other.diagnostic == diagnostic;

  @override
  int get hashCode => Object.hash(versionStamp, coverage, diagnostic);
}

/// 同じoverlay stampとatomicに通知する可視範囲の診断値。
@immutable
final class EarthquakeOverlayCoverageDiagnostic {
  factory EarthquakeOverlayCoverageDiagnostic({
    required int visibleCanonicalTileCount,
    required int pendingTileCount,
    required int authoritativeEmptyTileCount,
    required int sourceLayerAbsentTileCount,
    required int missingOrInvalidPropertyFeatureCount,
    required int decodeOrSchemaFailureTileCount,
    required int requiredCodeUnresolvedCount,
    required int stationCount,
    required int spriteCount,
  }) {
    final counts = [
      visibleCanonicalTileCount,
      pendingTileCount,
      authoritativeEmptyTileCount,
      sourceLayerAbsentTileCount,
      missingOrInvalidPropertyFeatureCount,
      decodeOrSchemaFailureTileCount,
      requiredCodeUnresolvedCount,
      stationCount,
      spriteCount,
    ];
    if (counts.any((count) => count < 0)) {
      throw ArgumentError.value(counts, 'counts', 'must be non-negative');
    }
    final classifiedTileCount =
        pendingTileCount +
        authoritativeEmptyTileCount +
        sourceLayerAbsentTileCount +
        decodeOrSchemaFailureTileCount;
    if (classifiedTileCount > visibleCanonicalTileCount) {
      throw ArgumentError.value(
        classifiedTileCount,
        'classifiedTileCount',
        'must not exceed visibleCanonicalTileCount',
      );
    }
    return EarthquakeOverlayCoverageDiagnostic._(
      visibleCanonicalTileCount: visibleCanonicalTileCount,
      pendingTileCount: pendingTileCount,
      authoritativeEmptyTileCount: authoritativeEmptyTileCount,
      sourceLayerAbsentTileCount: sourceLayerAbsentTileCount,
      missingOrInvalidPropertyFeatureCount:
          missingOrInvalidPropertyFeatureCount,
      decodeOrSchemaFailureTileCount: decodeOrSchemaFailureTileCount,
      requiredCodeUnresolvedCount: requiredCodeUnresolvedCount,
      stationCount: stationCount,
      spriteCount: spriteCount,
    );
  }

  const EarthquakeOverlayCoverageDiagnostic._({
    required this.visibleCanonicalTileCount,
    required this.pendingTileCount,
    required this.authoritativeEmptyTileCount,
    required this.sourceLayerAbsentTileCount,
    required this.missingOrInvalidPropertyFeatureCount,
    required this.decodeOrSchemaFailureTileCount,
    required this.requiredCodeUnresolvedCount,
    required this.stationCount,
    required this.spriteCount,
  });

  const EarthquakeOverlayCoverageDiagnostic.empty()
    : visibleCanonicalTileCount = 0,
      pendingTileCount = 0,
      authoritativeEmptyTileCount = 0,
      sourceLayerAbsentTileCount = 0,
      missingOrInvalidPropertyFeatureCount = 0,
      decodeOrSchemaFailureTileCount = 0,
      requiredCodeUnresolvedCount = 0,
      stationCount = 0,
      spriteCount = 0;

  factory EarthquakeOverlayCoverageDiagnostic.preparing({
    required int stationCount,
    required int spriteCount,
  }) => EarthquakeOverlayCoverageDiagnostic(
    visibleCanonicalTileCount: 0,
    pendingTileCount: 0,
    authoritativeEmptyTileCount: 0,
    sourceLayerAbsentTileCount: 0,
    missingOrInvalidPropertyFeatureCount: 0,
    decodeOrSchemaFailureTileCount: 0,
    requiredCodeUnresolvedCount: 0,
    stationCount: stationCount,
    spriteCount: spriteCount,
  );

  final int visibleCanonicalTileCount;
  final int pendingTileCount;
  final int authoritativeEmptyTileCount;
  final int sourceLayerAbsentTileCount;
  final int missingOrInvalidPropertyFeatureCount;
  final int decodeOrSchemaFailureTileCount;
  final int requiredCodeUnresolvedCount;
  final int stationCount;
  final int spriteCount;

  @override
  bool operator ==(Object other) =>
      other is EarthquakeOverlayCoverageDiagnostic &&
      other.visibleCanonicalTileCount == visibleCanonicalTileCount &&
      other.pendingTileCount == pendingTileCount &&
      other.authoritativeEmptyTileCount == authoritativeEmptyTileCount &&
      other.sourceLayerAbsentTileCount == sourceLayerAbsentTileCount &&
      other.missingOrInvalidPropertyFeatureCount ==
          missingOrInvalidPropertyFeatureCount &&
      other.decodeOrSchemaFailureTileCount == decodeOrSchemaFailureTileCount &&
      other.requiredCodeUnresolvedCount == requiredCodeUnresolvedCount &&
      other.stationCount == stationCount &&
      other.spriteCount == spriteCount;

  @override
  int get hashCode => Object.hash(
    visibleCanonicalTileCount,
    pendingTileCount,
    authoritativeEmptyTileCount,
    sourceLayerAbsentTileCount,
    missingOrInvalidPropertyFeatureCount,
    decodeOrSchemaFailureTileCount,
    requiredCodeUnresolvedCount,
    stationCount,
    spriteCount,
  );
}

/// overlayが非表示で、可視tileを要求していない状態。
final class EarthquakeOverlayHidden extends EarthquakeOverlayCoverage {
  const EarthquakeOverlayHidden();

  @override
  bool operator ==(Object other) => other is EarthquakeOverlayHidden;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// commit候補のtile/material/textureを準備している状態。
final class EarthquakeOverlayLoading extends EarthquakeOverlayCoverage {
  const EarthquakeOverlayLoading();

  @override
  bool operator ==(Object other) => other is EarthquakeOverlayLoading;

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
