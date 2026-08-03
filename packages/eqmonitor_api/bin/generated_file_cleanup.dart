import 'dart:io';

import 'legacy_generated_contract.dart';

const generatedWhitespaceDependencyFiles = {
  'bottom_right.dart',
  'correlated_eew.dart',
  'location.dart',
  'merged_events.dart',
  'partition.dart',
  'points.dart',
  'region.dart',
  'test.dart',
  'top_left.dart',
};

bool shouldStripGeneratedWhitespace({required String fileName}) =>
    isLegacyGeneratedContractPath(relativePath: 'models/$fileName') ||
    isLegacyGeneratedContractPath(relativePath: 'clients/$fileName') ||
    fileName == 'catalog.dart' ||
    fileName.startsWith('catalog_') ||
    fileName == 'hypocenters_api_client.dart' ||
    fileName.startsWith('hypocenter_') ||
    fileName.startsWith('archives.') ||
    fileName.startsWith('data2.') ||
    fileName.startsWith('data3.') ||
    fileName == 'shake_detection_api_client.dart' ||
    fileName.startsWith('realtime_') ||
    fileName.startsWith('shake_detection_active_') ||
    generatedWhitespaceDependencyFiles.contains(fileName);

List<File> stripGeneratedTrailingWhitespace({required Directory libDir}) {
  final cleaned = <File>[];
  final dartFiles = libDir.listSync(recursive: true).whereType<File>().where((
    file,
  ) {
    final name = file.uri.pathSegments.last;
    return file.path.endsWith('.dart') &&
        shouldStripGeneratedWhitespace(fileName: name);
  });

  for (final file in dartFiles) {
    final original = file.readAsStringSync();
    final patched =
        '${original.replaceAll(RegExp(r'[ \t]+$', multiLine: true), '').trimRight()}\n';
    if (patched != original) {
      file.writeAsStringSync(patched);
      cleaned.add(file);
    }
  }
  return cleaned;
}
