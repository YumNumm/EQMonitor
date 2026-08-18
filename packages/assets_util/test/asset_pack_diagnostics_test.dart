import 'dart:convert';

import 'package:assets_util/src/asset_pack_diagnostics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AssetPackDiagnostics.fromJsonString', () {
    for (final status in AssetPackDiagnosticStatus.values) {
      test('decodes ${status.name}', () {
        final diagnostics = AssetPackDiagnostics.fromJsonString(
          diagnosticsJson(status: status.name),
        );

        expect(diagnostics.status, status);
        expect(diagnostics.schemaVersion, 3);
        expect(diagnostics.packIdentifier, 'platform');
        expect(diagnostics.packRoot, '/pack');
      });
    }

    test('accepts a null pack_root', () {
      final diagnostics = AssetPackDiagnostics.fromJsonString(
        diagnosticsJson(status: 'manifestMissing', packRoot: null),
      );

      expect(diagnostics.packRoot, isNull);
    });

    test('rejects unknown schema versions', () {
      expect(
        () => AssetPackDiagnostics.fromJsonString(
          diagnosticsJson(status: 'ready', schemaVersion: 2),
        ),
        throwsFormatException,
      );
    });

    test('rejects unknown statuses', () {
      expect(
        () => AssetPackDiagnostics.fromJsonString(
          diagnosticsJson(status: 'assetMissing'),
        ),
        throwsFormatException,
      );
    });

    test('rejects a non-object root', () {
      expect(
        () => AssetPackDiagnostics.fromJsonString(jsonEncode(['invalid'])),
        throwsFormatException,
      );
    });
  });
}

String diagnosticsJson({
  required String status,
  int schemaVersion = 3,
  String? packRoot = '/pack',
}) => jsonEncode({
  'schema_version': schemaVersion,
  'platform': 'ios',
  'os_version': 'Version 26.4',
  'pack_id': 'platform',
  'status': status,
  'detail': 'details',
  'pack_root': packRoot,
});
