import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_content_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory temporaryDirectory;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'asset_pack_content_validator_test_',
    );
  });

  tearDown(() async {
    await temporaryDirectory.delete(recursive: true);
  });

  test('validates every asset and returns the parsed manifest', () async {
    await writePack(
      root: temporaryDirectory,
      assets: const {
        'map/all.pmtiles': 'map-data',
        'parameters/jma.json': '{}',
      },
    );

    final manifest = await const AssetPackContentValidator().validate(
      rootDirectory: temporaryDirectory,
      expectedVersion: '1.2.3',
    );

    expect(manifest.packVersion, '1.2.3');
    expect(manifest.assets, hasLength(2));
  });

  test(
    'rejects an asset unknown to this build when its hash is corrupt',
    () async {
      await writePack(
        root: temporaryDirectory,
        assets: const {
          'map/all.pmtiles': 'map-data',
          'future/data.bin': 'future-data',
        },
        ids: const {
          'map/all.pmtiles': 'BASE_MAP_PMTILES',
          'future/data.bin': 'FUTURE_ASSET',
        },
      );
      await File(
        '${temporaryDirectory.path}/future/data.bin',
      ).writeAsString('corrupt');

      await expectLater(
        const AssetPackContentValidator().validate(
          rootDirectory: temporaryDirectory,
          expectedVersion: '1.2.3',
        ),
        throwsA(isA<AssetPackContentException>()),
      );
    },
  );

  test(
    'rejects a pack version different from the signed distribution entry',
    () async {
      await writePack(
        root: temporaryDirectory,
        assets: const {'map/all.pmtiles': 'map-data'},
      );

      await expectLater(
        const AssetPackContentValidator().validate(
          rootDirectory: temporaryDirectory,
          expectedVersion: '1.2.4',
        ),
        throwsA(isA<AssetPackContentException>()),
      );
    },
  );

  test('rejects missing and size-mismatched assets', () async {
    await writePack(
      root: temporaryDirectory,
      assets: const {'map/all.pmtiles': 'map-data'},
    );
    await File('${temporaryDirectory.path}/map/all.pmtiles').delete();

    await expectLater(
      const AssetPackContentValidator().validate(
        rootDirectory: temporaryDirectory,
        expectedVersion: '1.2.3',
      ),
      throwsA(isA<AssetPackContentException>()),
    );
  });

  test('rejects duplicate and unsafe manifest paths', () async {
    await writePack(
      root: temporaryDirectory,
      assets: const {'map/all.pmtiles': 'map-data'},
      additionalManifestItems: [
        manifestItem(
          id: 'FUTURE_ASSET',
          path: 'map/all.pmtiles',
          content: 'map-data',
        ),
      ],
    );

    await expectLater(
      const AssetPackContentValidator().validate(
        rootDirectory: temporaryDirectory,
        expectedVersion: '1.2.3',
      ),
      throwsA(isA<AssetPackContentException>()),
    );

    await writePack(
      root: temporaryDirectory,
      assets: const {'map/all.pmtiles': 'map-data'},
      additionalManifestItems: [
        manifestItem(
          id: 'FUTURE_ASSET',
          path: '../outside.bin',
          content: 'outside',
        ),
      ],
    );
    await expectLater(
      const AssetPackContentValidator().validate(
        rootDirectory: temporaryDirectory,
        expectedVersion: '1.2.3',
      ),
      throwsA(isA<AssetPackContentException>()),
    );
  });

  test('rejects undeclared files in the extracted pack', () async {
    await writePack(
      root: temporaryDirectory,
      assets: const {'map/all.pmtiles': 'map-data'},
    );
    await File('${temporaryDirectory.path}/undeclared.txt').writeAsString('x');

    await expectLater(
      const AssetPackContentValidator().validate(
        rootDirectory: temporaryDirectory,
        expectedVersion: '1.2.3',
      ),
      throwsA(isA<AssetPackContentException>()),
    );
  });
}

Future<void> writePack({
  required Directory root,
  required Map<String, String> assets,
  Map<String, String> ids = const {},
  List<Map<String, dynamic>> additionalManifestItems = const [],
}) async {
  final items = <Map<String, dynamic>>[];
  for (final entry in assets.entries) {
    final file = File('${root.path}/${entry.key}');
    await file.parent.create(recursive: true);
    await file.writeAsString(entry.value);
    items.add(
      manifestItem(
        id: ids[entry.key] ?? idForPath(entry.key),
        path: entry.key,
        content: entry.value,
      ),
    );
  }
  items.addAll(additionalManifestItems);
  await File('${root.path}/manifest.json').writeAsString(
    jsonEncode({
      'pack_version': '1.2.3',
      'schema_version': 1,
      'generated_at': '2026-08-16T00:00:00.000Z',
      'assets': items,
    }),
  );
}

Map<String, dynamic> manifestItem({
  required String id,
  required String path,
  required String content,
}) => {
  'id': id,
  'kind': path.endsWith('.pmtiles') ? 'pmtiles' : 'json',
  'path': path,
  'schema_version': 1,
  'source_version': 'test',
  'source_updated_at': null,
  'source_urls': <String>[],
  'sha256': sha256.convert(utf8.encode(content)).toString(),
  'size_bytes': utf8.encode(content).length,
};

String idForPath(String path) => switch (path) {
  'map/all.pmtiles' => 'BASE_MAP_PMTILES',
  'parameters/jma.json' => 'JMA_CODE_TABLE',
  _ => 'FUTURE_ASSET',
};
