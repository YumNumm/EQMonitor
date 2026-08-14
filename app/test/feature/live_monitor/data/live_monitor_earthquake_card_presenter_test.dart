import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_metadata.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_summary_header.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_earthquake_card_presenter.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:flutter_test/flutter_test.dart';

final _reportedAt = DateTime.utc(2026, 7, 27, 12);

Earthquake _earthquake({
  JmaLpgmIntensity? maxLpgmIntensity,
  String? estimatedIntensityTileUrl,
  List<EarthquakeTelegramMetadata> telegramMetadata = const [],
}) => Earthquake(
  eventId: 'earthquake',
  status: TelegramStatus.normal,
  originTime: _reportedAt,
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: _reportedAt,
  dataSources: const [],
  telegramTypes: const [],
  telegramMetadata: telegramMetadata,
  hypocenter: null,
  intensity: EarthquakeIntensity(
    maxIntensity: JmaIntensity.unknown,
    maxLpgmIntensity: maxLpgmIntensity,
    regions: const {},
    intensityTree: const {},
    lpgmIntensityTree: const {},
  ),
  estimatedIntensityTileUrl: estimatedIntensityTileUrl,
);

EewTelegramItem _eew({
  required String eventId,
  required DateTime reportTime,
  required int serialNo,
}) => EewTelegramItem(
  eventId: eventId,
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: serialNo,
  isCanceled: false,
  isLastInfo: false,
  reportTime: reportTime,
  isPlum: false,
);

ShakeDetectionEvent _shake({
  required String eventId,
  required DateTime updatedAt,
  required int serialNo,
}) => ShakeDetectionEvent(
  eventId: eventId,
  serialNo: serialNo,
  createdAt: updatedAt,
  updatedAt: updatedAt,
  expiresAt: updatedAt.add(const Duration(minutes: 1)),
  level: ShakeDetectionLevel.medium,
  pointCount: 1,
  minLat: 35,
  maxLat: 36,
  minLng: 139,
  maxLng: 140,
  changeReasons: const ['new_event'],
);

