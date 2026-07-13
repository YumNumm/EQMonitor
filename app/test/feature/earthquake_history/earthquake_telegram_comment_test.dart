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

  group('selectTelegramCommentLines', () {
    EarthquakeTelegramComment comment({
      required EarthquakeTelegramType type,
      required DateTime reportedAt,
      String? additional,
      String? free,
    }) => EarthquakeTelegramComment(
      type: type,
      reportedAt: reportedAt,
      additional: additional,
      free: free,
    );

    test('VXSE53があれば53のコメントを採用し51/52は無視する', () {
      final lines = selectTelegramCommentLines([
        comment(
          type: EarthquakeTelegramType.vxse51,
          reportedAt: DateTime(2026, 7, 13, 12),
          additional: '速報の付加文',
        ),
        comment(
          type: EarthquakeTelegramType.vxse53,
          reportedAt: DateTime(2026, 7, 13, 12, 10),
          additional: 'この地震による津波の心配はありません。',
        ),
      ]);
      expect(lines, ['この地震による津波の心配はありません。']);
    });

    test('VXSE53が複数あればreportedAtが最新のものを採用する', () {
      final lines = selectTelegramCommentLines([
        comment(
          type: EarthquakeTelegramType.vxse53,
          reportedAt: DateTime(2026, 7, 13, 12, 20),
          additional: '最新の付加文',
        ),
        comment(
          type: EarthquakeTelegramType.vxse53,
          reportedAt: DateTime(2026, 7, 13, 12, 10),
          additional: '古い付加文',
        ),
      ]);
      expect(lines, ['最新の付加文']);
    });

    test('VXSE53がなければ51と52のコメントを結合する', () {
      final lines = selectTelegramCommentLines([
        comment(
          type: EarthquakeTelegramType.vxse51,
          reportedAt: DateTime(2026, 7, 13, 12),
          additional: '今後の情報に注意してください。',
        ),
        comment(
          type: EarthquakeTelegramType.vxse52,
          reportedAt: DateTime(2026, 7, 13, 12, 5),
          additional: 'この地震による津波の心配はありません。',
        ),
      ]);
      expect(lines, ['今後の情報に注意してください。', 'この地震による津波の心配はありません。']);
    });

    test('VXSE6xのコメントは53に追加して表示する', () {
      final lines = selectTelegramCommentLines([
        comment(
          type: EarthquakeTelegramType.vxse53,
          reportedAt: DateTime(2026, 7, 13, 12, 10),
          additional: 'この地震による津波の心配はありません。',
        ),
        comment(
          type: EarthquakeTelegramType.vxse61,
          reportedAt: DateTime(2026, 7, 13, 13),
          free: '地震活動に関するお知らせ。',
        ),
      ]);
      expect(lines, ['この地震による津波の心配はありません。', '地震活動に関するお知らせ。']);
    });

    test('additionalとfreeの両方があればその順で表示し、同一文言は重複除去する', () {
      final lines = selectTelegramCommentLines([
        comment(
          type: EarthquakeTelegramType.vxse51,
          reportedAt: DateTime(2026, 7, 13, 12),
          additional: 'この地震による津波の心配はありません。',
          free: '自由付加文です。',
        ),
        comment(
          type: EarthquakeTelegramType.vxse52,
          reportedAt: DateTime(2026, 7, 13, 12, 5),
          additional: 'この地震による津波の心配はありません。',
        ),
      ]);
      expect(lines, ['この地震による津波の心配はありません。', '自由付加文です。']);
    });

    test('全角英数は半角に変換される', () {
      final lines = selectTelegramCommentLines([
        comment(
          type: EarthquakeTelegramType.vxse53,
          reportedAt: DateTime(2026, 7, 13, 12, 10),
          free: '地震の規模はＭ７．０です。',
        ),
      ]);
      expect(lines, ['地震の規模はM7.0です。']);
    });

    test('空入力なら空リストを返す', () {
      expect(selectTelegramCommentLines([]), isEmpty);
    });
  });
}
