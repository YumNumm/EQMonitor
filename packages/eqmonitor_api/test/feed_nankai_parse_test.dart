import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:test/test.dart';

void main() {
  group('FeedItemDataUnion EARTHQUAKE_NANKAI', () {
    // バックエンドは南海トラフ関連の feed item で telegramType: "NANKAI" を
    // 返す（FeedTelegramType の地震回数系の値ではない）。
    test('telegramType "NANKAI" を含む payload をパースできる', () {
      final json = <String, Object?>{
        'type': 'EARTHQUAKE_NANKAI',
        'infoType': 'PUBLICATION',
        'telegramType': 'NANKAI',
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
      expect(nankai.telegramType, 'NANKAI');
      expect(nankai.infoType, InfoType.publication);
      expect(nankai.earthquakeInfo?.text, '南海トラフ地震関連解説情報');
    });

    test('省略可能フィールド無しでもパースできる', () {
      final json = <String, Object?>{
        'type': 'EARTHQUAKE_NANKAI',
        'infoType': 'PUBLICATION',
        'telegramType': 'NANKAI',
      };

      final result = FeedItemDataUnion.fromJson(json);

      expect(result, isA<FeedItemDataUnionFeedEarthquakeNankaiData>());
      final nankai = result as FeedItemDataUnionFeedEarthquakeNankaiData;
      expect(nankai.telegramType, 'NANKAI');
      expect(nankai.earthquakeInfo, isNull);
    });
  });
}
