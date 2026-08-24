import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:test/test.dart';

void main() {
  group('FeedItemDataUnion EARTHQUAKE_NANKAI', () {
    test('南海トラフ情報名を含む payload をパースできる', () {
      final json = <String, Object?>{
        'type': 'EARTHQUAKE_NANKAI',
        'infoType': 'PUBLICATION',
        'telegramType': '南海トラフ地震関連解説情報',
        'earthquakeInfo': {
          'text': '南海トラフ地震関連解説情報',
          'kind': {'code': '1', 'name': '調査中'},
        },
        'nextAdvisory': '次回の情報発表予定',
        'text': '本文',
      };

      final result = FeedItemDataUnion.fromJson(json);

      expect(result, isA<FeedItemDataUnionFeedEarthquakeNankaiData>());
      final nankai = result as FeedItemDataUnionFeedEarthquakeNankaiData;
      expect(nankai.telegramType, NankaiTelegramType.undefined1);
      expect(nankai.infoType, InfoType.publication);
      expect(nankai.earthquakeInfo?.text, '南海トラフ地震関連解説情報');
    });

    test('省略可能フィールド無しでもパースできる', () {
      final json = <String, Object?>{
        'type': 'EARTHQUAKE_NANKAI',
        'infoType': 'PUBLICATION',
        'telegramType': '南海トラフ地震臨時情報',
      };

      final result = FeedItemDataUnion.fromJson(json);

      expect(result, isA<FeedItemDataUnionFeedEarthquakeNankaiData>());
      final nankai = result as FeedItemDataUnionFeedEarthquakeNankaiData;
      expect(nankai.telegramType, NankaiTelegramType.undefined0);
      expect(nankai.earthquakeInfo, isNull);
    });
  });
}
