import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:test/test.dart';

/// 契約 drift テスト。
///
/// api-stub の `DEFAULT_MOCKS`（backend が Valibot で検証済み）を決定論 JSON 化した
/// fixtures を、対応する Freezed モデルの `fromJson` でパースし、形状ドリフトを検出する。
///
/// - パース例外 = drift（モデルが backend のレスポンス形に追従できていない）。
/// - マップ済みキーの fixture が欠落 = drift（endpoint rename/削除の疑い）→ fail loud。
/// - 対応モデルが未定義の file = SKIP（silent な「網羅したつもり」を防ぐため明示ログ）。
///
/// fixtures は `packages/eqmonitor_api/bin/generate.dart` が backend submodule から
/// コピーする（openapi.json と同じ取り込み経路）。
final Map<String, Object? Function(Map<String, Object?>)> _parsers = {
  'get__v2_earthquake.json': EarthquakeListResponse.fromJson,
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

  final index = (jsonDecode(indexFile.readAsStringSync()) as List)
      .cast<Map<String, Object?>>();

  for (final entry in index) {
    final key = entry['key']! as String;
    final file = entry['file']! as String;
    final parser = _parsers[file];

    if (parser == null) {
      test(
        'SKIP (no Dart model mapping): $key [$file]',
        () {},
        skip: 'no Dart model mapping for $file',
      );
      continue;
    }

    test('$key [$file] が Freezed モデルでパースできる', () {
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
