// ignore_for_file: invalid_use_of_internal_member

import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_overlay_banner.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

MapOverlayVersionStamp _versionStamp({
  required String sourceIdentity,
  String sourceIncarnation = 'incarnation-a',
  int dataSequence = 0,
  String dataDigest = 'data-a',
  int renderGeneration = 0,
  String renderDigest = 'render-a',
}) => createMapOverlayVersionStamp(
  sourceIdentity: createMapSourceIdentity(value: sourceIdentity),
  sourceIncarnation: createMapSourceIncarnation(value: sourceIncarnation),
  dataSequence: dataSequence,
  dataDigest: dataDigest,
  renderGeneration: renderGeneration,
  renderDigest: renderDigest,
);

EarthquakeMapOverlaySnapshot _snapshot(
  MapOverlayVersionStamp versionStamp, {
  List<EarthquakeAreaStyle> regionStyles = const [],
  List<EarthquakeAreaStyle> cityStyles = const [],
  List<EarthquakeObservationPoint> stations = const [],
  MapSpriteAtlas? spriteAtlas,
  List<MapPointSpriteFeature> sprites = const [],
}) => createEarthquakeMapOverlaySnapshot(
  versionStamp: versionStamp,
  regionToCityZoom: 6,
  stationMinZoom: 6,
  regionStyles: regionStyles,
  cityStyles: cityStyles,
  stations: stations,
  spriteAtlas: spriteAtlas,
  sprites: sprites,
  maxSpritePolicyBatches: 1,
);

MapSpriteAtlas _atlas() => createMapSpriteAtlas(
  identity: createMapSourceIdentity(value: 'atlas-a'),
  width: 1,
  height: 1,
  rgbaBytes: Uint8List.fromList(const [255, 255, 255, 255]),
  regions: const [
    MapSpriteRegion(
      id: 'normal',
      normalizedUv: Rect.fromLTRB(0.5, 0.5, 0.5, 0.5),
      logicalSize: Size(16, 16),
    ),
  ],
  limits: const MapSpriteAtlasLimits(
    maxWidth: 1,
    maxHeight: 1,
    maxPixelBytes: 4,
    maxRegions: 1,
  ),
);

MapPointSpriteFeature _hypocenter() => createMapPointSpriteFeature(
  id: 'hypocenter:A',
  longitude: 140.1,
  latitude: 36.2,
  spriteRegionId: 'normal',
  sizeScale: createMapZoomLinearRange(
    startZoom: 3,
    startValue: 0.15,
    endZoom: 20,
    endValue: 0.4,
  ),
  opacity: createMapZoomStep(
    thresholdZoom: 8,
    belowValue: 1,
    atOrAboveValue: 0.6,
  ),
  priority: 0,
);

LatestEarthquakeOverlayData _available(
  String eventId, {
  MapOverlayVersionStamp? versionStamp,
}) => LatestEarthquakeOverlayData(
  eventId: eventId,
  originTime: DateTime.utc(2026, 8, 23, 12, 34),
  telegramStatus: TelegramStatus.normal,
  availability: LatestEarthquakeOverlayAvailability.available,
  overlay: _snapshot(
    versionStamp ?? _versionStamp(sourceIdentity: eventId),
  ),
);

