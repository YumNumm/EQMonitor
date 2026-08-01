import 'dart:convert';

import 'package:assets_util/assets_util.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns partial diagnostics when the pack is not ready', () async {
    final repository = AssetPackDebugRepository(
      diagnosePack: () async => diagnostics(status: .assetMissing),
      checkForUpdates: updateResult,
    );

    final info = await repository.diagnose();

    expect(info.diagnostics.status, AssetPackDiagnosticStatus.assetMissing);
    expect(info.assets.single.diagnostic.exists, isFalse);
    expect(info.manifest, isNull);
  });

  test('parses manifest metadata when native diagnostics include it', () async {
    final repository = AssetPackDebugRepository(
      diagnosePack: () async =>
          diagnostics(status: .ready, manifest: validManifest),
      checkForUpdates: updateResult,
    );

    final info = await repository.diagnose();

    expect(info.manifest?.packVersion, '0.0.2');
    expect(info.assets.single.item?.path, 'map/all.pmtiles');
  });
}

AssetPackDiagnostics diagnostics({
  required AssetPackDiagnosticStatus status,
  Map<String, dynamic>? manifest,
}) => AssetPackDiagnostics.fromJsonString(
  jsonEncode({
    'schema_version': 1,
    'platform': 'ios',
    'os_version': 'Version 26.4',
    'pack_id': 'eqmonitor-assets',
    'status': status.name,
    'system_availability': 'unavailable',
    'detail': 'details',
    'manifest_url': 'file:///pack/manifest.json',
    'pack_root': '/pack',
    'manifest': manifest,
    'assets': [
      {
        'path': 'map/all.pmtiles',
        'status': status == AssetPackDiagnosticStatus.ready
            ? 'ready'
            : 'missing',
        'exists': status == AssetPackDiagnosticStatus.ready,
        'expected_size_bytes': 3,
        'actual_size_bytes': status == AssetPackDiagnosticStatus.ready
            ? 3
            : null,
      },
    ],
    'native_error': null,
  }),
);

Future<AssetPackUpdateResult> updateResult() async =>
    AssetPackUpdateResult.fromJsonString(
      jsonEncode({
        'schema_version': 1,
        'pack_id': 'eqmonitor-assets',
        'success': true,
        'checked_at': '2026-07-31T00:00:00Z',
        'updating_ids': <String>[],
        'removed_ids': <String>[],
        'native_error': null,
      }),
    );

final validManifest = <String, dynamic>{
  'schema_version': 1,
  'pack_version': '0.0.2',
  'generated_at': '2026-07-31T00:00:00Z',
  'assets': [
    {
      'id': 'BASE_MAP_PMTILES',
      'kind': 'pmtiles',
      'path': 'map/all.pmtiles',
      'schema_version': 1,
      'source_version': 'test',
      'source_updated_at': null,
      'source_urls': ['https://example.com/all.pmtiles'],
      'sha256': 'a' * 64,
      'size_bytes': 3,
    },
  ],
};
