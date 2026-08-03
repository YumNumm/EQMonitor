import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:test/test.dart';

/// 契約 drift テスト。
///
/// api-stub の `FIXTURE_REGISTRY`（default + named、backend が 200 レスポンスとして配信する形）を
/// 決定論 JSON 化した fixtures を、各エンドポイントの response 型（Retrofit クライアントの
/// 戻り値型）の `fromJson` でパースし、形状ドリフトを検出する。
///
/// - パース例外 = drift（モデルが backend のレスポンス形に追従できていない）。
/// - マップ済みキーの fixture が欠落 = drift（endpoint rename/削除の疑い）→ fail loud。
/// - 対応モデルが未定義のキー（例 GET /health）= SKIP（明示ログ。silent な網羅を防ぐ）。
///
/// fixtures は `packages/eqmonitor_api/bin/generate.dart` が backend submodule の
/// `api/api-stub/generated/contract-fixtures/` からコピーする（openapi.json と同じ取り込み経路。
/// app CI は submodule を checkout しないためメインリポへのコピーが必須）。
///
final _parsers = <String, Object? Function(Map<String, Object?>)>{
  'GET /v1/changelog': ChangelogResponse.fromJson,
  'GET /v1/start': StartResponse.fromJson,
  'GET /v2/earthquake': EarthquakeListResponse.fromJson,
  'GET /v2/earthquake/:eventId': EarthquakeDetailResponse.fromJson,
  'GET /v2/earthquake/intensity/region/:code':
      IntensityRegionSearchResponse.fromJson,
  'GET /v2/earthquake/intensity/prefecture/:code':
      IntensityPrefectureSearchResponse.fromJson,
  'GET /v2/earthquake/intensity/city/:code':
      IntensityCitySearchResponse.fromJson,
  'GET /v2/earthquake/intensity/station/:code':
      IntensityStationSearchResponse.fromJson,
  'GET /v2/eew': EewListResponse.fromJson,
  'GET /v2/eew/latest': EewLatestResponse.fromJson,
  'GET /v2/eew/:eventId': EewArrayResponse.fromJson,
  'GET /v2/eew/:eventId/:serialNo': EewItemWithRelations.fromJson,
  'GET /v2/hypocenters': HypocenterListResponse.fromJson,
  'GET /v2/hypocenters/manifest': HypocenterManifestResponse.fromJson,
  'GET /v2/tsunami': TsunamiListResponse.fromJson,
  'GET /v2/tsunami/active': TsunamiListResponse.fromJson,
  'GET /v2/tsunami/by-event-id/:eventId': TsunamiState.fromJson,
  'GET /v2/tsunami/:tsunamiId': TsunamiState.fromJson,
  'GET /v2/telegram': TelegramListResponse.fromJson,
  'GET /v2/telegram/type/:type': TelegramListResponse.fromJson,
  'GET /v2/telegram/eventId/:eventId': TelegramListResponse.fromJson,
  'GET /v2/telegram/:id': TelegramDetailResponse.fromJson,
  // GET /health は専用モデルが無いため SKIP。
};

/// 現在判明している乖離（quarantine）。これらは Valibot 未検証 fixtures で、
/// 厳密スキーマに準拠していないため gate から除外する（CI を赤にしない）。
/// 詳細・triage・follow-up: docs/superpowers/specs/2026-05-30-spec1-contract-drift-findings.md
///
/// 境界は「default/named」ではなく「現在判明している乖離」。stub fixture を修正したら
/// ここから外して gate に昇格する。
///
/// - Owner: YumNumm
/// - β 前の扱い: waiver（影響は fixture 厳密性のみで、ランタイム挙動に影響なし）。
///   β リリース前に findings doc を再レビューし、stub fixture 側の修正が終わったエントリは
///   gate に昇格させること。
/// - このセットを追加/削除する場合は、下部の
///   `quarantine セットが記録済みの内容から変化していない` テストの期待値も更新し、
///   findings doc に追記すること（新規追加が無自覚に紛れ込むことを防ぐガード）。
const _quarantine = <String>{
  'get__v1_changelog.json',
  'get__v1_changelog__with-entries.json',
  'get__v1_start.json',
  'get__v1_start__force-update.json',
  'get__v1_start__maintenance.json',
  'get__v2_earthquake_eventId__canceled.json',
  'get__v2_telegram_id.json',
  'get__v2_telegram_id__vtse41.json',
  'get__v2_telegram_id__vtse51.json',
  'get__v2_telegram_id__vtse52.json',
  'get__v2_telegram_id__vtse56.json',
  'get__v2_telegram_id__vxse51.json',
  'get__v2_telegram_id__vxse56.json',
  'get__v2_telegram_id__vzse40.json',
  'get__v2_telegram_id__with-comments.json',
  'get__v2_tsunami_tsunamiId__with-telegrams.json',
};

