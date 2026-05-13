import 'dart:io';

void main(List<String> args) async {
  final externalOpenapiPath = (await File(
    '../../backend/api/api/openapi.json',
  ).resolveSymbolicLinks());

  final packageDir = Directory.current;
  final openapiFile = File('${packageDir.path}/openapi/openapi.json');
  final libDir = Directory('${packageDir.path}/lib/src');

  await _step('lib/src/ を削除', () async {
    if (libDir.existsSync()) {
      libDir.deleteSync(recursive: true);
    }
  });

  if (externalOpenapiPath != null) {
    final src = File(externalOpenapiPath);
    if (!src.existsSync()) {
      stderr.writeln('指定された OpenAPI ファイルが見つかりません: $externalOpenapiPath');
      exit(1);
    }

    print('externalOpenapiPath: ${src.absolute.path}');
    print('openapiFile.path: ${openapiFile.absolute.path}');

    if (openapiFile.absolute.path != src.absolute.path) {
      await _step('外部 OpenAPI ファイルをコピー', () async {
        await openapiFile.create(recursive: true);
        final copied = src.copySync(
          openapiFile.path,
        );
        print('copied: ${copied.path}');
      });
    }
  } else {
    throw Exception('OpenAPI ファイルが指定されていません。-openapiFile を指定してください');
  }

  await _step('swagger_parser でクライアントコードを生成', () async {
    await _run('dart', ['run', 'swagger_parser'], packageDir.path);
  });

  /// swagger_parser が生成した震度 enum のメンバー名を修正する。
  ///
  /// swagger_parser は `+` `-` `!` をセパレータとして除去するため、
  /// `5-` と `5+` が両方 `value5` になり重複エラーが起きる。
  /// ここで以下の置換を行う:
  ///   - `!5-`  (undefined0)  → value5unknown
  ///   - `{N}-` (value{N})    → value{N}minus
  ///   - `{N}+` (value{N})    → value{N}plus
  await _step('震度 enum メンバー名をパッチ', () async {
    final modelsDir = Directory('${packageDir.path}/lib/src/models');

    if (!modelsDir.existsSync()) return;

    final dartFiles = modelsDir.listSync().whereType<File>().where(
      (f) => f.path.endsWith('.dart') && !f.path.endsWith('.g.dart'),
    );

    for (final file in dartFiles) {
      var content = file.readAsStringSync();
      final original = content;

      // `!5-` の自動生成コメントを除去し undefined0 → value5unknown に置換
      content = content.replaceAll(
        RegExp(
          r"  /// Incorrect name has been replaced\. Original name: `!5-`\.\n",
        ),
        '',
      );
      content = content.replaceAll("undefined0('!5-')", "value5unknown('!5-')");

      // value{N}('{N}-') → value{N}minus('{N}-')
      content = content.replaceAllMapped(
        RegExp(r"value(\d+)\('(\d+)-'\)"),
        (m) => "value${m[1]}minus('${m[2]}-')",
      );

      // value{N}('{N}+') → value{N}plus('{N}+')
      content = content.replaceAllMapped(
        RegExp(r"value(\d+)\('(\d+)\+'\)"),
        (m) => "value${m[1]}plus('${m[2]}+')",
      );

      if (content != original) {
        file.writeAsStringSync(content);
        stdout.writeln('  patched: ${file.path}');
      }
    }
  });

  await _step(r'$unknown 文字列補間パッチ', () async {
    await _patchGeneratedFiles(libDir);
  });

  await _step('statuses クエリパラメータの型パッチ', () async {
    _patchStatusesQueryInApiClients(libDir);
  });

  await _step('ParametersApiClient の ParameterDataResponse をパッチ', () async {
    _patchParameterDataResponseInApiClient(libDir);
  });

  await _step('Union 型 fromJson を手動実装で置き換え', () async {
    _patchFeedItemDataUnionFromJson(libDir);
    _patchTargetUnionFromJson(libDir);
    _patchParameterDataResponseUnionFromJson(libDir);
  });

  await _step('build_runner で Freezed / Retrofit コードを生成', () async {
    await _run('dart', [
      'run',
      'build_runner',
      'build',
      '--delete-conflicting-outputs',
    ], packageDir.path);
  });

  stdout.writeln('\n✅ コード生成が完了しました');
}

Future<void> _step(String label, Future<void> Function() action) async {
  stdout.writeln('\n▶ $label ...');
  final sw = Stopwatch()..start();
  await action();
  stdout.writeln(
    '  Done (${(sw.elapsedMilliseconds / 1000).toStringAsFixed(1)}s)',
  );
}

