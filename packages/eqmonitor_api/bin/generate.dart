import 'dart:convert';
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

  await _step('OpenAPI スキーマをパッチ (dynamic 排除)', () async {
    _patchOpenapiSchema(openapiFile);
  });

  await _step('swagger_parser でクライアントコードを生成', () async {
    await _run('dart', ['run', 'swagger_parser'], packageDir.path);
  });

  /// swagger_parser が生成した震度 enum のメンバー名を修正する。
  ///
  /// swagger_parser は `+` `-` `!` をセパレータとして除去するため、
  /// `5-` と `5+` が両方 `value5` になり重複エラーが起きる。
  /// ここで以下の置換を行う:
  ///   - `!5-`  (undefined0)  → value5unknown
  ///   - `!6-`  (undefined1)  → value6unknown
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

      // `!6-` の自動生成コメントを除去し undefined1 → value6unknown に置換
      content = content.replaceAll(
        RegExp(
          r"  /// Incorrect name has been replaced\. Original name: `!6-`\.\n",
        ),
        '',
      );
      content = content.replaceAll("undefined1('!6-')", "value6unknown('!6-')");

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

  await _step('値のみ union を enum に変換', () async {
    _patchValueOnlyUnionsToEnum(libDir, openapiFile);
  });

  await _step(r'$unknown 文字列補間パッチ', () async {
    await _patchGeneratedFiles(libDir);
  });

  await _step('statuses クエリパラメータの型パッチ', () async {
    _patchStatusesQueryInApiClients(libDir);
  });

  await _step('anyOf 由来の dynamic パスパラメータを String にパッチ', () async {
    _patchDynamicPathParameters(libDir);
  });

  await _step('anyOf 由来の dynamic クエリパラメータを String? にパッチ', () async {
    _patchDynamicQueryParameters(libDir);
  });

  await _step('ParametersApiClient の ParameterDataResponse をパッチ', () async {
    _patchParameterDataResponseInApiClient(libDir);
  });

  await _step('EEW settings request の nullable PATCH をパッチ', () async {
    _patchEewSettingsRequestNullablePatch(libDir);
  });

  await _step('APNs environment enum の不要 cast をパッチ', () async {
    _patchApnsEnvironmentEnum(libDir);
  });

  await _step('Union 型 fromJson を手動実装で置き換え', () async {
    _patchFeedItemDataUnionFromJson(libDir);
    _patchTargetUnionFromJson(libDir);
    _patchParameterDataResponseUnionFromJson(libDir);
    _patchTelegramBodyUnionFromJson(libDir);
  });

  await _step('TelegramBody 参照を TelegramBodyUnion に修正', () async {
    _patchTelegramBodyReference(libDir);
  });

  await _step('DeviceLocale デフォルト値パッチ', () async {
    _patchDeviceLocaleDefault(libDir);
  });

  await _step('originTime クエリパラメータを DateTime → String にパッチ', () async {
    _patchOriginTimeDateTimeToString(libDir);
  });

  await _step('生成ファイルから type=lint を除去（lint 検出を有効化）', () async {
    _stripTypeLintFromGeneratedHeaders(libDir);
  });

  await _step('build_runner で Freezed / Retrofit コードを生成', () async {
    await _run('dart', [
      'run',
      'build_runner',
      'build',
      '--delete-conflicting-outputs',
    ], packageDir.path);
  });

  await _step('残存 dynamic の検出', () async {
    _validateNoDynamic(libDir);
  });

  /// 契約 drift テスト用の fixtures を backend submodule からコピーする。
  ///
  /// backend 側 `pnpm generate:fixtures` が `api/api-stub/generated/contract-fixtures/`
  /// に出力した JSON（decision論的・Valibot 検証済みの形）を、テストが読む
  /// `test/fixtures/contract/` へ取り込む。openapi.json と同じ「submodule 生成物を
  /// メインリポに取り込む」流儀（app CI は submodule を checkout しないため必須）。
  await _step('契約 fixtures を submodule からコピー', () async {
    final srcDir = Directory(
      '../../backend/api/api-stub/generated/contract-fixtures',
    );
    final dstDir = Directory('${packageDir.path}/test/fixtures/contract');
    if (!srcDir.existsSync()) {
      stderr.writeln('  contract-fixtures が見つかりません: ${srcDir.path}');
      return;
    }
    if (dstDir.existsSync()) {
      dstDir.deleteSync(recursive: true);
    }
    dstDir.createSync(recursive: true);
    var count = 0;
    for (final f in srcDir.listSync().whereType<File>()) {
      if (!f.path.endsWith('.json')) {
        continue;
      }
      final name = f.uri.pathSegments.last;
      f.copySync('${dstDir.path}/$name');
      count++;
    }
    stdout.writeln('  copied $count fixtures → ${dstDir.path}');
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
///
/// 既にエスケープ済みの `\$unknown` には触らないように、`$` の直前が
/// バックスラッシュでない場合のみ置換する。これにより再実行しても
/// バックスラッシュが増えない（冪等）。
Future<void> _patchGeneratedFiles(Directory libDir) async {
  final dartFiles = libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));

  final pattern = RegExp(r'(?<!\\)\$unknown');
  for (final file in dartFiles) {
    final original = file.readAsStringSync();
    final patched = original.replaceAll(pattern, r'\$unknown');
    if (patched != original) {
      file.writeAsStringSync(patched);
      stdout.writeln('  Patched: ${file.path}');
    }
  }
}