void main() {
  final fixturesDir = Directory('test/fixtures/contract');
  final indexFile = File('${fixturesDir.path}/index.json');

  test('contract fixtures index が存在する', () {
    expect(
      indexFile.existsSync(),
      isTrue,
      reason: 'index.json が無い。generate.dart で fixtures をコピーしたか確認',
    );
  });

  test('quarantine セットが記録済みの内容から変化していない', () {
    // 新規 quarantine の追加/削除が無自覚に紛れ込むことを防ぐガード。
    // _quarantine を変更する場合は、この期待値と
    // docs/superpowers/specs/2026-05-30-spec1-contract-drift-findings.md
    // の両方を合わせて更新すること（owner: YumNumm）。
    const expectedQuarantine = <String>{
      'get__v1_changelog.json',
      'get__v1_changelog__with-entries.json',
      'get__v1_start.json',
      'get__v1_start__force-update.json',
      'get__v1_start__maintenance.json',
      'get__v2_earthquake_eventId__canceled.json',
      'get__v2_telegram_id.json',
      'get__v2_telegram_id__vtse41.json',
      'get__v2_telegram_id__vtse51.json',
      'get__v2_telegram_id__vtse52.json',
      'get__v2_telegram_id__vtse56.json',
      'get__v2_telegram_id__vxse51.json',
      'get__v2_telegram_id__vxse56.json',
      'get__v2_telegram_id__vzse40.json',
      'get__v2_telegram_id__with-comments.json',
      'get__v2_tsunami_tsunamiId__with-telegrams.json',
    };

    expect(
      _quarantine.length,
      expectedQuarantine.length,
      reason:
          '_quarantine の件数が変化した（${_quarantine.length} 件）。'
          '意図した変更であれば expectedQuarantine と findings doc を更新すること。',
    );
    expect(
      _quarantine,
      equals(expectedQuarantine),
      reason:
          '_quarantine の内容が記録済みの期待値と一致しない。'
          '意図した変更であれば expectedQuarantine と findings doc を更新すること。',
    );
  });

  final index = (jsonDecode(indexFile.readAsStringSync()) as List)
      .cast<Map<String, Object?>>();

  for (final entry in index) {
    final key = entry['key']! as String;
    final file = entry['file']! as String;
    final fixtureName = entry['fixture'] as String?;
    final label = fixtureName == null ? key : '$key [$fixtureName]';
    final parser = _parsers[key];

    if (parser == null) {
      test(
        'SKIP (no Dart model mapping): $label',
        () {},
        skip: 'no Dart model mapping for $key',
      );
      continue;
    }

    if (_quarantine.contains(file)) {
      test(
        'QUARANTINE: $label [$file]',
        () {},
        skip:
            '既知の乖離。findings doc 参照 '
            '(docs/superpowers/specs/2026-05-30-spec1-contract-drift-findings.md)',
      );
      continue;
    }

    test('$label が $file をパースできる', () {
      final fixtureFile = File('${fixturesDir.path}/$file');
      expect(
        fixtureFile.existsSync(),
        isTrue,
        reason: 'mapped fixture が欠落: $file（endpoint rename/削除の疑い）',
      );

      final json =
          jsonDecode(fixtureFile.readAsStringSync()) as Map<String, Object?>;
      expect(() => parser(json), returnsNormally);
    });
  }
}
