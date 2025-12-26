import 'dart:convert';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:intl/intl.dart';

class EewFormatter {
  static final _dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss');
  static final _timeFormat = DateFormat('HH:mm:ss');

  /// Durationを読みやすい形式にフォーマット
  static String _formatDuration(Duration duration) {
    final isNegative = duration.isNegative;
    final abs = duration.abs();
    final minutes = abs.inMinutes;
    final seconds = abs.inSeconds % 60;

    final sign = isNegative ? '-' : '+';
    if (minutes > 0) {
      return '$sign$minutes分$seconds秒';
    }
    return '$sign$seconds秒';
  }

  static String formatList(EewListResponse response) {
    final buffer = StringBuffer();
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('緊急地震速報一覧 (${response.items.length}件)');
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

    for (final item in response.items) {
      buffer.writeln(_formatItemSummary(item));
      buffer.writeln('──────────────────────────────────────────────────');
    }

    return buffer.toString();
  }

  static String formatLatest(EewLatestResponse response) {
    final buffer = StringBuffer();
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('最新の緊急地震速報 (${response.items.length}件)');
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

    if (response.items.isEmpty) {
      buffer.writeln('現在、発表から5分以内の緊急地震速報はありません。');
    } else {
      for (final item in response.items) {
        buffer.writeln(_formatItemDetail(item));
        buffer.writeln('──────────────────────────────────────────────────');
      }
    }

    return buffer.toString();
  }

  static String formatArray(EewArrayResponse response) {
    final buffer = StringBuffer();
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('緊急地震速報詳細 (${response.items.length}件)');
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

    for (final item in response.items) {
      buffer.writeln(_formatItemDetail(item));
      buffer.writeln('──────────────────────────────────────────────────');
    }

    return buffer.toString();
  }

  static String formatItem(EewItemWithRelations item) {
    final buffer = StringBuffer();
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('緊急地震速報詳細');
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln(_formatItemDetail(item));
    return buffer.toString();
  }

  static String _formatItemSummary(EewItemWithRelations eew) {
    final buffer = StringBuffer();

    // イベントID・シリアル番号
    buffer.writeln('イベントID: ${eew.eventId} (第${eew.serialNo}報)');

    // 発報時刻
    buffer.writeln('発報時刻: ${_dateFormat.format(eew.reportTime.toLocal())}');

    // 状態
    final statusStr = _getStatusString(eew);
    buffer.writeln('状態: $statusStr');

    // 震源
    if (eew.hypocenter != null) {
      final hypo = eew.hypocenter!;
      buffer.writeln('震源地: ${hypo.value.name}');
      if (hypo.magnitude != null) {
        buffer.writeln('規模: M${hypo.magnitude}');
      }
      if (hypo.depth != null) {
        final depthStr = hypo.depth == 0
            ? 'ごく浅い'
            : hypo.depth == 700
            ? '700km以上'
            : '${hypo.depth}km';
        buffer.writeln('深さ: $depthStr');
      }
    }

    // 予想最大震度
    if (eew.forecastIntensity?.maxIntensity != null) {
      final max = eew.forecastIntensity!.maxIntensity!;
      final intensityStr = max.isOver
          ? '${max.value.value}以上'
          : max.value.value;
      buffer.writeln('予想最大震度: $intensityStr');
    }

    return buffer.toString();
  }

