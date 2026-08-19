import 'package:dio/dio.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew_history/data/model/eew_list_page.dart';
import 'package:eqmonitor/feature/eew_history/data/model/eew_list_parameter.dart';
import 'package:eqmonitor/feature/eew_history/data/notifier/eew_list_data_source.dart';
import 'package:eqmonitor/feature/eew_history/data/repository/eew_list_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:paging_view/paging_view.dart';

EewTelegramItem _eew({
  required String eventId,
  required DateTime originTime,
}) => EewTelegramItem(
  eventId: eventId,
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: false,
  isLastInfo: true,
  reportTime: originTime,
  isPlum: false,
  originTime: originTime,
);

class _FakeEewListRepository extends EewListRepository {
  new() : super(eew: api.ApiClient(Dio()).eew);

  final cursors = <String?>[];
  String? nextToken;
  List<EewTelegramItem> items = const [];

  @override
  Future<EewListPage> fetchEewList({
    required EewListParameter parameter,
    required String? cursor,
    required int limit,
  }) async {
    cursors.add(cursor);
    return EewListPage(items: items, nextToken: nextToken);
  }
}

void main() {
  group('EewListDataSource.groupBy', () {
    test('originTime をローカル日付 yyyy/MM/dd でグループ化', () {
      final ds = EewListDataSource(
        repository: _FakeEewListRepository(),
        parameter: const EewListParameter(),
      );
      final key = ds.groupBy(
        _eew(eventId: 'e1', originTime: DateTime.utc(2026, 6, 27, 3)),
      );
      // ローカルタイムに依存するため、形式(8文字 + 区切り)のみ検証
      expect(key, matches(r'^\d{4}/\d{2}/\d{2}$'));
    });
  });

  group('EewListDataSource.load', () {
    test('Refresh は cursor=null、Append は受け取った key を渡す', () async {
      final repo = _FakeEewListRepository()
        ..items = [_eew(eventId: 'e1', originTime: DateTime.utc(2026, 6, 27))]
        ..nextToken = 'next-1';
      final ds = EewListDataSource(
        repository: repo,
        parameter: const EewListParameter(),
      );

      final refresh = await ds.load(const Refresh());
      expect(refresh, isA<Success<String?, EewTelegramItem>>());
      await ds.load(const Append(key: 'next-1'));

      expect(repo.cursors, [null, 'next-1']);
    });

    test('Success の appendKey に nextToken が入る', () async {
      final repo = _FakeEewListRepository()
        ..items = [_eew(eventId: 'e1', originTime: DateTime.utc(2026, 6, 27))]
        ..nextToken = 'tok';
      final ds = EewListDataSource(
        repository: repo,
        parameter: const EewListParameter(),
      );
      final result = await ds.load(const Refresh());
      final success = result as Success<String?, EewTelegramItem>;
      expect(success.page.appendKey, 'tok');
      expect(success.page.data.single.eventId, 'e1');
    });
  });
}
