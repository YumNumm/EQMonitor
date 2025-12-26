import 'dart:convert';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:intl/intl.dart';

class EarthquakeFormatter {
  static final _dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss');

  static String formatList(EarthquakeListResponse response) {
    final buffer = StringBuffer();
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('地震情報一覧 (${response.items.length}件)');
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

    for (final item in response.items) {
      buffer.writeln(_formatPartial(item));
      buffer.writeln('──────────────────────────────────────────────────');
    }

    return buffer.toString();
  }

  static String _formatPartial(EarthquakePartial eq) {
    final buffer = StringBuffer();

    // イベントID
    buffer.writeln('イベントID: ${eq.eventId}');

    // 発生時刻
    if (eq.originTime != null) {
      buffer.writeln('発生時刻: ${_dateFormat.format(eq.originTime!.toLocal())}');
    }

    // 震源
    if (eq.hypocenter != null) {
      final hypo = eq.hypocenter!;
      buffer.writeln('震源地: ${hypo.value.name}');

      // マグニチュード
      final magStr = hypo.magnitude.when(
        normal: (value) => 'M$value',
        unknown: () => 'M不明',
        overM8: () => 'M8超',
      );
      buffer.writeln('規模: $magStr');

      // 深さ
      final depthStr = hypo.depth.when(
        shallow: () => 'ごく浅い',
        normal: (value) => '${value}km',
        over700: () => '700km以上',
        unknown: () => '不明',
      );
      buffer.writeln('深さ: $depthStr');
    }

    // 最大震度
    if (eq.intensity != null) {
      buffer.writeln('最大震度: ${eq.intensity!.maxIntensity.value}');
    }

    return buffer.toString();
  }