  static String _formatItemDetail(EewItemWithRelations eew) {
    final buffer = StringBuffer();

    // 基本情報
    buffer.writeln('イベントID: ${eew.eventId}');
    buffer.writeln('シリアル番号: 第${eew.serialNo}報');
    buffer.writeln('電文種別: ${eew.type.value}');
    buffer.writeln('発報時刻: ${_dateFormat.format(eew.reportTime.toLocal())}');

    // 状態
    final statusStr = _getStatusString(eew);
    buffer.writeln('状態: $statusStr');

    if (eew.headline != null) {
      buffer.writeln('ヘッドライン: ${eew.headline}');
    }

    // フラグ
    buffer.writeln('\n【フラグ情報】');
    buffer.writeln('  警報: ${eew.isWarning == true ? "あり" : "なし"}');
    buffer.writeln('  最終報: ${eew.isLastInfo ? "はい" : "いいえ"}');
    buffer.writeln('  取消: ${eew.isCanceled ? "はい" : "いいえ"}');
    buffer.writeln('  PLUM法: ${eew.isPlum ? "はい" : "いいえ"}');

    // 地震発生時刻
    if (eew.originTime != null) {
      buffer.writeln(
        '\n発生時刻: ${_dateFormat.format(eew.originTime!.toLocal())}',
      );
    }

    // 震源
    if (eew.hypocenter != null) {
      final hypo = eew.hypocenter!;
      buffer.writeln('\n【震源情報】');
      buffer.writeln('  震源地: ${hypo.value.name} (コード: ${hypo.value.code})');
      if (hypo.detailed != null) {
        buffer.writeln(
          '  詳細地名: ${hypo.detailed!.name} (コード: ${hypo.detailed!.code})',
        );
      }

      // 座標
      hypo.coordinates.when(
        latLng: (lat, lng) {
          buffer.writeln('  緯度: $lat°');
          buffer.writeln('  経度: $lng°');
        },
        unknown: (condition) {
          buffer.writeln('  座標: $condition');
        },
      );

      if (hypo.magnitude != null) {
        buffer.writeln('  規模: M${hypo.magnitude}');
      } else {
        buffer.writeln('  規模: 不明');
      }

      if (hypo.depth != null) {
        final depthStr = hypo.depth == 0
            ? 'ごく浅い'
            : hypo.depth == 700
            ? '700km以上'
            : '${hypo.depth}km';
        buffer.writeln('  深さ: $depthStr');
      } else {
        buffer.writeln('  深さ: 不明');
      }
    }

    // 予想震度
    if (eew.forecastIntensity != null) {
      final intensity = eew.forecastIntensity!;
      buffer.writeln('\n【予想震度】');

      if (intensity.maxIntensity != null) {
        final max = intensity.maxIntensity!;
        final intensityStr = max.isOver
            ? '${max.value.value}以上'
            : max.value.value;
        buffer.writeln('  予想最大震度: $intensityStr');
      }

      if (intensity.maxLpgmIntensity != null) {
        final max = intensity.maxLpgmIntensity!;
        final lpgmStr = max.isOver ? '${max.value.value}以上' : max.value.value;
        buffer.writeln('  予想最大長周期地震動階級: $lpgmStr');
      }
    }

    // 地域別予想震度・到達予想時刻
    final regions = eew.forecastIntensity?.regions ?? [];
    if (regions.isNotEmpty) {
      buffer.writeln('\n【地域別予想震度・到達予想時刻】');
      final reportTime = eew.reportTime;

      for (final region in regions) {
        final regionIntensity = region.intensity.isOver
            ? '${region.intensity.value.value}以上'
            : region.intensity.value.value;

        // PLUM法かどうかで表示を変える
        final isPlum = region.isPlum;
        final timeLabel = isPlum ? 'PLUM検知' : '到達';

        // 時刻の表示
        final timeStr = region.arrivalTime.when(
          time: (value) {
            final timeLocal = value.toLocal();
            final diff = timeLocal.difference(reportTime.toLocal());
            final diffStr = _formatDuration(diff);
            return '${_timeFormat.format(timeLocal)} ($diffStr)';
          },
          arrived: () => isPlum ? '-' : '既に到達',
        );

        // フラグ
        final flags = <String>[];
        if (region.isWarning) flags.add('⚠️警報');
        if (isPlum) flags.add('PLUM');
        final flagStr = flags.isNotEmpty ? ' [${flags.join(', ')}]' : '';

        // 長周期
        final lpgmStr = region.lpgmIntensity != null
            ? ' (LPGM: ${region.lpgmIntensity!.isOver ? "${region.lpgmIntensity!.value.value}以上" : region.lpgmIntensity!.value.value})'
            : '';

        buffer.writeln('  ${region.value.name}');
        buffer.writeln('    震度: $regionIntensity$lpgmStr$flagStr');
        buffer.writeln('    $timeLabel: $timeStr');
      }
    }

    // 警報地域
    if (eew.warning != null) {
      final warning = eew.warning!;
      buffer.writeln('\n【警報対象地域】');

      if (warning.prefectures.isNotEmpty) {
        buffer.writeln('  [都道府県]');
        for (final pref in warning.prefectures) {
          final newMark = pref.hadWarning ? '' : ' (新規)';
          buffer.writeln('    ${pref.value.name}$newMark');
        }
      }

      if (warning.regions.isNotEmpty) {
        buffer.writeln('  [地域]');
        for (final region in warning.regions) {
          final newMark = region.hadWarning ? '' : ' (新規)';
          buffer.writeln('    ${region.value.name}$newMark');
        }
      }
    }

    // 精度情報
    if (eew.accuracy != null) {
      final acc = eew.accuracy!;
      buffer.writeln('\n【精度情報】');
      buffer.writeln('  震央精度: ${acc.epicenters}');
      buffer.writeln('  深さ精度: ${acc.depth}');
      buffer.writeln('  M計算精度: ${acc.magnitudeCalculation}');
      buffer.writeln('  M計算使用観測点数: ${acc.numberOfMagnitudeCalculation}');
    }

    return buffer.toString();
  }

  static String _getStatusString(EewItemWithRelations eew) {
    if (eew.isCanceled) {
      return '取消';
    }
    if (eew.isWarning == true) {
      return '警報';
    }
    return '予報';
  }

  static String toJsonList(EewListResponse response) {
    final encoder = JsonEncoder.withIndent('  ');
    return encoder.convert({
      'items': response.items.map((e) => _eewToMap(e)).toList(),
      'nextToken': response.nextToken,
      'nextPooling': response.nextPooling,
    });
  }

  static String toJsonLatest(EewLatestResponse response) {
    final encoder = JsonEncoder.withIndent('  ');
    return encoder.convert({
      'items': response.items.map((e) => _eewToMap(e)).toList(),
    });
  }

  static String toJsonArray(EewArrayResponse response) {
    final encoder = JsonEncoder.withIndent('  ');
    return encoder.convert({
      'items': response.items.map((e) => _eewToMap(e)).toList(),
    });
  }

  static String toJsonItem(EewItemWithRelations item) {
    final encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(_eewToMap(item));
  }

  static Map<String, dynamic> _eewToMap(EewItemWithRelations eew) {
    return {
      'eventId': eew.eventId,
      'serialNo': eew.serialNo,
      'type': eew.type.value,
      'status': eew.status.value,
      'infoType': eew.infoType.value,
      'reportTime': eew.reportTime.toIso8601String(),
      'originTime': eew.originTime?.toIso8601String(),
      'isCanceled': eew.isCanceled,
      'isWarning': eew.isWarning,
      'isLastInfo': eew.isLastInfo,
      'isPlum': eew.isPlum,
      'hypocenter': eew.hypocenter != null
          ? {
              'name': eew.hypocenter!.value.name,
              'code': eew.hypocenter!.value.code,
              'magnitude': eew.hypocenter!.magnitude,
              'depth': eew.hypocenter!.depth,
            }
          : null,
      'maxIntensity': eew.forecastIntensity?.maxIntensity?.value.value,
      'intensityRegionsCount': eew.intensityRegions.length,
    };
  }
}
