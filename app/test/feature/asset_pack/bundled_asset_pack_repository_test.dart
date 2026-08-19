import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_not_ready_exception.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/bundled_asset_pack_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory storageRoot;

  setUp(() {
    storageRoot = Directory.systemTemp.createTempSync('bundled_asset_pack_');
  });

  tearDown(() {
    if (storageRoot.existsSync()) {
      storageRoot.deleteSync(recursive: true);
    }
  });

  BundledAssetPackRepository repositoryFor(_FakeAssetBundle bundle) =>
      BundledAssetPackRepository(
        bundle: bundle,
        resolveStorageRoot: () async => storageRoot,
      );

  test('同梱Packをpack_versionごとのディレクトリへ展開する', () async {
    final bundle = _FakeAssetBundle({
      'assets/platform/manifest.json': _manifestBytes(packVersion: '1.2.3'),
      'assets/platform/map/all.pmtiles': _bytes('pmtiles'),
      'assets/platform/parameters/jma_code_table.json': _bytes('{}'),
    });

    final root = await repositoryFor(bundle).resolveRoot();

    expect(root, p.join(storageRoot.path, 'bundled', '1.2.3'));
    expect(File(p.join(root, 'manifest.json')).existsSync(), isTrue);
    expect(
      File(p.join(root, 'map', 'all.pmtiles')).readAsStringSync(),
      'pmtiles',
    );
    expect(
      File(p.join(root, 'parameters', 'jma_code_table.json')).existsSync(),
      isTrue,
    );
  });

  test('展開済みのversionは、次回起動相当の別インスタンスでも再展開しない', () async {
    final bundle = _FakeAssetBundle({
      'assets/platform/manifest.json': _manifestBytes(packVersion: '1.2.3'),
      'assets/platform/map/all.pmtiles': _bytes('pmtiles'),
    });
    await repositoryFor(bundle).resolveRoot();

    final root = await repositoryFor(bundle).resolveRoot();

    expect(root, p.join(storageRoot.path, 'bundled', '1.2.3'));
    expect(
      bundle.loadedKeys.where((key) => key.endsWith('all.pmtiles')).length,
      1,
    );
  });

  test('書き出したassetはbundleのキャッシュから解放する', () async {
    final bundle = _FakeAssetBundle({
      'assets/platform/manifest.json': _manifestBytes(packVersion: '1.2.3'),
      'assets/platform/map/all.pmtiles': _bytes('pmtiles'),
    });

    await repositoryFor(bundle).resolveRoot();

    expect(bundle.evictedKeys, contains('assets/platform/map/all.pmtiles'));
  });

  test('アプリ更新で同梱versionが変わったら古い展開結果を削除する', () async {
    final staleDirectory = Directory(
      p.join(storageRoot.path, 'bundled', '1.0.0'),
    )..createSync(recursive: true);
    final bundle = _FakeAssetBundle({
      'assets/platform/manifest.json': _manifestBytes(packVersion: '1.2.3'),
    });

    await repositoryFor(bundle).resolveRoot();

    expect(staleDirectory.existsSync(), isFalse);
  });

  test('Pack内容ではない隠しファイルは展開しない', () async {
    final bundle = _FakeAssetBundle({
      'assets/platform/manifest.json': _manifestBytes(packVersion: '1.2.3'),
      'assets/platform/.gitkeep': _bytes(''),
    });

    final root = await repositoryFor(bundle).resolveRoot();

    expect(File(p.join(root, '.gitkeep')).existsSync(), isFalse);
  });

  test('manifest.jsonが同梱されていなければAssetPackNotReadyException', () async {
    final bundle = _FakeAssetBundle({
      'assets/platform/map/all.pmtiles': _bytes('pmtiles'),
    });

    await expectLater(
      repositoryFor(bundle).resolveRoot(),
      throwsA(isA<AssetPackNotReadyException>()),
    );
  });

  test('pack_versionが不正ならAssetPackNotReadyException', () async {
    final bundle = _FakeAssetBundle({
      'assets/platform/manifest.json': _manifestBytes(packVersion: 'latest'),
    });

    await expectLater(
      repositoryFor(bundle).resolveRoot(),
      throwsA(isA<AssetPackNotReadyException>()),
    );
  });

  test('manifest.jsonが壊れていればAssetPackNotReadyException', () async {
    final bundle = _FakeAssetBundle({
      'assets/platform/manifest.json': _bytes('not json'),
    });

    await expectLater(
      repositoryFor(bundle).resolveRoot(),
      throwsA(isA<AssetPackNotReadyException>()),
    );
  });

  test('展開に失敗しても次の呼び出しで再試行する', () async {
    var attempts = 0;
    final repository = BundledAssetPackRepository(
      bundle: _FakeAssetBundle({
        'assets/platform/manifest.json': _manifestBytes(packVersion: '1.2.3'),
      }),
      resolveStorageRoot: () async {
        attempts += 1;
        if (attempts == 1) {
          throw const FileSystemException('storage unavailable');
        }
        return storageRoot;
      },
    );
    await expectLater(
      repository.resolveRoot(),
      throwsA(isA<AssetPackNotReadyException>()),
    );

    expect(
      await repository.resolveRoot(),
      p.join(storageRoot.path, 'bundled', '1.2.3'),
    );
    expect(attempts, 2);
  });

  test('同時に要求されても展開は一度だけ走る', () async {
    final bundle = _FakeAssetBundle({
      'assets/platform/manifest.json': _manifestBytes(packVersion: '1.2.3'),
      'assets/platform/map/all.pmtiles': _bytes('pmtiles'),
    });
    final repository = repositoryFor(bundle);

    final roots = await Future.wait([
      repository.resolveRoot(),
      repository.resolveRoot(),
      repository.resolveRoot(),
    ]);

    expect(roots.toSet(), hasLength(1));
    expect(
      bundle.loadedKeys.where((key) => key.endsWith('all.pmtiles')).length,
      1,
    );
  });
}

Uint8List _bytes(String value) => Uint8List.fromList(utf8.encode(value));

Uint8List _manifestBytes({required String packVersion}) => _bytes(
  jsonEncode({
    'pack_version': packVersion,
    'schema_version': 1,
    'generated_at': '2026-08-19T00:00:00Z',
    'assets': <Object?>[],
  }),
);

/// `AssetManifest.bin` を含む、Flutter の asset bundle の最小実装。
class _FakeAssetBundle extends CachingAssetBundle {
  new(this._assets);

  final Map<String, Uint8List> _assets;
  final List<String> loadedKeys = [];
  final List<String> evictedKeys = [];

  @override
  Future<ByteData> load(String key) async {
    loadedKeys.add(key);
    if (key == 'AssetManifest.bin') {
      final message = const StandardMessageCodec().encodeMessage(
        <String, Object?>{
          for (final assetKey in _assets.keys) assetKey: <Object?>[],
        },
      );
      if (message == null) {
        throw StateError('failed to encode AssetManifest.bin');
      }
      return message;
    }
    final value = _assets[key];
    if (value == null) {
      throw StateError('Unable to load asset: $key');
    }
    return ByteData.view(
      value.buffer,
      value.offsetInBytes,
      value.lengthInBytes,
    );
  }

  @override
  void evict(String key) {
    evictedKeys.add(key);
    super.evict(key);
  }
}
