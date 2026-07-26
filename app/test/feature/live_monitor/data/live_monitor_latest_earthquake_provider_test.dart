import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/live_monitor/data/provider/live_monitor_latest_earthquake_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('全国一覧のeventId降順先頭を選ぶこと', () {
    expect(
      selectLiveMonitorLatestEventId([
        _partial(eventId: '202607270002'),
        _partial(eventId: '202607270001'),
      ]),
      '202607270002',
    );
  });

  test('古いeventIdの内容更新は最新eventIdを押しのけないこと', () {
    expect(
      selectLiveMonitorLatestEventId([
        _partial(eventId: '202607270002'),
        _partial(
          eventId: '202607270001',
          estimatedIntensityTileUrl:
              'https://example.test/estimated-old.pmtiles',
        ),
      ]),
      '202607270002',
    );
  });

  test('全国一覧が空なら最新eventIdを返さないこと', () {
    expect(selectLiveMonitorLatestEventId([]), isNull);
  });
}

EarthquakePartialNormal _partial({
  required String eventId,
  String? estimatedIntensityTileUrl,
}) => EarthquakePartialNormal(
  eventId: eventId,
  status: TelegramStatus.normal,
  originTime: null,
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: null,
  dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
  hypocenter: null,
  intensity: null,
  earthquakeType: EarthquakeType.normal,
  telegramTypes: const [],
  estimatedIntensityTileUrl: estimatedIntensityTileUrl,
);