/// swagger_parser は `anyOf` / `oneOf` のメンバーがすべて `const`（値のみ）の
/// union を、メンバーの無い空の Freezed クラスとして生成してしまう。
/// 例: `TsunamiWarningKind`（`anyOf: [{const: "MAJOR_WARNING"}, ...]`）。
/// これは実質使用不能なので enum として生成し直す。
///
/// OpenAPI 本体を直接読み、値のみ union のスキーマを検出して、
/// swagger_parser が `enum:` から生成するのと同じ形
/// （`@JsonEnum()` + `@JsonValue` + 手書き `toJson`）の enum 定義で上書きする。
/// 各 const の `description` はメンバーの doc コメントにする。
void _patchValueOnlyUnionsToEnum(Directory libDir, File openapiFile) {
  if (!openapiFile.existsSync()) return;
  final modelsDir = Directory('${libDir.path}/models');
  if (!modelsDir.existsSync()) return;

  final openapi =
      jsonDecode(openapiFile.readAsStringSync()) as Map<String, Object?>;
  final components = openapi['components'] as Map<String, Object?>?;
  final schemas = components?['schemas'] as Map<String, Object?>?;
  if (schemas == null) return;

  for (final entry in schemas.entries) {
    final name = entry.key;
    final schema = entry.value;
    if (schema is! Map<String, Object?>) continue;

    final members = schema['anyOf'] ?? schema['oneOf'];
    if (members is! List || members.isEmpty) continue;

    // すべてのメンバーが文字列の const（値のみ）であることを要求する。
    final values = <String>[];
    final descriptions = <String?>[];
    var valueOnly = true;
    for (final m in members) {
      if (m is! Map<String, Object?> || m['const'] is! String) {
        valueOnly = false;
        break;
      }
      values.add(m['const']! as String);
      descriptions.add(m['description'] as String?);
    }
    if (!valueOnly) continue;

    final file = File('${modelsDir.path}/${_toSnakeCase(name)}.dart');
    if (!file.existsSync()) continue;

    file.writeAsStringSync(
      _buildEnumSource(
        className: name,
        values: values,
        descriptions: descriptions,
        schemaDescription: schema['description'] as String?,
      ),
    );
    stdout.writeln('  Patched value-only union → enum: ${file.path}');
  }
}

