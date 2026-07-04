import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  test('violation.dart は avoid_direct_color_scheme を検出する', () async {
    // NOTE: A pub package cannot declare a dependency on itself, so
    // `dart run custom_lint` cannot self-host inside this package's own
    // root. Instead, `example/` is a sibling package that depends on this
    // package via a `path: ..` dev_dependency and lints the fixtures
    // through `example/fixtures`, which is a symlink to `test/fixtures`.
    final exampleDir = p.join(Directory.current.path, 'example');
    final result = await Process.run(
        'dart',
        [
          'run',
          'custom_lint',
          '--format=json',
        ],
        workingDirectory: exampleDir);

    final lines = const LineSplitter().convert(result.stdout as String);
    final jsonLine = lines.firstWhere(
      (line) => line.trim().startsWith('{'),
      orElse: () => '{}',
    );
    final decoded = jsonDecode(jsonLine) as Map<String, dynamic>;
    final diagnostics = (decoded['diagnostics'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>();

    final violationDiagnostics = diagnostics.where(
      (d) =>
          (d['location']?['file'] as String? ?? '').contains(
            'violation.dart',
          ) &&
          (d['code'] as String? ?? '') == 'avoid_direct_color_scheme',
    );
    final okDiagnostics = diagnostics.where(
      (d) =>
          (d['location']?['file'] as String? ?? '').contains('ok.dart') &&
          (d['code'] as String? ?? '') == 'avoid_direct_color_scheme',
    );

    expect(
      violationDiagnostics,
      isNotEmpty,
      reason: 'violation.dart で avoid_direct_color_scheme が検出されていません',
    );
    expect(
      okDiagnostics,
      isEmpty,
      reason: 'ok.dart で誤検出が発生しています',
    );
  }, timeout: const Timeout(Duration(minutes: 2)));
}
