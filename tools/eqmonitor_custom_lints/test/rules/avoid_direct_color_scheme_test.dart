import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:eqmonitor_custom_lints/src/color_scheme_violation_finder.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  final fixturesDir = p.join(
    Directory.current.path,
    'test',
    'fixtures',
    'avoid_direct_color_scheme',
  );

  test('violation.dart は Theme.of(context).colorScheme を検出する', () {
    final content = File(
      p.join(fixturesDir, 'violation.dart'),
    ).readAsStringSync();
    final result = parseString(content: content, throwIfDiagnostics: false);

    final violations = findColorSchemeViolations(result.unit);

    expect(
      violations,
      isNotEmpty,
      reason: 'violation.dart で avoid_direct_color_scheme が検出されていません',
    );
  });

  test('ok.dart は designSystem.colorTheme 経由のため誤検出されない', () {
    final content = File(p.join(fixturesDir, 'ok.dart')).readAsStringSync();
    final result = parseString(content: content, throwIfDiagnostics: false);

    final violations = findColorSchemeViolations(result.unit);

    expect(violations, isEmpty, reason: 'ok.dart で誤検出が発生しています');
  });
}
