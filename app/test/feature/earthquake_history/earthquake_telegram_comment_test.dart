import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

api.EarthquakeTelegram _telegram({
  required api.TelegramType type,
  required DateTime reportedAt,
  api.TelegramComments? comments,
}) => api.EarthquakeTelegram(
  telegram: api.Telegram(
    id: '${type.name}-${reportedAt.toIso8601String()}',
    eventId: '20260713120000',
    type: type,
    title: 'タイトル',
    status: api.TelegramStatus.normal,
    infoType: api.InfoType.publication,
    editorialOffice: '気象庁本庁',
    publishingOffice: const ['気象庁'],
    pressedAt: reportedAt,
    reportedAt: reportedAt,
    infoKind: '地震情報',
    infoKindVersion: '1.0',
    hash: 'hash',
    createdAt: reportedAt,
  ),
  comments: comments,
);

void main() {
  group('extractTelegramComments', () {
    test('コメント付きの対象電文を変換する', () {
      final reportedAt = DateTime(2026, 7, 13, 12);
      final result = extractTelegramComments([
        _telegram(
          type: api.TelegramType.vxse53,
          reportedAt: reportedAt,
          comments: const api.TelegramComments(
            additional: 'この地震による津波の心配はありません。',
            free: '自由付加文です。',
          ),
        ),
      ]);

      expect(result, [
        EarthquakeTelegramComment(
          type: EarthquakeTelegramType.vxse53,
          reportedAt: reportedAt,
          additional: 'この地震による津波の心配はありません。',
          free: '自由付加文です。',
        ),
      ]);
    });

    test('commentsがnullの電文は除外する', () {
      final result = extractTelegramComments([
        _telegram(
          type: api.TelegramType.vxse53,
          reportedAt: DateTime(2026, 7, 13, 12),
        ),
      ]);
      expect(result, isEmpty);
    });

    test('additionalもfreeもnullの電文は除外する', () {
      final result = extractTelegramComments([
        _telegram(
          type: api.TelegramType.vxse53,
          reportedAt: DateTime(2026, 7, 13, 12),
          comments: const api.TelegramComments(text: '主文のみ'),
        ),
      ]);
      expect(result, isEmpty);
    });

    test('対象外タイプ（VXSE45等）は除外する', () {
      final result = extractTelegramComments([
        _telegram(
          type: api.TelegramType.vxse45,
          reportedAt: DateTime(2026, 7, 13, 12),
          comments: const api.TelegramComments(additional: '固定付加文'),
        ),
      ]);
      expect(result, isEmpty);
    });
  });
}
