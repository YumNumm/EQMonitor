import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_warning_arrival_classifier.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_warning_candidate_selector.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_warning_display_model_builder.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_warning_representative_selector.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_candidate.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime.utc(2026, 7, 25, 12);

  test('到達区分を未到達 不明 到達済みの順に分類する', () {
    final classifier = EewWarningArrivalClassifier();
    expect(
      classifier.classify(
        candidate: candidate(arrivalTime: now.add(const Duration(seconds: 5))),
        now: now,
      ),
      EewWarningArrivalState.unarrived,
    );
    expect(
      classifier.classify(candidate: candidate(), now: now),
      EewWarningArrivalState.unknown,
    );
    expect(
      classifier.classify(candidate: candidate(isArrived: true), now: now),
      EewWarningArrivalState.arrived,
    );
    expect(
      classifier.classify(
        candidate: candidate(arrivalTime: now),
        now: now,
      ),
      EewWarningArrivalState.arrived,
    );
  });

  final representativeCases = [
    (
      name: '到達区分は未到達を不明より優先する',
      candidates: [
        candidate(eventId: 'unknown'),
        candidate(
          eventId: 'unarrived',
          arrivalTime: now.add(const Duration(seconds: 10)),
        ),
      ],
      expectedEventId: 'unarrived',
    ),
    (
      name: '到達区分は不明を到達済みより優先する',
      candidates: [
        candidate(eventId: 'unknown'),
        candidate(eventId: 'arrived', isArrived: true),
      ],
      expectedEventId: 'unknown',
    ),
    (
      name: '到達区分が同じなら震度の高い候補を優先する',
      candidates: [
        candidate(
          eventId: 'lower',
          intensity: JmaIntensity.fiveUpper,
          arrivalTime: now.add(const Duration(seconds: 10)),
        ),
        candidate(
          eventId: 'higher',
          intensity: JmaIntensity.sixLower,
          arrivalTime: now.add(const Duration(seconds: 10)),
        ),
      ],
      expectedEventId: 'higher',
    ),
    (
      name: '到達区分と震度が同じなら新しいreportTimeを優先する',
      candidates: [
        candidate(
          eventId: 'older',
          arrivalTime: now.add(const Duration(seconds: 10)),
          reportTime: now.subtract(const Duration(seconds: 1)),
        ),
        candidate(
          eventId: 'newer',
          arrivalTime: now.add(const Duration(seconds: 10)),
          reportTime: now,
        ),
      ],
      expectedEventId: 'newer',
    ),
    (
      name: '前三条件が同じならeventIdの辞書順を優先する',
      candidates: [
        candidate(
          eventId: 'b',
          arrivalTime: now.add(const Duration(seconds: 10)),
          reportTime: now,
        ),
        candidate(
          eventId: 'a',
          arrivalTime: now.add(const Duration(seconds: 10)),
          reportTime: now,
        ),
      ],
      expectedEventId: 'a',
    ),
  ];
  for (final testCase in representativeCases) {
    test(testCase.name, () {
      final selected = EewWarningRepresentativeSelector().select(
        candidates: testCase.candidates,
        now: now,
      );

      expect(selected?.event.eventId, testCase.expectedEventId);
    });
  }

  test('実警報表示を構造化データから集約する', () {
    final model = EewWarningDisplayModelBuilder().build(
      candidates: [
        candidate(
          eventId: 'b',
          serialNo: 3,
          detailedHypocenterName: 'テスト震源詳細',
          warningZones: const [('9920', '東北'), ('9910', '北海道')],
          intensity: JmaIntensity.sixLower,
          arrivalTime: now.add(const Duration(seconds: 10)),
        ),
        candidate(
          eventId: 'c',
          warningZones: const [('9920', '東北'), ('9931', '関東')],
          intensity: JmaIntensity.fiveUpper,
        ),
      ],
      now: now,
    );

    expect(model?.source, EewWarningOverlaySource.real);
    expect(model?.representativeEventId, 'b');
    expect(model?.eventIds, ['b', 'c']);
    expect(model?.alertCount, 2);
    expect(model?.reportLabel, '緊急地震速報（警報） 第3報');
    expect(model?.hypocenterHeadline, 'テスト震源詳細で地震');
    expect(model?.strongMotionHeadline, '北海道 東北 関東で強い揺れ');
    expect(model?.currentRegionName, '現在地予報区');
    expect(model?.localIntensity, JmaIntensity.sixLower);
    expect(model?.localIntensityIsOver, isFalse);
    expect(model?.arrivalState, EewWarningArrivalState.unarrived);
    expect(model?.secondsUntilArrival, 10);
    expect(model?.hypocenterName, 'テスト震源');
    expect(model?.magnitude, 6.2);
    expect(model?.depth, 30);
  });

  test('PLUM法とレベル法では震源見出しを表示しない', () {
    final builder = EewWarningDisplayModelBuilder();
    final plumCandidate = candidate(isPlum: true);
    final levelCandidate = candidate(isLevelMethod: true);

    expect(
      builder.build(candidates: [plumCandidate], now: now)?.hypocenterHeadline,
      isNull,
    );
    expect(
      builder.build(candidates: [levelCandidate], now: now)?.hypocenterHeadline,
      isNull,
    );
  });

  test('警報zoneがなければ汎用警戒見出しを使う', () {
    final noZoneCandidate = candidate(warningZones: const []);

    expect(
      EewWarningDisplayModelBuilder()
          .build(candidates: [noZoneCandidate], now: now)
          ?.strongMotionHeadline,
      '強い揺れに警戒',
    );
  });

  test('候補が空なら表示しない', () {
    expect(
      EewWarningDisplayModelBuilder().build(candidates: const [], now: now),
      isNull,
    );
  });

  test('現在地予報が不明なら不明な局地情報と警報地域名を使う', () {
    final model = EewWarningDisplayModelBuilder().build(
      candidates: [candidate(hasLocalForecast: false)],
      now: now,
    );

    expect(model?.currentRegionName, '石狩地方北部');
    expect(model?.localIntensity, JmaIntensity.unknown);
    expect(model?.localIntensityIsOver, isFalse);
    expect(model?.arrivalState, EewWarningArrivalState.unknown);
    expect(model?.secondsUntilArrival, isNull);
  });
}

