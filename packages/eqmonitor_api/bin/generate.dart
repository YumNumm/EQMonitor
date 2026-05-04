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
    var patched = original.replaceAll(r'$unknown', r'\$unknown');
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

Future<void> _run(String exe, List<String> args, String cwd) async {
  final process = await Process.start(exe, args, workingDirectory: cwd);
  process.stdout.listen(stdout.add);
  process.stderr.listen(stderr.add);
  final code = await process.exitCode;
  if (code != 0) {
    exit(code);
  }
}