void main() {
  test('previous overlayを持つloadingでもoverlayをnullにして切替中を示す', () {
    final loading = const AsyncLoading<LatestEarthquakeOverlayData>()
        .copyWithPrevious(AsyncData(_available('A')));
    final presentation = EqmonitorMapOverlayPresentation.from(
      overlayState: loading,
      coverageSnapshot: null,
      committedCamera: null,
    );

    expect(presentation.overlay, isNull);
    expect(presentation.message, '最新の地震情報を取得中です');
    expect(presentation.eventIdLabel, '取得中');
  });

  test('previous overlayを持つerrorでもoverlayをnullにして例外全文を隠す', () {
    final error = AsyncError<LatestEarthquakeOverlayData>(
      Exception('非常に長い内部例外: secret-url-and-stack'),
      StackTrace.current,
    ).copyWithPrevious(AsyncData(_available('A')));
    final presentation = EqmonitorMapOverlayPresentation.from(
      overlayState: error,
      coverageSnapshot: null,
      committedCamera: null,
    );

    expect(presentation.overlay, isNull);
    expect(presentation.message, '最新の地震情報を取得できませんでした');
    expect(presentation.message, isNot(contains('secret-url')));
  });

  test('震度データなしはoverlayをnullにして専用状態を示す', () {
    const data = LatestEarthquakeOverlayData(
      eventId: 'A',
      originTime: null,
      telegramStatus: TelegramStatus.training,
      availability: LatestEarthquakeOverlayAvailability.noIntensity,
      overlay: null,
    );
    final presentation = EqmonitorMapOverlayPresentation.from(
      overlayState: const AsyncData(data),
      coverageSnapshot: null,
      committedCamera: null,
    );

    expect(presentation.overlay, isNull);
    expect(presentation.message, '震度データがありません');
    expect(presentation.statusLabel, '訓練');
  });

  test('current overlayのcoverage不完全をbannerへ明示する', () {
    final data = _available('A');
    final overlay = data.overlay as EarthquakeMapOverlaySnapshot;
    final presentation = EqmonitorMapOverlayPresentation.from(
      overlayState: AsyncData(data),
      committedCamera: null,
      coverageSnapshot: EarthquakeOverlayCoverageSnapshot(
        versionStamp: overlay.versionStamp,
        coverage: const EarthquakeOverlayCoverage.incomplete(
          requestedTileCount: 4,
          readyTileCount: 3,
          missingOrInvalidCodeCount: 1,
        ),
      ),
    );

    expect(presentation.overlay, same(data.overlay));
    expect(presentation.message, '表示範囲の震度情報は不完全です');
  });

  test('旧sourceのcoverageをcurrent overlayへ適用しない', () {
    final presentation = EqmonitorMapOverlayPresentation.from(
      overlayState: AsyncData(_available('B')),
      committedCamera: null,
      coverageSnapshot: EarthquakeOverlayCoverageSnapshot(
        versionStamp: _versionStamp(sourceIdentity: 'A'),
        coverage: const EarthquakeOverlayCoverage.complete(
          requestedTileCount: 4,
        ),
      ),
    );

    expect(presentation.message, '表示範囲の震度情報は未確定です');
  });

  test('同じsourceでもdata stampが異なるcoverageを適用しない', () {
    final presentation = EqmonitorMapOverlayPresentation.from(
      overlayState: AsyncData(_available('A')),
      committedCamera: null,
      coverageSnapshot: EarthquakeOverlayCoverageSnapshot(
        versionStamp: _versionStamp(
          sourceIdentity: 'A',
          dataSequence: 1,
          dataDigest: 'data-b',
          renderGeneration: 1,
          renderDigest: 'render-b',
        ),
        coverage: const EarthquakeOverlayCoverage.complete(
          requestedTileCount: 4,
        ),
      ),
    );

    expect(presentation.message, '表示範囲の震度情報は未確定です');
  });

  test('同じdataでもrender stampが異なるcoverageを適用しない', () {
    final presentation = EqmonitorMapOverlayPresentation.from(
      overlayState: AsyncData(_available('A')),
      committedCamera: null,
      coverageSnapshot: EarthquakeOverlayCoverageSnapshot(
        versionStamp: _versionStamp(
          sourceIdentity: 'A',
          renderGeneration: 1,
          renderDigest: 'render-b',
        ),
        coverage: const EarthquakeOverlayCoverage.complete(
          requestedTileCount: 4,
        ),
      ),
    );

    expect(presentation.message, '表示範囲の震度情報は未確定です');
  });

  test('current overlayのloading coverageを準備中として扱う', () {
    final data = _available('A');
    final overlay = data.overlay as EarthquakeMapOverlaySnapshot;
    final presentation = EqmonitorMapOverlayPresentation.from(
      overlayState: AsyncData(data),
      committedCamera: null,
      coverageSnapshot: EarthquakeOverlayCoverageSnapshot(
        versionStamp: overlay.versionStamp,
        coverage: const EarthquakeOverlayCoverage.loading(),
      ),
    );

    expect(presentation.message, '表示範囲の震度情報を準備中です');
  });

  test('versionと入力数を描画済みdiagnosticから分離して公開する', () {
    final stamp = _versionStamp(
      sourceIdentity: 'A',
      dataSequence: 7,
      renderGeneration: 9,
    );
    final atlas = _atlas();
    final overlay = _snapshot(
      stamp,
      regionStyles: const [
        EarthquakeAreaStyle(code: '01', color: Color(0xFF112233), opacity: 1),
      ],
      cityStyles: const [
        EarthquakeAreaStyle(
          code: '01100',
          color: Color(0xFF223344),
          opacity: 1,
        ),
        EarthquakeAreaStyle(
          code: '01200',
          color: Color(0xFF334455),
          opacity: 1,
        ),
      ],
      stations: const [
        EarthquakeObservationPoint(
          id: 'station-a',
          longitude: 141,
          latitude: 43,
          color: Color(0xFF445566),
          radiusLogicalPixels: 4,
        ),
      ],
      spriteAtlas: atlas,
      sprites: [_hypocenter()],
    );
    final diagnostic = EarthquakeOverlayCoverageDiagnostic(
      visibleCanonicalTileCount: 5,
      pendingTileCount: 0,
      authoritativeEmptyTileCount: 1,
      sourceLayerAbsentTileCount: 1,
      missingOrInvalidPropertyFeatureCount: 2,
      decodeOrSchemaFailureTileCount: 1,
      requiredCodeUnresolvedCount: 3,
      stationCount: 1,
      spriteCount: 1,
    );
    final presentation = EqmonitorMapOverlayPresentation.from(
      overlayState: AsyncData(
        LatestEarthquakeOverlayData(
          eventId: 'A',
          originTime: DateTime.utc(2026, 8, 23),
          telegramStatus: TelegramStatus.normal,
          availability: LatestEarthquakeOverlayAvailability.available,
          overlay: overlay,
        ),
      ),
      coverageSnapshot: EarthquakeOverlayCoverageSnapshot(
        versionStamp: stamp,
        coverage: const EarthquakeOverlayCoverage.incomplete(
          requestedTileCount: 5,
          readyTileCount: 3,
          missingOrInvalidCodeCount: 5,
        ),
        diagnostic: diagnostic,
      ),
      committedCamera: const MapCamera(
        centerLongitude: 137.5,
        centerLatitude: 36.5,
        zoom: 6.75,
      ),
    );

    expect(presentation.dataSequence, 7);
    expect(presentation.renderGeneration, 9);
    expect(
      presentation.inputCounts,
      const (regions: 1, cities: 2, stations: 1, sprites: 1),
    );
    expect(presentation.coverageState, EqmonitorMapCoverageState.incomplete);
    expect(presentation.coverageDiagnostic, same(diagnostic));
    expect(presentation.currentZoom, 6.75);
    expect(
      presentation.hypocenter,
      const (longitude: 140.1, latitude: 36.2),
    );
    expect(presentation.canMoveToHypocenter, isTrue);
  });

  test('stale coverageは未確定としてdiagnosticを公開しない', () {
    final presentation = EqmonitorMapOverlayPresentation.from(
      overlayState: AsyncData(_available('A')),
      coverageSnapshot: EarthquakeOverlayCoverageSnapshot(
        versionStamp: _versionStamp(sourceIdentity: 'stale'),
        coverage: const EarthquakeOverlayCoverage.complete(
          requestedTileCount: 1,
        ),
        diagnostic: EarthquakeOverlayCoverageDiagnostic(
          visibleCanonicalTileCount: 1,
          pendingTileCount: 0,
          authoritativeEmptyTileCount: 1,
          sourceLayerAbsentTileCount: 0,
          missingOrInvalidPropertyFeatureCount: 0,
          decodeOrSchemaFailureTileCount: 0,
          requiredCodeUnresolvedCount: 0,
          stationCount: 99,
          spriteCount: 99,
        ),
      ),
      committedCamera: const MapCamera(
        centerLongitude: 0,
        centerLatitude: 0,
        zoom: 4,
      ),
    );

    expect(presentation.coverageState, EqmonitorMapCoverageState.unconfirmed);
    expect(presentation.coverageDiagnostic, isNull);
    expect(presentation.message, '表示範囲の震度情報は未確定です');
  });
}
