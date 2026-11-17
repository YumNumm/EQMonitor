import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_debug_report.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shake_eew_correlator/shake_eew_correlator.dart';

part 'home_debug_hud_formatter.g.dart';

@riverpod
HomeDebugHudFormatter homeDebugHudFormatter(Ref ref) =>
    const HomeDebugHudFormatter();

/// 地図に重ねるデバッグ表示の各行を組み立てる。
class const HomeDebugHudFormatter() {
  List<String> shakeDetection({
    required ShakeDetectionDebugReport report,
    required DateTime now,
  }) {
    if (!report.isEnabled) {
      return const ['揺れ検知  無効'];
    }
    final observedAt = report.observedAt;
    if (observedAt == null) {
      return const ['揺れ検知  有効', '検知なし（地上の震度画像を待機中）'];
    }
    final coldStartAt = report.coldStartAt;
    final baselineFrameCount = report.baselineFrameCount;
    return [
      '揺れ検知  有効',
      'フレーム ${time(observedAt)}  遅れ ${seconds(now.difference(observedAt))}',
      if (coldStartAt != null)
        '開始 ${time(coldStartAt)}  '
            '(${seconds(observedAt.difference(coldStartAt))} 経過)',
      if (baselineFrameCount != null)
        '平常値 ${baselineFrameCount > 0 ? '過去 $baselineFrameCount 枚' : '固定値'}  '
            '履歴の作り直し ${report.isHistoryRebuilt ? '済' : '未'}',
      report.isCorrelatorReady
          ? 'EEW 結合の対象 ${report.eewCount} 件'
          : 'EEW 結合 不可（走時表が未読込）',
      if (report.events.isEmpty) 'イベントなし',
      for (final event in report.events) ...eventLines(event: event, now: now),
    ];
  }

  List<String> eventLines({
    required ShakeDetectionDebugEvent event,
    required DateTime now,
  }) {
    final snapshot = event.snapshot;
    final id = snapshot.id.length > 6
        ? snapshot.id.substring(0, 6)
        : snapshot.id;
    final correlated = event.correlatedEewEventId;
    return [
      '■ $id ${snapshot.level.name} ${snapshot.points.length}点 '
          '${snapshot.isConfirmed ? '確定' : '未確定'}'
          '${snapshot.isBootstrap ? ' 平常値差' : ''}',
      '  検知 ${time(snapshot.createdAt)}  更新 ${time(snapshot.updatedAt)}',
      '  期限 ${time(snapshot.expiresAt)}  '
          '(残り ${seconds(snapshot.expiresAt.difference(now))})',
      for (final candidate in event.candidates)
        for (final line in candidateLines(candidate)) '  $line',
      correlated == null ? '  → 結合なし（表示）' : '  → EEW $correlated と結合（カード非表示）',
    ];
  }

  List<String> candidateLines(CorrelationCandidate candidate) {
    final averageTimeDiff = candidate.averageTimeDiff;
    return [
      'EEW ${candidate.eewEventId} 第${candidate.eewSerialNo}報  '
          '${candidate.isCorrelated ? '成立' : '不成立'}',
      '  一致 ${candidate.matchedPointCount}/${candidate.eligiblePointCount} 点'
          ' (全 ${candidate.totalPointCount} 点)'
          '  率 ${candidate.score.toStringAsFixed(2)}',
      '  S波到達から '
          '${averageTimeDiff == null ? '-' : '${averageTimeDiff.toStringAsFixed(1)}s'}'
          '  震度差 ${candidate.averageIntensityDiff.toStringAsFixed(2)}',
    ];
  }

  List<String> kyoshinMonitor({
    required KyoshinMonitorState? state,
    required DateTime now,
  }) {
    if (state == null) {
      return const ['強震モニタ  未取得'];
    }
    final targetTime = state.lastImageFetchTargetTime;
    final fetchDuration = state.lastImageFetchDuration;
    return [
      '強震モニタ  ${state.status.name}',
      if (targetTime != null)
        '画像 ${time(targetTime)}  遅れ ${seconds(now.difference(targetTime))}',
      '種別 ${state.currentRealtimeDataType?.displayName ?? '-'}'
          ' / ${state.currentRealtimeLayer?.displayName ?? '-'}'
          '  観測点 ${state.analyzedPointsCount ?? '-'}',
      if (fetchDuration != null) '取得と解析 ${fetchDuration.inMilliseconds}ms',
    ];
  }

  List<String> eew({
    required List<EewTelegramItem> eews,
    required DateTime now,
  }) => [
    'EEW  表示中 ${eews.length} 件',
    for (final eew in eews) ...[
      '■ ${eew.eventId} 第${eew.serialNo}報'
          '${eew.isLastInfo ? ' 最終' : ''}'
          '${eew.isCanceled ? ' 取消' : ''}'
          '${(eew.isWarning ?? false) ? ' 警報' : ''}'
          '${eew.isPlum ? ' PLUM' : ''}',
      '  M${eew.hypocenter?.magnitude ?? '-'}'
          ' 深さ${eew.hypocenter?.depth ?? '-'}km'
          '  発表 ${time(eew.reportTime)}',
      if (eew.originTime case final originTime?)
        '  発生 ${time(originTime)}  (${seconds(now.difference(originTime))} 経過)',
    ],
  ];

  String time(DateTime value) =>
      value.formatWithTz(DateTimeFormat.hourMinuteSecond);

  String seconds(Duration value) =>
      '${(value.inMilliseconds / 1000).toStringAsFixed(1)}s';
}
