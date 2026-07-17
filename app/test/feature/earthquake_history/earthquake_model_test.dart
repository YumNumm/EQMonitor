import 'dart:convert';

import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Earthquake.telegramComments', () {
    Earthquake buildEarthquake() => Earthquake(
      eventId: '20260713120000',
      status: TelegramStatus.normal,
      originTime: DateTime(2026, 7, 13, 12),
      originTimePrecision: OriginTimePrecision.second,
      arrivalTime: null,
      dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
      telegramTypes: const [EarthquakeTelegramType.vxse53],
      telegramComments: [
        EarthquakeTelegramComment(
          type: EarthquakeTelegramType.vxse53,
          reportedAt: DateTime(2026, 7, 13, 12),
          additional: 'この地震による津波の心配はありません。',
          free: null,
        ),
      ],
      hypocenter: null,
      intensity: null,
      estimatedIntensityTileUrl: null,
    );

    test('JSON往復でtelegramCommentsが保持される', () {
      final earthquake = buildEarthquake();
      final json =
          jsonDecode(jsonEncode(earthquake.toJson())) as Map<String, dynamic>;
      expect(Earthquake.fromJson(json), earthquake);
    });

    test('telegramCommentsキーがない旧キャッシュJSONは空リストになる', () {
      final earthquake = buildEarthquake();
      final json =
          jsonDecode(jsonEncode(earthquake.toJson())) as Map<String, dynamic>
            ..remove('telegram_comments');
      expect(Earthquake.fromJson(json).telegramComments, isEmpty);
    });
  });
}
