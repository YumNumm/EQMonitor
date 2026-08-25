import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

const eqmonitorMapMoveToHypocenterKey = ValueKey(
  'eqmonitor-map-move-to-hypocenter',
);

typedef EqmonitorMapOverlayInputCounts = ({
  int regions,
  int cities,
  int stations,
  int sprites,
});

typedef EqmonitorMapHypocenter = ({double longitude, double latitude});

enum EqmonitorMapCoverageState {
  unconfirmed,
  hidden,
  loading,
  incomplete,
  complete,
}

final class EqmonitorMapOverlayPresentation {
  const new({
    required this.eventIdLabel,
    required this.originTimeLabel,
    required this.statusLabel,
    required this.message,
    required this.overlay,
    required this.isError,
    required this.dataSequence,
    required this.renderGeneration,
    required this.inputCounts,
    required this.coverageState,
    required this.coverageDiagnostic,
    required this.currentZoom,
    required this.hypocenter,
    required this.canMoveToHypocenter,
  });

  factory from({
    required AsyncValue<LatestEarthquakeOverlayData> overlayState,
    required EarthquakeOverlayCoverageSnapshot? coverageSnapshot,
    required MapCamera? committedCamera,
  }) => const EqmonitorMapOverlayPresentationBuilder().build(
    overlayState: overlayState,
    coverageSnapshot: coverageSnapshot,
    committedCamera: committedCamera,
  );

  final String eventIdLabel;
  final String originTimeLabel;
  final String statusLabel;
  final String message;
  final EarthquakeMapOverlaySnapshot? overlay;
  final bool isError;
  final int? dataSequence;
  final int? renderGeneration;
  final EqmonitorMapOverlayInputCounts? inputCounts;
  final EqmonitorMapCoverageState coverageState;
  final EarthquakeOverlayCoverageDiagnostic? coverageDiagnostic;
  final double? currentZoom;
  final EqmonitorMapHypocenter? hypocenter;
  final bool canMoveToHypocenter;
}

final class EqmonitorMapOverlayPresentationBuilder {
  const new();

  EqmonitorMapOverlayPresentation build({
    required AsyncValue<LatestEarthquakeOverlayData> overlayState,
    required EarthquakeOverlayCoverageSnapshot? coverageSnapshot,
    required MapCamera? committedCamera,
  }) {
    if (overlayState.isLoading) {
      return EqmonitorMapOverlayPresentation(
        eventIdLabel: '取得中',
        originTimeLabel: '取得中',
        statusLabel: '取得中',
        message: '最新の地震情報を取得中です',
        overlay: null,
        isError: false,
        dataSequence: null,
        renderGeneration: null,
        inputCounts: null,
        coverageState: .unconfirmed,
        coverageDiagnostic: null,
        currentZoom: committedCamera?.zoom,
        hypocenter: null,
        canMoveToHypocenter: false,
      );
    }
    if (overlayState.hasError) {
      return EqmonitorMapOverlayPresentation(
        eventIdLabel: '取得失敗',
        originTimeLabel: '取得失敗',
        statusLabel: '取得失敗',
        message: '最新の地震情報を取得できませんでした',
        overlay: null,
        isError: true,
        dataSequence: null,
        renderGeneration: null,
        inputCounts: null,
        coverageState: .unconfirmed,
        coverageDiagnostic: null,
        currentZoom: committedCamera?.zoom,
        hypocenter: null,
        canMoveToHypocenter: false,
      );
    }
    return switch (overlayState) {
      AsyncData(:final value) => buildData(
        data: value,
        coverageSnapshot: coverageSnapshot,
        committedCamera: committedCamera,
      ),
      _ => EqmonitorMapOverlayPresentation(
        eventIdLabel: '取得中',
        originTimeLabel: '取得中',
        statusLabel: '取得中',
        message: '最新の地震情報を取得中です',
        overlay: null,
        isError: false,
        dataSequence: null,
        renderGeneration: null,
        inputCounts: null,
        coverageState: .unconfirmed,
        coverageDiagnostic: null,
        currentZoom: committedCamera?.zoom,
        hypocenter: null,
        canMoveToHypocenter: false,
      ),
    };
  }

  EqmonitorMapOverlayPresentation buildData({
    required LatestEarthquakeOverlayData data,
    required EarthquakeOverlayCoverageSnapshot? coverageSnapshot,
    required MapCamera? committedCamera,
  }) {
    final originTime = data.originTime;
    final overlay = data.overlay;
    final matchingCoverage =
        overlay != null &&
            coverageSnapshot?.versionStamp == overlay.versionStamp
        ? coverageSnapshot
        : null;
    final coverageState = switch (matchingCoverage?.coverage) {
      EarthquakeOverlayHidden() => EqmonitorMapCoverageState.hidden,
      EarthquakeOverlayLoading() => EqmonitorMapCoverageState.loading,
      EarthquakeOverlayIncomplete() => EqmonitorMapCoverageState.incomplete,
      EarthquakeOverlayComplete() => EqmonitorMapCoverageState.complete,
      null => EqmonitorMapCoverageState.unconfirmed,
    };
    MapPointSpriteFeature? hypocenterSprite;
    final eventId = data.eventId;
    if (eventId != null && overlay != null) {
      final expectedId = 'hypocenter:$eventId';
      for (final sprite in overlay.sprites) {
        if (sprite.id == expectedId) {
          hypocenterSprite = sprite;
          break;
        }
      }
    }
    final hypocenter = switch (hypocenterSprite) {
      final sprite? => (
        longitude: sprite.longitude,
        latitude: sprite.latitude,
      ),
      null => null,
    };
    return EqmonitorMapOverlayPresentation(
      eventIdLabel: data.eventId ?? '対象なし',
      originTimeLabel: originTime == null
          ? '不明'
          : DateFormat('yyyy/MM/dd HH:mm:ss').format(originTime.toLocal()),
      statusLabel: statusLabel(data.telegramStatus),
      message: message(
        availability: data.availability,
        coverageState: coverageState,
      ),
      overlay: overlay,
      isError: false,
      dataSequence: overlay?.versionStamp.dataSequence,
      renderGeneration: overlay?.versionStamp.renderGeneration,
      inputCounts: overlay == null
          ? null
          : (
              regions: overlay.regionStyles.length,
              cities: overlay.cityStyles.length,
              stations: overlay.stations.length,
              sprites: overlay.sprites.length,
            ),
      coverageState: coverageState,
      coverageDiagnostic: matchingCoverage?.diagnostic,
      currentZoom: committedCamera?.zoom,
      hypocenter: hypocenter,
      canMoveToHypocenter: committedCamera != null && hypocenter != null,
    );
  }

