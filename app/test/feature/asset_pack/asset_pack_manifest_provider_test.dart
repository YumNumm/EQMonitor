import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/notifier/asset_pack_manifest_provider.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Map<String, Object?> _validManifestJson() => {
  'pack_version': '1.2.3',
  'schema_version': 1,
  'generated_at': '2026-07-18T09:00:00+09:00',
  'assets': [
    {
      'id': 'JMA_CODE_TABLE',
      'kind': 'json',
      'path': 'parameters/jma_code_table.json',
      'schema_version': 1,
      'source_version': '20260623',
      'source_updated_at': null,
      'source_urls': <String>[],
      'sha256': 'b' * 64,
      'size_bytes': 2,
    },
  ],
};

/// Builds the provider inside [container] and waits for it to leave the
/// loading state, returning the settled [AsyncValue]. The [container] must
/// keep the provider alive (autodispose would otherwise cut the build short).
Future<AsyncValue<AssetPackManifest>> _settle(ProviderContainer container) {
  final completer = Completer<AsyncValue<AssetPackManifest>>();
  final sub = container.listen<AsyncValue<AssetPackManifest>>(
    assetPackManifestProvider,
    (_, next) {
      if ((next.hasValue || next.hasError) && !completer.isCompleted) {
        completer.complete(next);
      }
    },
    fireImmediately: true,
  );
  return completer.future.whenComplete(sub.close);
}

void main() {
  group('assetPackManifestProvider', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('asset_pack_provider');
    });

    tearDown(() async {
      if (tempDir.existsSync()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('pack ready: exposes the manifest pack_version', () async {
      await File(
        '${tempDir.path}/manifest.json',
      ).writeAsString(jsonEncode(_validManifestJson()));

      final container = ProviderContainer(
        overrides: [
          assetPackRepositoryProvider.overrideWithValue(
            AssetPackRepository(resolvePackRoot: () async => tempDir.path),
          ),
        ],
      );
      addTearDown(container.dispose);

      final result = await _settle(container);
      expect(result.requireValue.packVersion, '1.2.3');
    });

    test(
      'pack not ready: surfaces AssetPackNotReadyException as AsyncError',
      () async {
        final container = ProviderContainer(
          overrides: [
            assetPackRepositoryProvider.overrideWithValue(
              AssetPackRepository(
                resolvePackRoot: () async =>
                    throw const AssetPackNotReadyException('not downloaded'),
              ),
            ),
          ],
        );
        addTearDown(container.dispose);

        final result = await _settle(container);
        expect(result.hasError, isTrue);
        expect(result.error, isA<AssetPackNotReadyException>());
      },
    );
  });
}
