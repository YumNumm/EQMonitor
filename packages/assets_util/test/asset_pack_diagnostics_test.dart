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
        expect(diagnostics.schemaVersion, 1);
        expect(diagnostics.packIdentifier, 'eqmonitor-assets');
      });
    }

    test('preserves file evidence and nullable paths', () {
      final diagnostics = AssetPackDiagnostics.fromJsonString(
        diagnosticsJson(
          status: 'assetSizeMismatch',
          manifestUrl: null,
          packRoot: null,
          assets: [
            {
              'path': 'map/all.pmtiles',
              'status': 'sizeMismatch',
              'exists': true,
              'expected_size_bytes': 10,
              'actual_size_bytes': 7,
            },
          ],
        ),
      );

      expect(diagnostics.manifestUrl, isNull);
      expect(diagnostics.packRoot, isNull);
      expect(
        diagnostics.assets.single.status,
        AssetPackFileDiagnosticStatus.sizeMismatch,
      );
      expect(diagnostics.assets.single.expectedSizeBytes, 10);
      expect(diagnostics.assets.single.actualSizeBytes, 7);
    });

    test('preserves native errors and manifest JSON', () {
      final diagnostics = AssetPackDiagnostics.fromJsonString(
        diagnosticsJson(
          status: 'manifestUrlResolutionFailed',
          manifest: {'schema_version': 1},
          nativeError: {
            'domain': 'BAErrorDomain',
            'code': 12,
            'description': 'Unavailable',
          },
        ),
      );

      expect(diagnostics.manifestJson, {'schema_version': 1});
      expect(diagnostics.nativeError?.domain, 'BAErrorDomain');
      expect(diagnostics.nativeError?.code, 12);
      expect(diagnostics.nativeError?.description, 'Unavailable');
    });

    test('rejects unknown schema versions', () {
      expect(
        () => AssetPackDiagnostics.fromJsonString(
          diagnosticsJson(status: 'ready', schemaVersion: 2),
        ),
        throwsFormatException,
      );
    });

    test('rejects non-object asset entries with a FormatException', () {
      expect(
        () => AssetPackDiagnostics.fromJsonString(
          jsonEncode({
            'schema_version': 1,
            'platform': 'ios',
            'os_version': 'Version 26.4',
            'pack_id': 'eqmonitor-assets',
            'status': 'ready',
            'system_availability': 'available',
            'detail': 'details',
            'manifest_url': null,
            'pack_root': null,
            'manifest': null,
            'assets': ['invalid'],
            'native_error': null,
          }),
        ),
        throwsFormatException,
      );
    });
  });

  group('AssetPackUpdateResult.fromJsonString', () {
    test('decodes a successful check without implying download completion', () {
      final result = AssetPackUpdateResult.fromJsonString(
        jsonEncode({
          'schema_version': 1,
          'pack_id': 'eqmonitor-assets',
          'success': true,
          'checked_at': '2026-07-31T00:00:00Z',
          'updating_ids': ['b', 'a'],
          'removed_ids': <String>[],
          'native_error': null,
        }),
      );

      expect(result.success, isTrue);
      expect(result.updatingIdentifiers, ['b', 'a']);
      expect(result.nativeError, isNull);
    });

    test('decodes a failed check with native error details', () {
      final result = AssetPackUpdateResult.fromJsonString(
        jsonEncode({
          'schema_version': 1,
          'pack_id': 'eqmonitor-assets',
          'success': false,
          'checked_at': '2026-07-31T00:00:00Z',
          'updating_ids': <String>[],
          'removed_ids': <String>[],
          'native_error': {
            'domain': 'BAErrorDomain',
            'code': 4,
            'description': 'Network unavailable',
          },
        }),
      );

      expect(result.success, isFalse);
      expect(result.nativeError?.code, 4);
    });
  });
}

String diagnosticsJson({
  required String status,
  int schemaVersion = 1,
  String? manifestUrl = 'file:///pack/manifest.json',
  String? packRoot = '/pack',
  Map<String, dynamic>? manifest,
  List<Map<String, dynamic>> assets = const [],
  Map<String, dynamic>? nativeError,
}) => jsonEncode({
  'schema_version': schemaVersion,
  'platform': 'ios',
  'os_version': 'Version 26.4',
  'pack_id': 'eqmonitor-assets',
  'status': status,
  'system_availability': 'available',
  'detail': 'details',
  'manifest_url': manifestUrl,
  'pack_root': packRoot,
  'manifest': manifest,
  'assets': assets,
  'native_error': nativeError,
});
