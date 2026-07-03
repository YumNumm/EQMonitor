import 'dart:convert';
import 'dart:io';

void main(List<String> args) async {
  final externalOpenapiPath = await File(
    '../../backend/api/api/openapi.json',
  ).resolveSymbolicLinks();

  final packageDir = Directory.current;
  final openapiFile = File('${packageDir.path}/openapi/openapi.json');
  final libDir = Directory('${packageDir.path}/lib/src');

  await _step('lib/src/ を削除', () async {
    if (libDir.existsSync()) {
      libDir.deleteSync(recursive: true);
    }
  });

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

  await _step('FeedEarthquakeNankaiData.telegramType をパッチ', () async {
    _patchNankaiTelegramType(openapiFile);
  });

  await _step('OpenAPI の const プロパティを型付きに変換', () async {
    _patchConstPropertiesToTyped(openapiFile);
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

    if (!modelsDir.existsSync()) {
      return;
    }

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

  await _step('FeedItemData 参照を FeedItemDataUnion に修正', () async {
    _patchFeedItemDataReference(libDir);
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

  await _step('残存 dynamic → 正しい型にパッチ', () async {
    _patchRemainingDynamic(libDir);
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
  if (!openapiFile.existsSync()) {
    return;
  }
  final modelsDir = Directory('${libDir.path}/models');
  if (!modelsDir.existsSync()) {
    return;
  }

  final openapi =
      jsonDecode(openapiFile.readAsStringSync()) as Map<String, Object?>;
  final components = openapi['components'] as Map<String, Object?>?;
  final schemas = components?['schemas'] as Map<String, Object?>?;
  if (schemas == null) {
    return;
  }

  for (final entry in schemas.entries) {
    final name = entry.key;
    final schema = entry.value;
    if (schema is! Map<String, Object?>) {
      continue;
    }

    final members = schema['anyOf'] ?? schema['oneOf'];
    if (members is! List || members.isEmpty) {
      continue;
    }

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
    if (!valueOnly) {
      continue;
    }

    final file = File('${modelsDir.path}/${_toSnakeCase(name)}.dart');
    if (!file.existsSync()) {
      continue;
    }

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
    if (isUpper && i > 0) {
      buffer.write('_');
    }
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
  if (parts.isEmpty) {
    return value.toLowerCase();
  }
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
        "\n\npart '",
        "\n\n$_telegramStatusImport\n\npart '",
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
  if (!clientsDir.existsSync()) {
    return;
  }

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
    if (entity is! File || !entity.path.endsWith('_api_client.dart')) {
      continue;
    }

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
          "\n${entry.value}\n\npart '",
        );
      }
    }

    if (content != original) {
      entity.writeAsStringSync(content);
      stdout.writeln('  Patched dynamic query params: ${entity.path}');
    }
  }
}

/// `parameters_api_client.dart` の `ParameterDataResponse` を
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
  if (!clientFile.existsSync()) {
    return;
  }

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
  if (!file.existsSync()) {
    return;
  }

  final original = file.readAsStringSync();
  final pattern = RegExp(
    r'factory\s+' +
        // ignore: prefer_interpolation_to_compose_strings
        RegExp.escape(className) +
        // ignore: missing_whitespace_between_adjacent_strings
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
void _patchFeedItemDataUnionFromJson(Directory libDir) {
  final file = File('${libDir.path}/models/feed_item_data_union.dart');
  const body = '''
switch (json['type']) {
        'EARTHQUAKE_NOTICE' =>
          FeedItemDataUnionFeedEarthquakeNoticeData.fromJson(json),
        'EARTHQUAKE_EXPLANATION' =>
          FeedItemDataUnionFeedEarthquakeExplanationData.fromJson(json),
        'EARTHQUAKE_COUNTS' =>
          FeedItemDataUnionFeedEarthquakeCountsData.fromJson(json),
        'EARTHQUAKE_NANKAI' =>
          FeedItemDataUnionFeedEarthquakeNankaiData.fromJson(json),
        'APP_UPDATE' =>
          FeedItemDataUnionFeedAppUpdateData.fromJson(json),
        'INCIDENT' =>
          FeedItemDataUnionFeedIncidentData.fromJson(json),
        'DEVELOPER_MESSAGE' =>
          FeedItemDataUnionFeedDeveloperMessageData.fromJson(json),
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
  const body = '''
switch (json['type']) {
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
  const body = '''
switch ((json['metadata'] as Map<String, Object?>?)?['type']) {
        'JMA_CODE_TABLE' =>
          ParameterDataResponseUnionJmaCodeTableParameter.fromJson(json),
        'KYOSHIN_OBSERVATION_POINTS' =>
          ParameterDataResponseUnionKyoshinObservationPointsParameter.fromJson(
            json,
          ),
        'EARTHQUAKE_STATIONS' =>
          ParameterDataResponseUnionEarthquakeStationsParameter.fromJson(json),
        'TSUNAMI_STATIONS' =>
          ParameterDataResponseUnionTsunamiStationsParameter.fromJson(json),
        'SHINDO_DB_STATIONS' =>
          ParameterDataResponseUnionShindoDbStationsParameter.fromJson(json),
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
  if (!modelsDir.existsSync()) {
    return;
  }

  for (final entity in modelsDir.listSync()) {
    if (entity is! File || !entity.path.endsWith('.dart')) {
      continue;
    }
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
  const body = '''
switch (json['type']) {
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
  if (!modelsDir.existsSync()) {
    return;
  }

  for (final entity in modelsDir.listSync()) {
    if (entity is! File || !entity.path.endsWith('.dart')) {
      continue;
    }
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

/// swagger_parser は `FeedItemData` (anyOf ref) を `FeedItemDataUnion`
/// というクラス名で `feed_item_data_union.dart` に生成するが、
/// `FeedDetailResponse` 等の参照先は `FeedItemData` / `feed_item_data.dart` のまま。
/// import パスとクラス名を統一する。
void _patchFeedItemDataReference(Directory libDir) {
  final modelsDir = Directory('${libDir.path}/models');
  if (!modelsDir.existsSync()) {
    return;
  }

  for (final entity in modelsDir.listSync()) {
    if (entity is! File || !entity.path.endsWith('.dart')) {
      continue;
    }
    if (entity.path.endsWith('.g.dart') ||
        entity.path.endsWith('.freezed.dart')) {
      continue;
    }

    var content = entity.readAsStringSync();
    final original = content;

    content = content.replaceAll(
      "import 'feed_item_data.dart';",
      "import 'feed_item_data_union.dart';",
    );
    // 単独の `FeedItemData` 参照のみ置換する。`FeedItemDataUnion` や
    // `FeedItemDataUnionFeedAppUpdateData` 等は単語境界で除外される。
    content = content.replaceAll(
      RegExp(r'\bFeedItemData\b'),
      'FeedItemDataUnion',
    );

    if (content != original) {
      entity.writeAsStringSync(content);
      stdout.writeln('  Patched FeedItemData ref: ${entity.path}');
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
  if (!clientsDir.existsSync()) {
    return;
  }

  final pattern = RegExp(r"@Path\('(\w+)'\)\s+required\s+dynamic\s+(\w+)");

  for (final entity in clientsDir.listSync()) {
    if (entity is! File || !entity.path.endsWith('_api_client.dart')) {
      continue;
    }

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
/// `dynamic` 型注釈を検出して警告する。
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
    stderr.writeln('  ⚠️  $count dynamic annotation(s) remaining');
  }
}

/// swagger_parser が空スキーマ `{}` や `{nullable: true}` から生成した
/// `dynamic` を Valibot 定義に基づく正しい型に置き換える。
///
/// バックエンドの Valibot 定義から各フィールドの正しい型を特定し、
/// 生成済み Dart ファイルで文字列置換する。
void _patchRemainingDynamic(Directory libDir) {
  // ファイルパス（basename） → {置換前: 置換後}
  //
  // Valibot 定義との対応:
  //   v.unknown()                             → Object?
  //   v.array(v.unknown())                    → List<Object?>
  //   v.optional(v.unknown())                 → Object?
  //   v.null()                                → Object?
  //   v.optional(v.nullable(v.union([num,str]))) → Object?
  final replacements = <String, List<(String, String)>>{
    // EewTelegramBody: eew = v.unknown(), eew*Regions = v.array(v.unknown())
    'eew_telegram_body.dart': [
      ('required dynamic eew,', 'required Object? eew,'),
      (
        'required List<dynamic> eewIntensityRegions,',
        'required List<Object?> eewIntensityRegions,',
      ),
      (
        'required List<dynamic> eewWarningZones,',
        'required List<Object?> eewWarningZones,',
      ),
      (
        'required List<dynamic> eewWarningPrefectures,',
        'required List<Object?> eewWarningPrefectures,',
      ),
      (
        'required List<dynamic> eewWarningRegions,',
        'required List<Object?> eewWarningRegions,',
      ),
    ],
    // TelegramBodyUnion の EEW variant（EewTelegramBody と同じフィールド）
    'telegram_body_union.dart': [
      ('required dynamic eew,', 'required Object? eew,'),
      (
        'required List<dynamic> eewIntensityRegions,',
        'required List<Object?> eewIntensityRegions,',
      ),
      (
        'required List<dynamic> eewWarningZones,',
        'required List<Object?> eewWarningZones,',
      ),
      (
        'required List<dynamic> eewWarningPrefectures,',
        'required List<Object?> eewWarningPrefectures,',
      ),
      (
        'required List<dynamic> eewWarningRegions,',
        'required List<Object?> eewWarningRegions,',
      ),
    ],
    // Telegram.body: v.optional(v.unknown())
    'telegram.dart': [
      ('dynamic body,', 'Object? body,'),
    ],
    // DeviceRegisterResponse.expiresAt: v.null()
    'device_register_response.dart': [
      ('required dynamic expiresAt,', 'required Object? expiresAt,'),
    ],
    // FeedItem.data: swagger_parser が FeedItemData を参照するが、
    // 実際の union 型は FeedItemDataUnion
    'feed_item.dart': [
      ("import 'feed_item_data.dart';", "import 'feed_item_data_union.dart';"),
      ('required FeedItemData data,', 'required FeedItemDataUnion data,'),
    ],
  };

  for (final entry in replacements.entries) {
    final fileName = entry.key;
    final file = File('${libDir.path}/models/$fileName');
    if (!file.existsSync()) {
      continue;
    }

    var content = file.readAsStringSync();
    final original = content;

    for (final (from, to) in entry.value) {
      content = content.replaceAll(from, to);
    }

    if (content != original) {
      file.writeAsStringSync(content);
      stdout.writeln('  Patched: $fileName');
    }
  }
}

/// バックエンドの OpenAPI では `FeedEarthquakeNankaiData.telegramType` が
/// `FeedTelegramType`（地震回数系の enum）を `$ref` しているが、実際の
/// レスポンスは `"NANKAI"` を返すため、そのままではデシリアライズ時に
/// CheckedFromJsonException が発生する。
///
/// バックエンド側のスキーマが修正されるまで、ここで `$ref` を
/// `{"const": "NANKAI"}` に置き換える（後段の `_patchConstPropertiesToTyped`
/// が `String` 型に変換する）。スキーマが既に修正済みなら何もしない。
void _patchNankaiTelegramType(File openapiFile) {
  if (!openapiFile.existsSync()) {
    return;
  }

  final openapi =
      jsonDecode(openapiFile.readAsStringSync()) as Map<String, Object?>;
  final components = openapi['components'] as Map<String, Object?>?;
  final schemas = components?['schemas'] as Map<String, Object?>?;
  final nankai = schemas?['FeedEarthquakeNankaiData'] as Map<String, Object?>?;
  final props = nankai?['properties'] as Map<String, Object?>?;
  final telegramType = props?['telegramType'] as Map<String, Object?>?;

  if (telegramType == null ||
      telegramType[r'$ref'] != '#/components/schemas/FeedTelegramType') {
    stdout.writeln('  Skip (telegramType は FeedTelegramType を参照していません)');
    return;
  }

  props!['telegramType'] = <String, Object?>{'const': 'NANKAI'};

  const encoder = JsonEncoder.withIndent('  ');
  openapiFile.writeAsStringSync(encoder.convert(openapi));
  stdout.writeln(
    '  Patched: FeedEarthquakeNankaiData.telegramType → const "NANKAI"',
  );
}

/// OpenAPI スキーマ内の `const` プロパティを swagger_parser が理解できる
/// 型付きスキーマに変換する。
///
/// swagger_parser は `{"const": "VALUE"}` や `{"const": true}` を解釈できず
/// `dynamic` を出力する。ここで以下の変換を行う:
///
///   `{"const": "VALUE"}`  → `{"type": "string", "description": "const: \"VALUE\""}`
///   `{"const": true}`     → `{"type": "boolean", "description": "const: true"}`
///   `{"const": 123}`      → `{"type": "integer", "description": "const: 123"}`
///   `{"const": 1.5}`      → `{"type": "number", "description": "const: 1.5"}`
///
/// `anyOf` / `oneOf` 内の `const` メンバーも同様に変換する。
/// 変換後の OpenAPI ファイルを上書き保存する。
void _patchConstPropertiesToTyped(File openapiFile) {
  if (!openapiFile.existsSync()) {
    return;
  }

  final content = openapiFile.readAsStringSync();
  final openapi = jsonDecode(content) as Map<String, Object?>;
  var patchCount = 0;

  void patchProperties(Map<String, Object?> props) {
    for (final key in props.keys.toList()) {
      final prop = props[key];
      if (prop is! Map<String, Object?>) {
        continue;
      }

      final unionPatched = _patchUnionOnMap(prop);
      if (unionPatched != null) {
        props[key] = unionPatched;
        patchCount++;
        continue;
      }

      // プロパティ直下の const を変換（nullable を除去）
      if (prop.containsKey('const') && !prop.containsKey('type')) {
        final replaced = _constToTyped(prop);
        if (replaced != null) {
          replaced.remove('nullable');
          props[key] = replaced;
          patchCount++;
        }
      }
    }
  }

  /// JSON ツリーを再帰的に走査し、`properties` を持つ全てのオブジェクトに
  /// const パッチを適用する。components.schemas だけでなく、paths 内の
  /// インラインスキーマやネストされたオブジェクト定義も処理する。
  ///
  /// `components.schemas.DeviceRegistrationType` のようにスキーマ自体が
  /// `anyOf` を持つケースもここで畳む。
  void walkAndPatch(Object? node) {
    if (node is Map<String, Object?>) {
      if (node.containsKey('anyOf') || node.containsKey('oneOf')) {
        final unionPatched = _patchUnionOnMap(node);
        if (unionPatched != null) {
          node
            ..clear()
            ..addAll(unionPatched);
          patchCount++;
        }
      }

      final props = node['properties'];
      if (props is Map<String, Object?>) {
        patchProperties(props);
      }
      // ignore: prefer_foreach
      for (final value in node.values) {
        walkAndPatch(value);
      }
    } else if (node is List) {
      node.forEach(walkAndPatch);
    }
  }

  walkAndPatch(openapi);

  if (patchCount > 0) {
    const encoder = JsonEncoder.withIndent('  ');
    openapiFile.writeAsStringSync(encoder.convert(openapi));
    stdout.writeln('  $patchCount 件の OpenAPI union/const スキーマを型付きに変換しました');
  }
}

/// `anyOf` / `oneOf` union を swagger_parser が解釈できる単一スキーマに変換する。
Map<String, Object?>? _patchUnionOnMap(Map<String, Object?> target) {
  for (final unionKey in ['anyOf', 'oneOf']) {
    final members = target[unionKey];
    if (members is! List) {
      continue;
    }

    // 全メンバーが const であれば enum に変換
    final enumResult = _tryConvertToEnum(target, unionKey, members);
    if (enumResult != null) {
      return enumResult;
    }

    // const メンバーを個別に型付きに変換
    for (var i = 0; i < members.length; i++) {
      final m = members[i];
      if (m is Map<String, Object?> && m.containsKey('const')) {
        final replaced = _constToTyped(m);
        if (replaced != null) {
          members[i] = replaced;
        }
      }
    }

    // 変換後に全メンバーが同じ type を持つ場合、anyOf を単一型に畳む。
    return _collapseUniformAnyOf(target, unionKey, members);
  }
  return null;
}

/// `anyOf` / `oneOf` の全非 null メンバーが文字列 `const` である場合に、
/// `{type: string, enum: [...]}` に変換する。
///
/// swagger_parser は `enum` をネイティブに理解して enum 型を生成するため、
/// `String` に畳むより正確な型が得られる。
///
/// 例:
///   anyOf: [{const: "ACTIVE"}, {const: "GRACE_PERIOD"}]
///   → {type: string, enum: ["ACTIVE", "GRACE_PERIOD"],
///      description: "const: \"ACTIVE\" | const: \"GRACE_PERIOD\""}
Map<String, Object?>? _tryConvertToEnum(
  Map<String, Object?> prop,
  String unionKey,
  List<Object?> members,
) {
  if (members.isEmpty) {
    return null;
  }

  final enumValues = <String>[];
  final descriptions = <String>[];
  var hasNull = false;

  for (final m in members) {
    if (m is! Map<String, Object?>) {
      return null;
    }
    // {type: null} は nullable フラグとして扱う
    if (m['type'] == 'null') {
      hasNull = true;
      continue;
    }
    final constValue = m['const'];
    if (constValue is! String) {
      return null;
    }
    enumValues.add(constValue);
    final desc = m['description'] as String?;
    descriptions.add(desc ?? 'const: "$constValue"');
  }

  if (enumValues.isEmpty) {
    return null;
  }

  final result = Map<String, Object?>.of(prop);
  result.remove(unionKey);
  result['type'] = 'string';
  result['enum'] = enumValues;
  if (hasNull) {
    result['nullable'] = true;
  }

  final existingDesc = prop['description'] as String?;
  final memberDesc = descriptions.join(' | ');
  result['description'] = existingDesc != null
      ? '$existingDesc\n$memberDesc'
      : memberDesc;

  return result;
}

/// `anyOf` / `oneOf` を単一型に畳む。
///
/// - 非 null メンバーが1つだけ → 畳む（nullable array/object を含む）
/// - 非 null メンバーが複数かつ全て同じプリミティブ型 → 畳む
/// - 非 null メンバーが複数の object/array → 畳まない（variant ごとに異なるため）
///
/// sub-schema キー（`items`, `format`, `pattern` 等）は最初の型メンバーから保持する。
Map<String, Object?>? _collapseUniformAnyOf(
  Map<String, Object?> prop,
  String unionKey,
  List<Object?> members,
) {
  if (members.isEmpty) {
    return null;
  }

  String? commonType;
  var hasNull = false;
  final descriptions = <String>[];
  final typedMembers = <Map<String, Object?>>[];

  for (final m in members) {
    if (m is! Map<String, Object?>) {
      return null;
    }
    final type = m['type'] as String?;
    if (type == null) {
      return null;
    }
    if (type == 'null') {
      hasNull = true;
      continue;
    }
    typedMembers.add(m);
    if (commonType == null) {
      commonType = type;
    } else if (commonType != type) {
      return null;
    }
    final desc = m['description'] as String?;
    if (desc != null) {
      descriptions.add(desc);
    }
  }

  if (commonType == null || typedMembers.isEmpty) {
    return null;
  }

  // object/array が複数 variant ある場合は畳まない
  const complexTypes = {'object', 'array'};
  if (typedMembers.length > 1 && complexTypes.contains(commonType)) {
    return null;
  }

  final result = Map<String, Object?>.of(prop);
  result.remove(unionKey);

  // 最初の型メンバーから sub-schema キーをコピー
  final firstMember = typedMembers.first;
  for (final subKey in [
    'type',
    'enum',
    'items',
    'format',
    'pattern',
    'minimum',
    'maximum',
    'minItems',
    'maxItems',
    'minLength',
    'maxLength',
  ]) {
    if (firstMember.containsKey(subKey)) {
      result[subKey] = firstMember[subKey];
    }
  }

  if (hasNull) {
    result['nullable'] = true;
  }

  final existingDesc = prop['description'] as String?;
  final memberDesc = descriptions.isNotEmpty ? descriptions.join(' | ') : null;
  final combinedDesc = [
    ?existingDesc,
    ?memberDesc,
  ].join('\n');
  if (combinedDesc.isNotEmpty) {
    result['description'] = combinedDesc;
  }

  return result;
}

/// `{"const": value, ...rest}` を `{"type": ..., "description": "const: ..."}` に
/// 変換する。既存の `description` がある場合は末尾に追記する。
Map<String, Object?>? _constToTyped(Map<String, Object?> schema) {
  final constValue = schema['const'];
  if (constValue == null) {
    return null;
  }

  final String type;
  final String constRepr;

  switch (constValue) {
    case String():
      type = 'string';
      constRepr = '"$constValue"';
    case bool():
      type = 'boolean';
      constRepr = '$constValue';
    case int():
      type = 'integer';
      constRepr = '$constValue';
    case double():
      type = 'number';
      constRepr = '$constValue';
    default:
      return null;
  }

  final result = Map<String, Object?>.of(schema);
  result.remove('const');
  result['type'] = type;

  final existing = schema['description'] as String?;
  final constDesc = 'const: $constRepr';
  result['description'] = existing != null
      ? '$existing\n$constDesc'
      : constDesc;

  return result;
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
