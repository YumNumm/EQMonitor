import 'dart:io';

import 'package:test/test.dart';

import '../bin/generated_file_cleanup.dart';

void main() {
  test('震源APIの生成ファイルから末尾空白を除去する', () {
    final directory = Directory.systemTemp.createTempSync(
      'eqmonitor-api-cleanup-',
    );
    addTearDown(() => directory.deleteSync(recursive: true));
    final files =
        [
              'hypocenters_api_client.dart',
              'hypocenter_manifest_response.dart',
              'hypocenter_manifest_response.freezed.dart',
              'archives.dart',
              'archives.freezed.dart',
              'data2.dart',
              'data3.dart',
              'partition.dart',
              'parameters_manifest_response.freezed.dart',
            ]
            .map(
              (name) =>
                  File('${directory.path}/$name')..writeAsStringSync('x  \n'),
            )
            .toList();

    stripGeneratedTrailingWhitespace(libDir: directory);

    for (final file in files) {
      expect(file.readAsStringSync(), 'x\n', reason: file.path);
    }
  });

  test('対象外の生成ファイルは変更しない', () {
    final directory = Directory.systemTemp.createTempSync(
      'eqmonitor-api-cleanup-',
    );
    addTearDown(() => directory.deleteSync(recursive: true));
    final file = File('${directory.path}/unrelated.dart')
      ..writeAsStringSync('x  \n');

    stripGeneratedTrailingWhitespace(libDir: directory);

    expect(file.readAsStringSync(), 'x  \n');
  });
}
