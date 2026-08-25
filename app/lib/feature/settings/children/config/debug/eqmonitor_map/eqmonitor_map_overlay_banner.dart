import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final class EqmonitorMapOverlayPresentation {
  const new({
    required this.eventIdLabel,
    required this.originTimeLabel,
    required this.statusLabel,
    required this.message,
    required this.overlay,
    required this.isError,
  });

  factory from({
    required AsyncValue<LatestEarthquakeOverlayData> overlayState,
    required EarthquakeOverlayCoverageSnapshot? coverageSnapshot,
  }) => const EqmonitorMapOverlayPresentationBuilder().build(
    overlayState: overlayState,
    coverageSnapshot: coverageSnapshot,
  );

  final String eventIdLabel;
  final String originTimeLabel;
  final String statusLabel;
  final String message;
  final EarthquakeMapOverlaySnapshot? overlay;
  final bool isError;
}

final class EqmonitorMapOverlayPresentationBuilder {
  const new();

  EqmonitorMapOverlayPresentation build({
    required AsyncValue<LatestEarthquakeOverlayData> overlayState,
    required EarthquakeOverlayCoverageSnapshot? coverageSnapshot,
  }) {
    if (overlayState.isLoading) {
      return const EqmonitorMapOverlayPresentation(
        eventIdLabel: '取得中',
        originTimeLabel: '取得中',
        statusLabel: '取得中',
        message: '最新の地震情報を取得中です',
        overlay: null,
        isError: false,
      );
    }
    if (overlayState.hasError) {
      return const EqmonitorMapOverlayPresentation(
        eventIdLabel: '取得失敗',
        originTimeLabel: '取得失敗',
        statusLabel: '取得失敗',
        message: '最新の地震情報を取得できませんでした',
        overlay: null,
        isError: true,
      );
    }
    return switch (overlayState) {
      AsyncData(:final value) => buildData(
        data: value,
        coverageSnapshot: coverageSnapshot,
      ),
      _ => const EqmonitorMapOverlayPresentation(
        eventIdLabel: '取得中',
        originTimeLabel: '取得中',
        statusLabel: '取得中',
        message: '最新の地震情報を取得中です',
        overlay: null,
        isError: false,
      ),
    };
  }

  EqmonitorMapOverlayPresentation buildData({
    required LatestEarthquakeOverlayData data,
    required EarthquakeOverlayCoverageSnapshot? coverageSnapshot,
  }) {
    final originTime = data.originTime;
    final overlay = data.overlay;
    final coverage =
        overlay == null ||
            coverageSnapshot == null ||
            coverageSnapshot.versionStamp != overlay.versionStamp
        ? const EarthquakeOverlayCoverage.hidden()
        : coverageSnapshot.coverage;
    return EqmonitorMapOverlayPresentation(
      eventIdLabel: data.eventId ?? '対象なし',
      originTimeLabel: originTime == null
          ? '不明'
          : DateFormat('yyyy/MM/dd HH:mm:ss').format(originTime.toLocal()),
      statusLabel: statusLabel(data.telegramStatus),
      message: message(
        availability: data.availability,
        coverage: coverage,
      ),
      overlay: overlay,
      isError: false,
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
    required EarthquakeOverlayCoverage coverage,
  }) => switch (availability) {
    LatestEarthquakeOverlayAvailability.available => switch (coverage) {
      EarthquakeOverlayIncomplete() => '表示範囲の震度情報は不完全です',
      EarthquakeOverlayComplete() => '表示範囲の震度情報を表示中です',
      EarthquakeOverlayHidden() ||
      EarthquakeOverlayLoading() => '表示範囲の震度情報を準備中です',
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
    super.key,
  });

  final EqmonitorMapOverlayPresentation presentation;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.bodySmall;
    return Material(
      elevation: 2,
      color: colorScheme.surface.withValues(alpha: 0.92),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'イベント: ${presentation.eventIdLabel}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textStyle,
            ),
            Text(
              '発生時刻: ${presentation.originTimeLabel}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textStyle,
            ),
            Text(
              '電文状態: ${presentation.statusLabel}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textStyle,
            ),
            Text(
              presentation.message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyle?.copyWith(
                color: presentation.isError ? colorScheme.error : null,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