void main() {
  test('EarthquakeSummaryHeaderは既存detail向けにwatermarkを既定で無効にする', () {
    final header = EarthquakeSummaryHeader(item: _earthquake());

    expect(header.showStatusWatermark, isFalse);
  });

  group('preferredIntensityMode', () {
    test('VXSE62はLPGMデータがあれば長周期地震動を選ぶ', () {
      final mode = LiveMonitorEarthquakeCardPresenter.preferredIntensityMode(
        earthquake: _earthquake(maxLpgmIntensity: JmaLpgmIntensity.two),
        trigger: LiveMonitorEarthquakeTrigger.telegram(
          kind: LiveMonitorEarthquakeTriggerKind.vxse62,
          reportedAt: _reportedAt,
        ),
      );

      expect(mode, IntensityDisplayMode.lpgm);
    });

    test('VXSE62でもLPGMデータがなければ気象庁震度を選ぶ', () {
      final mode = LiveMonitorEarthquakeCardPresenter.preferredIntensityMode(
        earthquake: _earthquake(),
        trigger: LiveMonitorEarthquakeTrigger.telegram(
          kind: LiveMonitorEarthquakeTriggerKind.vxse62,
          reportedAt: _reportedAt,
        ),
      );

      expect(mode, IntensityDisplayMode.jma);
    });

    test('推計震度triggerはタイルURLがあれば推計震度を選ぶ', () {
      final mode = LiveMonitorEarthquakeCardPresenter.preferredIntensityMode(
        earthquake: _earthquake(
          estimatedIntensityTileUrl: 'https://example.com/estimated.pmtiles',
        ),
        trigger: const LiveMonitorEarthquakeTrigger.estimatedIntensity(
          generatedAt: null,
        ),
      );

      expect(mode, IntensityDisplayMode.estimated);
    });

    test('推計震度triggerでもタイルURLがなければ気象庁震度を選ぶ', () {
      final mode = LiveMonitorEarthquakeCardPresenter.preferredIntensityMode(
        earthquake: _earthquake(),
        trigger: const LiveMonitorEarthquakeTrigger.estimatedIntensity(
          generatedAt: null,
        ),
      );

      expect(mode, IntensityDisplayMode.jma);
    });

    test('分割表示はtriggerなしでもfull推計震度URLがあれば推計震度を選ぶ', () {
      final mode = LiveMonitorEarthquakeCardPresenter.preferredIntensityMode(
        earthquake: _earthquake(
          maxLpgmIntensity: JmaLpgmIntensity.two,
          estimatedIntensityTileUrl: 'https://example.com/estimated.pmtiles',
          telegramMetadata: [
            EarthquakeTelegramMetadata(
              type: EarthquakeTelegramType.vxse62,
              reportedAt: _reportedAt,
            ),
          ],
        ),
        trigger: null,
      );

      expect(mode, IntensityDisplayMode.estimated);
    });

    test('VXSE53は気象庁震度を選ぶ', () {
      final mode = LiveMonitorEarthquakeCardPresenter.preferredIntensityMode(
        earthquake: _earthquake(
          maxLpgmIntensity: JmaLpgmIntensity.two,
          estimatedIntensityTileUrl: 'https://example.com/estimated.pmtiles',
        ),
        trigger: LiveMonitorEarthquakeTrigger.telegram(
          kind: LiveMonitorEarthquakeTriggerKind.vxse53,
          reportedAt: _reportedAt,
        ),
      );

      expect(mode, IntensityDisplayMode.jma);
    });
  });

  group('LiveMonitorEarthquakePresentation', () {
    test('splitは推計震度URLがあればtriggerを補完せず推計震度を選ぶ', () {
      final earthquake = _earthquake(
        maxLpgmIntensity: JmaLpgmIntensity.two,
        estimatedIntensityTileUrl: 'https://example.com/estimated.pmtiles',
        telegramMetadata: [
          EarthquakeTelegramMetadata(
            type: EarthquakeTelegramType.vxse62,
            reportedAt: _reportedAt,
          ),
        ],
      );

      final presentation = LiveMonitorEarthquakePresentation.forSplit(
        earthquake: earthquake,
      );

      expect(presentation.displayMode, IntensityDisplayMode.estimated);
      expect(presentation.publicationAt, _reportedAt);
    });

    test('event表示はfullの最新電文で補完せず実際のtriggerを表示方針に使う', () {
      final trigger = LiveMonitorEarthquakeTrigger.telegram(
        kind: LiveMonitorEarthquakeTriggerKind.vxse53,
        reportedAt: _reportedAt,
      );
      final latestAt = _reportedAt.add(const Duration(minutes: 1));
      final earthquake = _earthquake(
        maxLpgmIntensity: JmaLpgmIntensity.two,
        estimatedIntensityTileUrl: 'https://example.com/estimated.pmtiles',
        telegramMetadata: [
          EarthquakeTelegramMetadata(
            type: EarthquakeTelegramType.vxse62,
            reportedAt: latestAt,
          ),
        ],
      );

      final presentation = LiveMonitorEarthquakePresentation.forTrigger(
        earthquake: earthquake,
        trigger: trigger,
      );

      expect(presentation.displayMode, IntensityDisplayMode.jma);
      expect(presentation.publicationAt, latestAt);
    });

    test('fullに対応電文がない場合だけ現在のtelegram triggerを発表時刻に使う', () {
      final presentation = LiveMonitorEarthquakePresentation.forTrigger(
        earthquake: _earthquake(),
        trigger: LiveMonitorEarthquakeTrigger.telegram(
          kind: LiveMonitorEarthquakeTriggerKind.vxse53,
          reportedAt: _reportedAt,
        ),
      );

      expect(presentation.publicationAt, _reportedAt);
    });

    test('発表時刻がない推計震度triggerから時刻を推測しない', () {
      final presentation = LiveMonitorEarthquakePresentation.forTrigger(
        earthquake: _earthquake(),
        trigger: LiveMonitorEarthquakeTrigger.estimatedIntensity(
          generatedAt: _reportedAt,
        ),
      );

      expect(presentation.publicationAt, isNull);
    });
  });

  test('latestSupportedTelegramTriggerは対象電文の最新発表時刻を選ぶ', () {
    final earthquake = _earthquake(
      telegramMetadata: [
        EarthquakeTelegramMetadata(
          type: EarthquakeTelegramType.vxse62,
          reportedAt: _reportedAt.add(const Duration(minutes: 2)),
        ),
        EarthquakeTelegramMetadata(
          type: EarthquakeTelegramType.vxse45Warning,
          reportedAt: _reportedAt.add(const Duration(minutes: 4)),
        ),
        EarthquakeTelegramMetadata(
          type: EarthquakeTelegramType.vxse51,
          reportedAt: _reportedAt,
        ),
        EarthquakeTelegramMetadata(
          type: EarthquakeTelegramType.vxse61,
          reportedAt: _reportedAt.add(const Duration(minutes: 3)),
        ),
      ],
    );

    expect(
      LiveMonitorEarthquakeCardPresenter.latestSupportedTelegramTrigger(
        earthquake,
      ),
      LiveMonitorEarthquakeTrigger.telegram(
        kind: LiveMonitorEarthquakeTriggerKind.vxse61,
        reportedAt: _reportedAt.add(const Duration(minutes: 3)),
      ),
    );
  });

  test('orderedLiveMonitorEewsは発表時刻とserialNoの降順で返す', () {
    final sameTime = _reportedAt.add(const Duration(minutes: 1));
    final input = [
      _eew(eventId: 'old', reportTime: _reportedAt, serialNo: 9),
      _eew(eventId: 'new-low', reportTime: sameTime, serialNo: 1),
      _eew(eventId: 'new-high', reportTime: sameTime, serialNo: 2),
    ];

    expect(
      LiveMonitorEarthquakeCardPresenter.orderedEews(input)
          .map((event) => event.eventId),
      ['new-high', 'new-low', 'old'],
    );
    expect(input.map((event) => event.eventId), ['old', 'new-low', 'new-high']);
  });

  test('orderedLiveMonitorShakesは更新時刻とserialNoの降順で返す', () {
    final sameTime = _reportedAt.add(const Duration(minutes: 1));
    final input = [
      _shake(eventId: 'old', updatedAt: _reportedAt, serialNo: 9),
      _shake(eventId: 'new-low', updatedAt: sameTime, serialNo: 1),
      _shake(eventId: 'new-high', updatedAt: sameTime, serialNo: 2),
    ];

    expect(
      LiveMonitorEarthquakeCardPresenter.orderedShakes(input)
          .map((event) => event.eventId),
      ['new-high', 'new-low', 'old'],
    );
    expect(input.map((event) => event.eventId), ['old', 'new-low', 'new-high']);
  });
}