  static String formatDetail(EarthquakeDetailResponse response) {
    final eq = response.earthquake;
    final buffer = StringBuffer();

    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('地震情報詳細');
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

    // イベントID
    buffer.writeln('イベントID: ${eq.eventId}');

    // 発生時刻
    if (eq.originTime != null) {
      buffer.writeln('発生時刻: ${_dateFormat.format(eq.originTime!.toLocal())}');
    }

    // 震源
    if (eq.hypocenter != null) {
      final hypo = eq.hypocenter!;
      buffer.writeln('\n【震源情報】');
      buffer.writeln('  震源地: ${hypo.value.name} (コード: ${hypo.value.code})');
      if (hypo.detailed != null) {
        buffer.writeln('  詳細地名: ${hypo.detailed!.name} (コード: ${hypo.detailed!.code})');
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

      // マグニチュード
      final magStr = hypo.magnitude.when(
        normal: (value) => 'M$value',
        unknown: () => 'M不明',
        overM8: () => 'M8を超える巨大地震',
      );
      final magType = hypo.magnitude.when(
        normal: (_) => 'NORMAL',
        unknown: () => 'UNKNOWN',
        overM8: () => 'OVER_M8',
      );
      buffer.writeln('  規模: $magStr (type: $magType)');

      // 深さ
      final depthStr = hypo.depth.when(
        shallow: () => 'ごく浅い',
        normal: (value) => '${value}km',
        over700: () => '700km以上',
        unknown: () => '不明',
      );
      final depthType = hypo.depth.when(
        shallow: () => 'SHALLOW',
        normal: (_) => 'NORMAL',
        over700: () => 'OVER_700',
        unknown: () => 'UNKNOWN',
      );
      buffer.writeln('  深さ: $depthStr (type: $depthType)');
    }

    // 震度情報
    if (eq.intensity != null) {
      final intensity = eq.intensity!;
      buffer.writeln('\n【震度情報】');
      buffer.writeln('  最大震度: ${intensity.maxIntensity.value}');
      if (intensity.maxLpgmIntensity != null) {
        buffer.writeln('  最大長周期地震動階級: ${intensity.maxLpgmIntensity!.value}');
      }

      // 都道府県別
      buffer.writeln('\n  [都道府県別震度]');
      for (final pref in intensity.prefectures) {
        if (pref.maxIntensity != null) {
          buffer.writeln('    ${pref.value.name}: 震度${pref.maxIntensity!.value}');
        }
      }

      // 地域別
      buffer.writeln('\n  [地域別震度]');
      for (final region in intensity.regions) {
        if (region.maxIntensity != null) {
          buffer.writeln('    ${region.value.name}: 震度${region.maxIntensity!.value}');
        }
      }
    }

    // 電文情報
    buffer.writeln('\n【関連電文】');
    for (final ref in eq.telegrams) {
      buffer.writeln(
        '  ${ref.telegram.type.value} - ${ref.telegram.title} '
        '(${_dateFormat.format(ref.telegram.pressAt.toLocal())})',
      );
    }

    // コメント情報
    final hasComments = eq.telegrams.any((ref) => ref.comments != null);
    if (hasComments) {
      buffer.writeln('\n【コメント】');
      for (final ref in eq.telegrams) {
        final comments = ref.comments;
        if (comments == null) continue;

        buffer.writeln('  [${ref.telegram.type.value}]');
        if (comments.text != null && comments.text!.isNotEmpty) {
          buffer.writeln('    本文: ${comments.text}');
        }
        if (comments.free != null && comments.free!.isNotEmpty) {
          buffer.writeln('    自由記述: ${comments.free}');
        }
        if (comments.warning != null && comments.warning!.isNotEmpty) {
          buffer.writeln('    警告: ${comments.warning}');
        }
        if (comments.forecast != null && comments.forecast!.isNotEmpty) {
          buffer.writeln('    予報: ${comments.forecast}');
        }
        if (comments.varComment != null && comments.varComment!.isNotEmpty) {
          buffer.writeln('    その他: ${comments.varComment}');
        }
        if (comments.uri != null && comments.uri!.isNotEmpty) {
          buffer.writeln('    URI: ${comments.uri}');
        }
      }
    }

    return buffer.toString();
  }

  static String toJsonList(EarthquakeListResponse response) {
    final encoder = JsonEncoder.withIndent('  ');
    return encoder.convert({
      'items': response.items.map((e) => _earthquakePartialToMap(e)).toList(),
      'nextToken': response.nextToken,
      'nextPooling': response.nextPooling,
    });
  }

  static String toJsonDetail(EarthquakeDetailResponse response) {
    final encoder = JsonEncoder.withIndent('  ');
    return encoder.convert({
      'earthquake': _earthquakeToMap(response.earthquake),
    });
  }

  static Map<String, dynamic> _earthquakePartialToMap(EarthquakePartial eq) {
    return {
      'eventId': eq.eventId,
      'status': eq.status.value,
      'originTime': eq.originTime?.toIso8601String(),
      'arrivalTime': eq.arrivalTime?.toIso8601String(),
      'hypocenter': eq.hypocenter != null
          ? {
              'name': eq.hypocenter!.value.name,
              'code': eq.hypocenter!.value.code,
            }
          : null,
      'maxIntensity': eq.intensity?.maxIntensity.value,
    };
  }

  static Map<String, dynamic> _earthquakeToMap(Earthquake eq) {
    return {
      'eventId': eq.eventId,
      'status': eq.status.value,
      'originTime': eq.originTime?.toIso8601String(),
      'arrivalTime': eq.arrivalTime?.toIso8601String(),
      'hypocenter': eq.hypocenter != null
          ? {
              'name': eq.hypocenter!.value.name,
              'code': eq.hypocenter!.value.code,
            }
          : null,
      'intensity': eq.intensity != null
          ? {
              'maxIntensity': eq.intensity!.maxIntensity.value,
              'prefectures': eq.intensity!.prefectures.length,
              'regions': eq.intensity!.regions.length,
            }
          : null,
      'telegrams': eq.telegrams.length,
    };
  }
}
