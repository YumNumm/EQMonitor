import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_warning_candidate_selector.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final selector = EewWarningCandidateSelector();

  test('現在報のwarning prefectureに含まれる警報だけを返す', () {
    final result = selector.select(
      aliveEews: [
        warningEew(
          eventId: 'eligible',
          warningPrefectureCode: '9011',
          hadWarning: false,
        ),
        warningEew(eventId: 'other', warningPrefectureCode: '9020'),
        warningEew(
          eventId: 'forecast',
          warningPrefectureCode: '9011',
          isWarning: false,
        ),
        warningEew(
          eventId: 'canceled',
          warningPrefectureCode: '9011',
          isCanceled: true,
        ),
      ],
      warningAreaCode: '9011',
      warningAreaName: '北海道道央',
      forecastAreaCode: '100',
      forecastAreaName: '石狩地方北部',
    );

    expect(result.map((candidate) => candidate.event.eventId), ['eligible']);
  });

  test('forecast area codeで現在地震度と到達情報を関連付ける', () {
    final arrival = DateTime.utc(2026, 7, 25, 12, 0, 10);
    final result = selector
        .select(
          aliveEews: [
            warningEew(
              eventId: 'event',
              warningRegionCode: '100',
              forecastRegionCode: '100',
              intensity: JmaIntensity.sixLower,
              arrivalTime: arrival,
            ),
          ],
          warningAreaCode: '9011',
          warningAreaName: '北海道道央',
          forecastAreaCode: '100',
          forecastAreaName: '石狩地方北部',
        )
        .single;

    expect(result.localForecastRegion?.intensity, JmaIntensity.sixLower);
    expect(result.localForecastRegion?.arrivalTime, arrival);
  });

  test('forecast area未解決でも対象警報は候補に残す', () {
    final result = selector
        .select(
          aliveEews: [warningEew(eventId: 'event', warningRegionCode: '100')],
          warningAreaCode: '9011',
          warningAreaName: '北海道道央',
          forecastAreaCode: null,
          forecastAreaName: null,
        )
        .single;

    expect(result.localForecastRegion, isNull);
  });
}

EewTelegramItem warningEew({
  required String eventId,
  bool? isWarning = true,
  bool isCanceled = false,
  String warningPrefectureCode = '9011',
  String warningRegionCode = '100',
  bool hadWarning = true,
  String forecastRegionCode = '999',
  JmaIntensity intensity = JmaIntensity.fiveLower,
  DateTime? arrivalTime,
  bool isArrived = false,
}) => EewTelegramItem(
  eventId: eventId,
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: isCanceled,
  isLastInfo: false,
  reportTime: DateTime.utc(2026, 7, 25, 11, 59),
  isPlum: false,
  isWarning: isWarning,
  arrivalTime: DateTime.utc(2026, 7, 25, 12, 30),
  forecastIntensity: EewForecastIntensityInfo(
    regions: [
      EewForecastRegionInfo(
        code: forecastRegionCode,
        name: '予報区',
        isPlum: false,
        isWarning: true,
        intensity: intensity,
        intensityIsOver: false,
        arrivalTime: arrivalTime,
        isArrived: isArrived,
      ),
    ],
  ),
  warning: EewWarningInfo(
    regions: [
      EewWarningZoneInfo(
        code: warningRegionCode,
        name: '警報地域',
        hadWarning: hadWarning,
      ),
    ],
    zones: [
      EewWarningZoneInfo(code: '9910', name: '北海道', hadWarning: hadWarning),
    ],
    prefectures: [
      EewWarningZoneInfo(
        code: warningPrefectureCode,
        name: '府県予報区',
        hadWarning: hadWarning,
      ),
    ],
  ),
);