/// `TsunamiWarningKind` → `tsunami_warning_kind`。
/// swagger_parser のファイル命名規則に合わせる。
String _toSnakeCase(String pascal) {
  final buffer = StringBuffer();
  for (var i = 0; i < pascal.length; i++) {
    final ch = pascal[i];
    final isUpper = ch.toUpperCase() == ch && ch.toLowerCase() != ch;
    if (isUpper && i > 0) buffer.write('_');
    buffer.write(ch.toLowerCase());
  }
  return buffer.toString();
}

/// `MAJOR_WARNING` → `majorWarning`、`VXSE45_FORECAST` → `vxse45Forecast`。
/// swagger_parser の enum メンバー命名規則に合わせる。
String _toEnumMemberName(String value) {
  final parts = value
      .split(RegExp(r'[_\s-]+'))
      .where((p) => p.isNotEmpty)
      .toList();
  if (parts.isEmpty) return value.toLowerCase();
  final first = parts.first.toLowerCase();
  final rest = parts.skip(1).map((p) {
    final lower = p.toLowerCase();
    return lower[0].toUpperCase() + lower.substring(1);
  }).join();
  return first + rest;
}

String _buildEnumSource({
  required String className,
  required List<String> values,
  required List<String?> descriptions,
  String? schemaDescription,
}) {
  final buffer = StringBuffer()
    ..writeln('// coverage:ignore-file')
    ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND')
    ..writeln(
      '// ignore_for_file: type=lint, unused_import, '
      'invalid_annotation_target, unnecessary_import',
    )
    ..writeln()
    ..writeln("import 'package:freezed_annotation/freezed_annotation.dart';")
    ..writeln();

  if (schemaDescription != null && schemaDescription.isNotEmpty) {
    for (final line in schemaDescription.split('\n')) {
      buffer.writeln('/// $line');
    }
  }
  buffer
    ..writeln('@JsonEnum()')
    ..writeln('enum $className {');

  for (var i = 0; i < values.length; i++) {
    final value = values[i];
    final description = descriptions[i];
    if (description != null && description.isNotEmpty) {
      for (final line in description.split('\n')) {
        buffer.writeln('  /// $line');
      }
    }
    final terminator = i == values.length - 1 ? ';' : ',';
    buffer
      ..writeln("  @JsonValue('$value')")
      ..writeln("  ${_toEnumMemberName(value)}('$value')$terminator");
  }

  // `$unknown` は後段の `_patchGeneratedFiles` で `\$unknown` にエスケープされる。
  buffer
    ..writeln()
    ..writeln('  const $className(this.json);')
    ..writeln()
    ..writeln('  final String? json;')
    ..writeln('  String toJson() {')
    ..writeln('    final value = json;')
    ..writeln('    if (value == null) {')
    ..writeln(
      "      throw StateError('Cannot convert enum value with null JSON "
      "representation to String. '",
    )
    ..writeln(
      "          'This usually happens for \$unknown or @JsonValue(null) "
      "entries.');",
    )
    ..writeln('    }')
    ..writeln('    return value as String;')
    ..writeln('  }')
    ..writeln()
    ..writeln('  @override')
    ..writeln('  String toString() => json?.toString() ?? super.toString();')
    ..writeln('}');

  return buffer.toString();
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

/// anyOf で複数の基本型（配列+単一値 等）を持つクエリパラメータは
/// swagger_parser が `dynamic` を出力し、Retrofit が `.toJson()` を生成する。
/// null 渡し時に NoSuchMethodError になるため、正しい型に正規化する。
///
/// パラメータごとに本来の型を指定する。未知の dynamic は `String?` にフォールバック。
void _patchDynamicQueryParameters(Directory libDir) {
  final clientsDir = Directory('${libDir.path}/clients');
  if (!clientsDir.existsSync()) return;

  const overrides = {
    'epicenterCodes': 'List<String>?',
    'telegramTypes': 'List<EarthquakeTelegramType>?',
  };

  const requiredImports = {
    'EarthquakeTelegramType':
        "import '../models/earthquake_telegram_type.dart';",
  };

  final pattern = RegExp(r"@Query\('(\w+)'\)\s+dynamic\s+(\w+)(?=[,)])");

  for (final entity in clientsDir.listSync()) {
    if (entity is! File || !entity.path.endsWith('_api_client.dart')) continue;

    var content = entity.readAsStringSync();
    final original = content;

    content = content.replaceAllMapped(pattern, (m) {
      final queryName = m[1];
      final paramName = m[2];
      final dartType = overrides[paramName] ?? 'String?';
      return "@Query('$queryName') $dartType $paramName";
    });

    for (final entry in requiredImports.entries) {
      if (content.contains(entry.key) && !content.contains(entry.value)) {
        content = content.replaceFirst(
          "\npart '",
          '\n${entry.value}\n\npart \'',
        );
      }
    }

    if (content != original) {
      entity.writeAsStringSync(content);
      stdout.writeln('  Patched dynamic query params: ${entity.path}');
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

void _patchEewSettingsRequestNullablePatch(Directory libDir) {
  final file = File('${libDir.path}/models/eew_settings_request.dart');
  if (!file.existsSync()) {
    return;
  }
  final content = file.readAsStringSync();
  final patched = content.replaceAll(
    "@JsonKey(includeIfNull: false,name: 'notification_tiers')",
    "@JsonKey(name: 'notification_tiers')",
  );
  if (patched != content) {
    file.writeAsStringSync(patched);
    stdout.writeln('  patched: ${file.path}');
  }
}

void _patchApnsEnvironmentEnum(Directory libDir) {
  final file = File('${libDir.path}/models/apns_environment.dart');
  if (!file.existsSync()) {
    return;
  }
  final content = file.readAsStringSync();
  final patched = content.replaceAll(
    'return value as String;',
    'return value;',
  );
  if (patched != content) {
    file.writeAsStringSync(patched);
    stdout.writeln('  patched: ${file.path}');
  }
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
  _patchUnionFromJson(
    file,
    className: 'ParameterDataResponseUnion',
    body: body,
  );
}

/// swagger_parser が `@Default(ja)` のようにenum値をリテラルなしで生成する問題を修正。
void _patchDeviceLocaleDefault(Directory libDir) {
  final modelsDir = Directory('${libDir.path}/models');
  if (!modelsDir.existsSync()) return;

  for (final entity in modelsDir.listSync()) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    if (entity.path.endsWith('.g.dart') ||
        entity.path.endsWith('.freezed.dart')) {
      continue;
    }

    var content = entity.readAsStringSync();
    final original = content;

    content = content.replaceAll(
      "@Default(ja)\n    dynamic locale,",
      "@Default('ja')\n    String? locale,",
    );

    if (content != original) {
      entity.writeAsStringSync(content);
      stdout.writeln('  Patched locale default: ${entity.path}');
    }
  }
}

/// TelegramBodyUnion の `type` 値で variant を判別する。
void _patchTelegramBodyUnionFromJson(Directory libDir) {
  final file = File('${libDir.path}/models/telegram_body_union.dart');
  const body = '''switch (json['type']) {
        'EARTHQUAKE' =>
          TelegramBodyUnionEarthquakeTelegramBody.fromJson(json),
        'EEW' => TelegramBodyUnionEewTelegramBody.fromJson(json),
        'EARTHQUAKE_NOTICE' =>
          TelegramBodyUnionEarthquakeNoticeTelegramBody.fromJson(json),
        'EARTHQUAKE_EXPLANATION' =>
          TelegramBodyUnionEarthquakeExplanationTelegramBody.fromJson(json),
        'EARTHQUAKE_COUNTS' =>
          TelegramBodyUnionEarthquakeCountsTelegramBody.fromJson(json),
        'EARTHQUAKE_NANKAI' =>
          TelegramBodyUnionEarthquakeNankaiTelegramBody.fromJson(json),
        final value => throw ArgumentError.value(
          value,
          'type',
          'Unknown TelegramBodyUnion type',
        ),
      }''';
  _patchUnionFromJson(file, className: 'TelegramBodyUnion', body: body);
}

/// swagger_parser は `TelegramBody` (oneOf ref) を `TelegramBodyUnion`
/// というクラス名で `telegram_body_union.dart` に生成するが、
/// `TelegramDetail` 等の参照先は `TelegramBody` / `telegram_body.dart` のまま。
/// import パスとクラス名を統一する。
void _patchTelegramBodyReference(Directory libDir) {
  final modelsDir = Directory('${libDir.path}/models');
  if (!modelsDir.existsSync()) return;

  for (final entity in modelsDir.listSync()) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    // skip generated files
    if (entity.path.endsWith('.g.dart') ||
        entity.path.endsWith('.freezed.dart')) {
      continue;
    }

    var content = entity.readAsStringSync();
    final original = content;

    content = content.replaceAll(
      "import 'telegram_body.dart';",
      "import 'telegram_body_union.dart';",
    );
    // 単独の `TelegramBody` 参照のみ `TelegramBodyUnion` に置換する。
    // `EarthquakeTelegramBody` / `TsunamiTelegramBody` / 既に `TelegramBodyUnion`
    // のものは単語境界で除外される（nullable / 非 nullable いずれも対象）。
    content = content.replaceAll(
      RegExp(r'\bTelegramBody\b'),
      'TelegramBodyUnion',
    );

    if (content != original) {
      entity.writeAsStringSync(content);
      stdout.writeln('  Patched TelegramBody ref: ${entity.path}');
    }
  }
}

/// swagger_parser は OpenAPI の `format: "date"` も `DateTime` にマッピングする。
/// originTimeGte / originTimeLte は `yyyy-MM-dd` 文字列として送るため
/// `String?` に置き換える。
void _patchOriginTimeDateTimeToString(Directory libDir) {
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

    content = content.replaceAll(
      "@Query('originTimeGte') DateTime? originTimeGte",
      "@Query('originTimeGte') String? originTimeGte",
    );
    content = content.replaceAll(
      "@Query('originTimeLte') DateTime? originTimeLte",
      "@Query('originTimeLte') String? originTimeLte",
    );

    if (content != original) {
      entity.writeAsStringSync(content);
      stdout.writeln('  Patched: ${entity.path}');
    }
  }
}

/// swagger_parser が `anyOf` のパスパラメータを `dynamic` として生成する問題を修正。
/// `@Path('xxx') required dynamic yyy` → `@Path('xxx') required String yyy`。
void _patchDynamicPathParameters(Directory libDir) {
  final clientsDir = Directory('${libDir.path}/clients');
  if (!clientsDir.existsSync()) return;

  final pattern = RegExp(r"@Path\('(\w+)'\)\s+required\s+dynamic\s+(\w+)");

  for (final entity in clientsDir.listSync()) {
    if (entity is! File || !entity.path.endsWith('_api_client.dart')) continue;

    var content = entity.readAsStringSync();
    final original = content;

    content = content.replaceAllMapped(pattern, (m) {
      final pathName = m[1];
      final paramName = m[2];
      return "@Path('$pathName') required String $paramName";
    });

    if (content != original) {
      entity.writeAsStringSync(content);
      stdout.writeln('  Patched dynamic path params: ${entity.path}');
    }
  }
}

/// swagger_parser が生成する `// ignore_for_file: type=lint, ...` から
/// `type=lint` を除去する。これにより `avoid_annotating_with_dynamic` 等の
/// lint ルールがコード生成結果に対して有効になる。
///
/// `.g.dart` / `.freezed.dart` はビルドランナー生成で独自に `type=lint` を
/// 持つため対象外。
void _stripTypeLintFromGeneratedHeaders(Directory libDir) {
  final dartFiles = libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where(
        (f) =>
            f.path.endsWith('.dart') &&
            !f.path.endsWith('.g.dart') &&
            !f.path.endsWith('.freezed.dart'),
      );

  for (final file in dartFiles) {
    var content = file.readAsStringSync();
    final original = content;

    content = content.replaceAll(
      RegExp(r'type=lint,?\s*'),
      '',
    );
    // 末尾にカンマ+空白だけ残った場合を整理
    content = content.replaceAll(
      RegExp(r'// ignore_for_file:\s*\n'),
      '',
    );

    if (content != original) {
      file.writeAsStringSync(content);
      stdout.writeln('  Stripped type=lint: ${file.path}');
    }
  }
}

/// 生成後に `*.dart`（`*.g.dart`, `*.freezed.dart` を除く）に残った
/// `dynamic` 型注釈を検出しビルドを失敗させる。
void _validateNoDynamic(Directory libDir) {
  final pattern = RegExp(r'\bdynamic\b');
  final dartFiles = libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where(
        (f) =>
            f.path.endsWith('.dart') &&
            !f.path.endsWith('.g.dart') &&
            !f.path.endsWith('.freezed.dart'),
      );

  var count = 0;
  for (final file in dartFiles) {
    final lines = file.readAsLinesSync();
    for (var i = 0; i < lines.length; i++) {
      if (pattern.hasMatch(lines[i])) {
        stderr.writeln(
          '  ⚠️  dynamic detected: ${file.path}:${i + 1}: ${lines[i].trim()}',
        );
        count++;
      }
    }
  }
  if (count > 0) {
    stderr.writeln('  ❌ $count dynamic annotation(s) remaining — aborting');
    exit(1);
  }
}

/// swagger_parser が `dynamic` を生成するスキーマパターンを修正する。
///
/// swagger_parser 実行前に `openapi/openapi.json` を書き換え、
/// Dart コードに `dynamic` が出現しないようにする。
///
/// 対象パターン:
///   1. `{"const": <value>}` に `type` が無い → 型を補完
///   2. `anyOf/oneOf` の全メンバーが文字列 const →
///      `{"type":"string","enum":[...]}` へ集約
///   3. `{"type":"null"}` 単独 (nullable 以外) → `{"type":"string","nullable":true}`
///   4. `Telegram.body` が空 → `$ref: TelegramBody` へ
void _patchOpenapiSchema(File openapiFile) {
  final content = openapiFile.readAsStringSync();
  final openapi = jsonDecode(content) as Map<String, Object?>;
  var patchCount = 0;

  void walkAndPatch(Object? node) {
    if (node is Map<String, Object?>) {
      // Pattern 4: body プロパティを nullable $ref TelegramBody に
      final props = node['properties'];
      if (props is Map<String, Object?> && props.containsKey('body')) {
        final body = props['body'];
        if (body is Map<String, Object?>) {
          final needsPatch = !body.containsKey('type') &&
              !body.containsKey('anyOf') &&
              !body.containsKey('oneOf') &&
              !body.containsKey('allOf');
          final isDirectRef =
              body[r'$ref'] == '#/components/schemas/TelegramBody';
          if (needsPatch && !isDirectRef) {
            // 空スキーマ → nullable $ref
            props['body'] = <String, Object?>{
              'nullable': true,
              'allOf': [
                {r'$ref': '#/components/schemas/TelegramBody'},
              ],
            };
            patchCount++;
            stdout.writeln('  Patched: body (empty) → nullable \$ref');
          } else if (isDirectRef && body['nullable'] != true) {
            // 直参照を nullable 化
            props['body'] = <String, Object?>{
              'nullable': true,
              'allOf': [
                {r'$ref': '#/components/schemas/TelegramBody'},
              ],
            };
            patchCount++;
            stdout.writeln('  Patched: body (\$ref) → nullable \$ref');
          }
        }
      }

      for (final entry in node.entries.toList()) {
        final value = entry.value;

        // Pattern 1: const without type
        if (value is Map<String, Object?> &&
            value.containsKey('const') &&
            !value.containsKey('type') &&
            !value.containsKey(r'$ref')) {
          final constVal = value['const'];
          String? typeStr;
          if (constVal is String) {
            typeStr = 'string';
          } else if (constVal is bool) {
            typeStr = 'boolean';
          } else if (constVal is int) {
            typeStr = 'integer';
          } else if (constVal is double) {
            typeStr = 'number';
          }
          if (typeStr != null) {
            value['type'] = typeStr;
            patchCount++;
          }
        }

        // Pattern 2: anyOf/oneOf all-string-const → enum
        if (value is Map<String, Object?>) {
          for (final unionKey in ['anyOf', 'oneOf']) {
            final members = value[unionKey];
            if (members is! List || members.isEmpty) continue;
            final allStringConst = members.every(
              (m) =>
                  m is Map<String, Object?> &&
                  m['const'] is String &&
                  !m.containsKey(r'$ref'),
            );
            if (!allStringConst) continue;

            // 全メンバーがnullable無しの文字列constだけの場合
            // nullable member ({type:null}) を探す
            final hasNullMember = members.any(
              (m) => m is Map<String, Object?> && m['type'] == 'null',
            );
            if (hasNullMember) continue;

            // anyOf/oneOf を削除し type:string に置換
            // enum は付けない（swagger_parser が自動命名で
            // 既存スキーマ名と衝突するのを防ぐ）
            value.remove(unionKey);
            value['type'] = 'string';
            patchCount++;
          }
        }

        // Pattern 3: standalone {type: "null"} → nullable string
        if (value is Map<String, Object?> &&
            value['type'] == 'null' &&
            value.length == 1) {
          value['type'] = 'string';
          value['nullable'] = true;
          patchCount++;
        }

        // Pattern 5: anyOf/oneOf mixing primitive types (e.g. number|string)
        // → flatten to string (swagger_parser emits dynamic for mixed types)
        if (value is Map<String, Object?>) {
          for (final unionKey in ['anyOf', 'oneOf']) {
            final members = value[unionKey];
            if (members is! List || members.isEmpty) continue;
            final primitiveTypes = <String>{};
            var allPrimitive = true;
            for (final m in members) {
              if (m is Map<String, Object?> && m.containsKey('type')) {
                final t = m['type'] as String;
                if (t == 'null') continue;
                primitiveTypes.add(t);
              } else if (m is Map<String, Object?> &&
                  (m.containsKey('anyOf') || m.containsKey('oneOf'))) {
                // nested anyOf — flatten
                final inner =
                    (m['anyOf'] ?? m['oneOf']) as List<Object?>? ?? [];
                for (final im in inner) {
                  if (im is Map<String, Object?> && im.containsKey('type')) {
                    final t = im['type'] as String;
                    if (t != 'null') primitiveTypes.add(t);
                  } else {
                    allPrimitive = false;
                  }
                }
              } else {
                allPrimitive = false;
              }
            }
            if (!allPrimitive || primitiveTypes.length < 2) continue;
            // mixed primitives → string
            final isNullable = value['nullable'] == true ||
                members.any(
                  (m) => m is Map<String, Object?> && m['type'] == 'null',
                );
            value.remove(unionKey);
            value['type'] = 'string';
            if (isNullable) value['nullable'] = true;
            patchCount++;
          }
        }

        // Recurse
        walkAndPatch(value);
      }
    } else if (node is List) {
      for (final item in node) {
        walkAndPatch(item);
      }
    }
  }

  walkAndPatch(openapi);

  final encoder = JsonEncoder.withIndent('  ');
  openapiFile.writeAsStringSync(encoder.convert(openapi));
  stdout.writeln('  $patchCount patches applied');
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