  String statusLabel(TelegramStatus? status) => switch (status) {
    TelegramStatus.normal => '通常',
    TelegramStatus.training => '訓練',
    TelegramStatus.test => '試験',
    null => '不明',
  };

  String message({
    required LatestEarthquakeOverlayAvailability availability,
    required EqmonitorMapCoverageState coverageState,
  }) => switch (availability) {
    LatestEarthquakeOverlayAvailability.available => switch (coverageState) {
      EqmonitorMapCoverageState.unconfirmed => '表示範囲の震度情報は未確定です',
      EqmonitorMapCoverageState.hidden => '表示範囲の震度情報は非表示です',
      EqmonitorMapCoverageState.loading => '表示範囲の震度情報を準備中です',
      EqmonitorMapCoverageState.incomplete => '表示範囲の震度情報は不完全です',
      EqmonitorMapCoverageState.complete => '表示範囲の震度情報を表示中です',
    },
    LatestEarthquakeOverlayAvailability.noEarthquake => '震度1以上の地震はありません',
    LatestEarthquakeOverlayAvailability.noIntensity => '震度データがありません',
    LatestEarthquakeOverlayAvailability.missingTelegramMetadata =>
      '電文の更新時刻を確認できないため表示できません',
    LatestEarthquakeOverlayAvailability.superseded => '地震情報を切り替え中です',
  };
}

class EqmonitorMapOverlayBanner extends StatelessWidget {
  const new({
    required this.presentation,
    required this.onMoveToHypocenter,
    super.key,
  });

  final EqmonitorMapOverlayPresentation presentation;
  final VoidCallback? onMoveToHypocenter;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.bodySmall;
    final coverageLabel = switch (presentation.coverageState) {
      EqmonitorMapCoverageState.unconfirmed => '未確定',
      EqmonitorMapCoverageState.hidden => '非表示',
      EqmonitorMapCoverageState.loading => '準備中',
      EqmonitorMapCoverageState.incomplete => '不完全',
      EqmonitorMapCoverageState.complete => '完了',
    };
    final inputCounts = presentation.inputCounts;
    final diagnostic = presentation.coverageDiagnostic;
    final labels = [
      'イベント: ${presentation.eventIdLabel}',
      '発生時刻: ${presentation.originTimeLabel}',
      '電文状態: ${presentation.statusLabel}',
      'Data sequence: ${presentation.dataSequence ?? '未確定'}',
      'Render generation: ${presentation.renderGeneration ?? '未確定'}',
      '現在 zoom: ${presentation.currentZoom?.toStringAsFixed(2) ?? '未取得'}',
      if (inputCounts != null)
        '入力数 Region ${inputCounts.regions} / City ${inputCounts.cities} / '
            'Station ${inputCounts.stations} / Sprite ${inputCounts.sprites}',
      'Coverage: $coverageLabel',
      if (diagnostic != null) ...[
        '描画診断 Tile 可視 ${diagnostic.visibleCanonicalTileCount} / '
            '準備中 ${diagnostic.pendingTileCount} / '
            '空 ${diagnostic.authoritativeEmptyTileCount}',
        '描画診断 Layer欠損 ${diagnostic.sourceLayerAbsentTileCount} / '
            'Property不正 ${diagnostic.missingOrInvalidPropertyFeatureCount} / '
            'Decode ${diagnostic.decodeOrSchemaFailureTileCount} / '
            'Code未解決 ${diagnostic.requiredCodeUnresolvedCount}',
        '描画済み Station ${diagnostic.stationCount} / '
            'Sprite ${diagnostic.spriteCount}',
      ],
    ];
    return Material(
      elevation: 2,
      color: colorScheme.surface.withValues(alpha: 0.92),
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: ListView(
        primary: false,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 4,
            children: [
              for (final label in labels) Text(label, style: textStyle),
            ],
          ),
          Text(
            presentation.message,
            style: textStyle?.copyWith(
              color: presentation.isError ? colorScheme.error : null,
              fontWeight: FontWeight.w600,
            ),
          ),
          OutlinedButton.icon(
            key: eqmonitorMapMoveToHypocenterKey,
            onPressed: presentation.canMoveToHypocenter
                ? onMoveToHypocenter
                : null,
            icon: const Icon(Icons.my_location),
            label: const Text('震源へ移動'),
          ),
        ],
      ),
    );
  }
}
