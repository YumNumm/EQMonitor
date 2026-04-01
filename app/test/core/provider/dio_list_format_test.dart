import 'package:dio/dio.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:test/test.dart';

void main() {
  test(
    'ListFormat.multi は単一要素の statuses をスカラー風にし multiCompatible は brackets を付ける',
    () {
      final params = <String, dynamic>{
        'statuses': <TelegramStatus>[TelegramStatus.normal],
        'limit': '50',
      };

      final multi = Transformer.urlEncodeQueryMap(
        params,
      );
      expect(multi, 'statuses=NORMAL&limit=50');

      final multiCompatible = Transformer.urlEncodeQueryMap(
        params,
        ListFormat.multiCompatible,
      );
      expect(multiCompatible, 'statuses[]=NORMAL&limit=50');
    },
  );

  test(
    'Dio BaseOptions に multiCompatible を渡すと RequestOptions.uri が brackets 形式になる',
    () {
      final options = RequestOptions(
        path: '/v2/telegram/eventId/20260401100625',
        baseUrl: 'https://v2.api.eqmonitor.app',
        queryParameters: <String, dynamic>{
          'statuses': <TelegramStatus>[TelegramStatus.normal],
          'limit': '50',
        },
        listFormat: ListFormat.multiCompatible,
      );

      expect(
        options.uri.query,
        'statuses%5B%5D=NORMAL&limit=50',
      );
    },
  );
}
