import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('位置同期の変更範囲では手書きProvider宣言を使用しない', () {
    final forbidden = RegExp(
      r'\b(?:Provider|FutureProvider|StreamProvider|StateProvider|NotifierProvider|AsyncNotifierProvider)(?:<[^;]+>)?\s*\(',
    );
    final violations = <String>[];

    for (final root in [
      Directory('lib/feature/location'),
      Directory('lib/feature/devices'),
      Directory('test/feature/location'),
      Directory('test/feature/devices'),
    ]) {
      for (final entity in root.listSync(recursive: true)) {
        if (entity is! File ||
            !entity.path.endsWith('.dart') ||
            entity.path.endsWith('.g.dart') ||
            entity.path.endsWith('.freezed.dart')) {
          continue;
        }
        final source = entity.readAsStringSync();
        if (forbidden.hasMatch(source)) {
          violations.add(entity.path);
        }
      }
    }

    expect(violations, isEmpty);
  });
}
