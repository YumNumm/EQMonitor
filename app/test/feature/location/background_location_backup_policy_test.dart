import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:xml/xml.dart';

void main() {
  test(
    'Android raw pending preferences are excluded from all backup modes',
    () {
      final manifest = XmlDocument.parse(
        File('android/app/src/main/AndroidManifest.xml').readAsStringSync(),
      );
      final application = manifest.findAllElements('application').single;
      expect(
        application.getAttribute('android:fullBackupContent'),
        '@xml/backup_rules',
      );
      expect(
        application.getAttribute('android:dataExtractionRules'),
        '@xml/data_extraction_rules',
      );

      final legacyRules = XmlDocument.parse(
        File('android/app/src/main/res/xml/backup_rules.xml')
            .readAsStringSync(),
      );
      expect(legacyRules.findAllElements('exclude'), hasLength(1));
      expectBackupExclusion(legacyRules.findAllElements('exclude').single);

      final extractionRules = XmlDocument.parse(
        File('android/app/src/main/res/xml/data_extraction_rules.xml')
            .readAsStringSync(),
      );
      for (final section in ['cloud-backup', 'device-transfer']) {
        final exclude = extractionRules
            .findAllElements(section)
            .single
            .findElements('exclude')
            .single;
        expectBackupExclusion(exclude);
      }
    },
  );
}

void expectBackupExclusion(XmlElement exclude) {
  expect(exclude.getAttribute('domain'), 'sharedpref');
  expect(exclude.getAttribute('path'), 'blt_prefs.xml');
}
