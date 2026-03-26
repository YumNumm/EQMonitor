import 'dart:io';

void main(List<String> args) async {
  final packageDir = Directory.current;

  await _step('swagger_parser でクライアントコードを生成', () async {
    await _run('dart', ['run', 'swagger_parser'], packageDir.path);
  });

  await _step('Default クライアントを Auth にリネーム (Dart 予約語回避)', () async {
    await _renameDefaultClientToAuth(packageDir);
  });

  await _step(r'$unknown 文字列補間パッチ', () async {
    await _patchDollarUnknown(libDir: Directory('${packageDir.path}/lib'));
  });

  await _step('生成コードの型パッチ (redirect/session)', () async {
    await _patchGeneratedTypes(packageDir);
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

/// Dart の予約語 `default` を避けるため Default クライアントを Auth にリネームする。
Future<void> _renameDefaultClientToAuth(Directory packageDir) async {
  final defaultClientFile = File(
    '${packageDir.path}/lib/clients/default_api_client.dart',
  );
  if (!defaultClientFile.existsSync()) return;

  var content = defaultClientFile.readAsStringSync();
  content = content
      .replaceAll('DefaultApiClient', 'AuthApiClient')
      .replaceAll('default_api_client', 'auth_api_client')
      .replaceAll('_DefaultApiClient', '_AuthApiClient');
  File(
    '${packageDir.path}/lib/clients/auth_api_client.dart',
  ).writeAsStringSync(content);
  defaultClientFile.deleteSync();

  final apiClientFile = File('${packageDir.path}/lib/api_client.dart');
  if (apiClientFile.existsSync()) {
    var ac = apiClientFile.readAsStringSync();
    ac = ac
        .replaceAll(
          'clients/default_api_client.dart',
          'clients/auth_api_client.dart',
        )
        .replaceAll('_default', '_auth')
        .replaceAll('DefaultApiClient', 'AuthApiClient')
        .replaceAll('get default ', 'get auth ');
    apiClientFile.writeAsStringSync(ac);
  }

  final exportFile = File('${packageDir.path}/lib/export.dart');
  if (exportFile.existsSync()) {
    var ex = exportFile.readAsStringSync();
    ex = ex.replaceAll(
      "'clients/default_api_client.dart'",
      "'clients/auth_api_client.dart'",
    );
    exportFile.writeAsStringSync(ex);
  }
}

Future<void> _patchDollarUnknown({required Directory libDir}) async {
  for (final f in libDir.listSync(recursive: true).whereType<File>()) {
    if (!f.path.endsWith('.dart')) continue;
    final original = f.readAsStringSync();
    final patched = original.replaceAll(r'$unknown', r'\$unknown');
    if (patched != original) {
      f.writeAsStringSync(patched);
      stdout.writeln('  Patched: ${f.path}');
    }
  }
}

Future<void> _patchGeneratedTypes(Directory packageDir) async {
  final lib = packageDir.path + '/lib';

  final redirectFile = File('$lib/models/redirect.dart');
  if (redirectFile.existsSync()) {
    var c = redirectFile.readAsStringSync();
    c = c.replaceFirst('final bool? json;', 'final String json;');
    c = c.replaceAll(
      RegExp(
        r'  bool toJson\(\) \{\s*final value = json;.*?return value as bool;\s*\}',
        dotAll: true,
      ),
      '  String toJson() => json;',
    );
    c = c.replaceFirst('json?.toString()', 'json.toString()');
    redirectFile.writeAsStringSync(c);
    stdout.writeln('  Patched: redirect.dart');
  }

  final sessionFile = File('$lib/models/session.dart');
  if (sessionFile.existsSync()) {
    var c = sessionFile.readAsStringSync();
    c = c.replaceAll(
      "@Default('Generated at runtime')\n    DateTime createdAt,",
      'DateTime? createdAt,',
    );
    sessionFile.writeAsStringSync(c);
    stdout.writeln('  Patched: session.dart');
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