EewWarningOverlayCandidate candidate({
  String eventId = 'event',
  int serialNo = 1,
  DateTime? reportTime,
  bool isPlum = false,
  bool isLevelMethod = false,
  String? detailedHypocenterName,
  List<(String, String)> warningZones = const [('9910', '北海道')],
  JmaIntensity intensity = JmaIntensity.fiveLower,
  DateTime? arrivalTime,
  bool isArrived = false,
  bool hasLocalForecast = true,
}) {
  final event = EewTelegramItem(
    eventId: eventId,
    status: TelegramStatus.normal,
    infoType: TelegramInfoType.publication,
    serialNo: serialNo,
    isCanceled: false,
    isLastInfo: false,
    reportTime: reportTime ?? DateTime.utc(2026, 7, 25, 11, 59),
    isPlum: isPlum,
    isWarning: true,
    originTime: isLevelMethod ? null : DateTime.utc(2026, 7, 25, 11, 58),
    accuracy: EewAccuracyInfo(
      epicenter: isLevelMethod ? 1 : 4,
      hypocenter: 4,
      depth: 4,
      magnitudeCalculation: 5,
      numberOfMagnitudeCalculation: 5,
    ),
    hypocenter: EewHypocenterInfo(
      code: '001',
      name: 'テスト震源',
      detailedName: detailedHypocenterName,
      magnitude: 6.2,
      depth: 30,
    ),
    forecastIntensity: EewForecastIntensityInfo(
      regions: hasLocalForecast
          ? [
              EewForecastRegionInfo(
                code: '100',
                name: '現在地予報区',
                isPlum: false,
                isWarning: true,
                intensity: intensity,
                intensityIsOver: false,
                arrivalTime: arrivalTime,
                isArrived: isArrived,
              ),
            ]
          : const [],
    ),
    warning: EewWarningInfo(
      zones: warningZones
          .map(
            (zone) => EewWarningZoneInfo(
              code: zone.$1,
              name: zone.$2,
              hadWarning: true,
            ),
          )
          .toList(),
      prefectures: const [],
      regions: const [
        EewWarningZoneInfo(code: '100', name: '石狩地方北部', hadWarning: true),
      ],
    ),
  );

  return EewWarningCandidateSelector()
      .select(
        aliveEews: [event],
        warningAreaCode: '100',
        warningAreaName: '石狩地方北部',
        forecastAreaCode: hasLocalForecast ? '100' : null,
        forecastAreaName: hasLocalForecast ? '現在地予報区' : null,
      )
      .single;
}
