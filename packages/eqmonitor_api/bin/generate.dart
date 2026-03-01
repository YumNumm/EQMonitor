import 'dart:io';

void main(List<String> args) async {
  final externalOpenapiPath = _parseOpenapiFileArg(args);

  final packageDir = Directory.current;
  final openapiFile = File('${packageDir.path}/openapi/openapi.json');
  final libDir = Directory('${packageDir.path}/lib');

  await _step('lib/ を削除', () async {
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
        final copied = src.copySync(openapiFile.path);
        print('copied: ${copied.path}');
      });
    }
  } else {
    throw Exception('OpenAPI ファイルが指定されていません。-openapiFile を指定してください');
  }

  await _step('swagger_parser でクライアントコードを生成', () async {
    await _run('dart', ['run', 'swagger_parser'], packageDir.path);
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

String? _parseOpenapiFileArg(List<String> args) {
  final idx = args.indexOf('-openapiFile');
  if (idx == -1) {
    return null;
  }
  if (idx + 1 >= args.length) {
    stderr.writeln('-openapiFile にはファイルパスを指定してください');
    exit(1);
  }
  return args[idx + 1];
}

Future<void> _step(String label, Future<void> Function() action) async {
  stdout.writeln('\n▶ $label ...');
  final sw = Stopwatch()..start();
  await action();
  stdout.writeln(
    '  Done (${(sw.elapsedMilliseconds / 1000).toStringAsFixed(1)}s)',
  );
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