/// swagger_parser が生成するenumの toJson() 内の文字列リテラルで
/// `$unknown` が補間として解釈されるのを修正する。
Future<void> _patchGeneratedFiles(Directory libDir) async {
  final dartFiles = libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));

  for (final file in dartFiles) {
    final original = file.readAsStringSync();
    // Normalize \\$unknown→\$unknown first, then escape bare $unknown (avoids double-escaping)
    var patched = original
        .replaceAll(r'\\$unknown', r'\$unknown')
        .replaceAll(RegExp(r'(?<!\\)\$unknown'), r'\$unknown');
    if (patched != original) {
      file.writeAsStringSync(patched);
      stdout.writeln('  Patched: ${file.path}');
    }
  }
}

const _telegramStatusImport = "import '../models/telegram_status.dart';";

/// [statuses] クエリの扱い。
///
/// バックエンドが出力する OpenAPI では `anyOf`（配列 or 単一 enum）と
/// `default: ["NORMAL"]` の組み合わせになりやすく、swagger_parser が
/// `dynamic` + `const ['NORMAL']`（実質 `List<String>`）を生成することがある。
/// Retrofit 生成コードはそれに対し `statuses.toJson()` を呼び、実行時に
/// NoSuchMethodError になる。
///
/// OpenAPI 本体はリポジトリで手修正しない（バックエンド生成物のため）。
/// ここでクライアント宣言だけを [List<TelegramStatus>] に正規化する。
void _patchStatusesQueryInApiClients(Directory libDir) {
  final clientsDir = Directory('${libDir.path}/clients');
  if (!clientsDir.existsSync()) {
    return;
  }

  for (final entity in clientsDir.listSync()) {
    if (entity is! File || !entity.path.endsWith('_api_client.dart')) {
      continue;
    }

    var content = entity.readAsStringSync();
    final original = content;

    const needle = "@Query('statuses') ";
    if (!content.contains(needle)) {
      continue;
    }

    content = content.replaceAll(
      "@Query('statuses') dynamic statuses = const ['NORMAL']",
      "@Query('statuses') List<TelegramStatus> statuses = const [.normal]",
    );
    content = content.replaceAll(
      "@Query('statuses') dynamic statuses = [NORMAL]",
      "@Query('statuses') List<TelegramStatus> statuses = const [.normal]",
    );
    content = content.replaceAll(
      "@Query('statuses') List<TelegramStatus>? statuses = const ['NORMAL']",
      "@Query('statuses') List<TelegramStatus> statuses = const [.normal]",
    );

    if (content.contains('List<TelegramStatus>') &&
        !content.contains('telegram_status.dart')) {
      content = content.replaceFirst(
        '\n\npart \'',
        '\n\n$_telegramStatusImport\n\npart \'',
      );
    }

    if (content != original) {
      entity.writeAsStringSync(content);
      stdout.writeln('  Patched statuses query: ${entity.path}');
    }
  }
}

/// [parameters_api_client.dart] の `ParameterDataResponse` を
/// `Map<String, Object?>` に置き換える。
///
/// swagger_parser は OpenAPI の anyOf/oneOf discriminator 無しの union 型を
/// `ParameterDataResponse` として生成するが、パラメーター取得エンドポイントは
/// type ごとに異なるスキーマを返すため、アプリ側で type に応じてパースする。
/// そのため Retrofit 型パラメーターは raw map で受け取る。
void _patchParameterDataResponseInApiClient(Directory libDir) {
  final clientFile = File(
    '${libDir.path}/clients/parameters_api_client.dart',
  );
  if (!clientFile.existsSync()) return;

  var content = clientFile.readAsStringSync();
  final original = content;

  content = content.replaceAll(
    "import '../models/parameter_data_response.dart';",
    '',
  );
  content = content.replaceAll(
    'HttpResponse<ParameterDataResponse>',
    'HttpResponse<Map<String, Object?>>',
  );

  if (content != original) {
    clientFile.writeAsStringSync(content);
    stdout.writeln('  Patched: ${clientFile.path}');
  }
}

/// swagger_parser は discriminator の無い oneOf/anyOf に対して
/// `throw UnimplementedError();` 付きの fromJson を生成する。
/// 各 union ファイルに対し、JSON の判別フィールドから variant を
/// 選ぶ実装に書き換える。
///
/// 置換対象は次の形式の factory 本文（`=>` 以降〜セミコロン）:
///   factory <Name>.fromJson(Map<String, Object?> json) =>
///       // TODO: No discriminator ...
///       ... throw UnimplementedError();
void _patchUnionFromJson(
  File file, {
  required String className,
  required String body,
}) {
  if (!file.existsSync()) return;

  final original = file.readAsStringSync();
  final pattern = RegExp(
    r'factory\s+' +
        RegExp.escape(className) +
        r'\.fromJson\(Map<String, Object\?> json\)\s*=>'
        r'[\s\S]*?throw UnimplementedError\(\);',
  );

  if (!pattern.hasMatch(original)) {
    stdout.writeln('  Skip (no fromJson stub): ${file.path}');
    return;
  }

  final replacement =
      'factory $className.fromJson(Map<String, Object?> json) =>\n      $body;';
  final patched = original.replaceFirst(pattern, replacement);

  if (patched != original) {
    file.writeAsStringSync(patched);
    stdout.writeln('  Patched fromJson: ${file.path}');
  }
}

/// FeedItem.data の `type` const 値で variant を判別する。
///
///   EARTHQUAKE_NOTICE       → variant1
///   EARTHQUAKE_EXPLANATION  → variant2
///   EARTHQUAKE_COUNTS       → variant3
///   EARTHQUAKE_NANKAI       → variant4
///   APP_UPDATE              → variant5
///   INCIDENT                → variant6
///   DEVELOPER_MESSAGE       → variant7
void _patchFeedItemDataUnionFromJson(Directory libDir) {
  final file = File('${libDir.path}/models/feed_item_data_union.dart');
  const body = '''switch (json['type']) {
        'EARTHQUAKE_NOTICE' => FeedItemDataUnionVariant1.fromJson(json),
        'EARTHQUAKE_EXPLANATION' => FeedItemDataUnionVariant2.fromJson(json),
        'EARTHQUAKE_COUNTS' => FeedItemDataUnionVariant3.fromJson(json),
        'EARTHQUAKE_NANKAI' => FeedItemDataUnionVariant4.fromJson(json),
        'APP_UPDATE' => FeedItemDataUnionVariant5.fromJson(json),
        'INCIDENT' => FeedItemDataUnionVariant6.fromJson(json),
        'DEVELOPER_MESSAGE' => FeedItemDataUnionVariant7.fromJson(json),
        final value => throw ArgumentError.value(
          value,
          'type',
          'Unknown FeedItemDataUnion type',
        ),
      }''';
  _patchUnionFromJson(file, className: 'FeedItemDataUnion', body: body);
}

/// Target の `type` const 値で variant を判別する。
///
///   device_id            → variant1 (deviceId)
///   push_to_start_token  → variant2 (token + environment)
void _patchTargetUnionFromJson(Directory libDir) {
  final file = File('${libDir.path}/models/target_union.dart');
  const body = '''switch (json['type']) {
        'device_id' => TargetUnionVariant1.fromJson(json),
        'push_to_start_token' => TargetUnionVariant2.fromJson(json),
        final value => throw ArgumentError.value(
          value,
          'type',
          'Unknown TargetUnion type',
        ),
      }''';
  _patchUnionFromJson(file, className: 'TargetUnion', body: body);
}

/// metadata.type で variant を判別する。
///
///   jma_code_table              → jmaCodeTableParameter
///   kyoshin_observation_points  → kyoshinObservationPointsParameter
///   earthquake_stations         → earthquakeStationsParameter
///   tsunami_stations            → tsunamiStationsParameter
///
/// `prefectures` フィールドが earthquake/tsunami variant で重複するため、
/// ユニークフィールドではなく metadata.type を必ず参照する。
void _patchParameterDataResponseUnionFromJson(Directory libDir) {
  final file = File('${libDir.path}/models/parameter_data_response_union.dart');
  const body =
      '''switch ((json['metadata'] as Map<String, Object?>?)?['type']) {
        'jma_code_table' =>
          ParameterDataResponseUnionJmaCodeTableParameter.fromJson(json),
        'kyoshin_observation_points' =>
          ParameterDataResponseUnionKyoshinObservationPointsParameter.fromJson(
            json,
          ),
        'earthquake_stations' =>
          ParameterDataResponseUnionEarthquakeStationsParameter.fromJson(json),
        'tsunami_stations' =>
          ParameterDataResponseUnionTsunamiStationsParameter.fromJson(json),
        final value => throw ArgumentError.value(
          value,
          'metadata.type',
          'Unknown ParameterDataResponseUnion type',
        ),
      }''';
  _patchUnionFromJson(file, className: 'ParameterDataResponseUnion', body: body);
}

Future<void> _run(String exe, List<String> args, String cwd) async {
  final process = await Process.start(exe, args, workingDirectory: cwd);
  process.stdout.listen(stdout.add);
  process.stderr.listen(stderr.add);
  final code = await process.exitCode;
  if (code != 0) {
    exit(code);
  }
}
