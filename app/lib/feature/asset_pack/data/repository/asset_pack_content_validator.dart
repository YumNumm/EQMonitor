import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_manifest.dart';
import 'package:path/path.dart' as p;

class AssetPackContentException implements Exception {
  const new(this.message);

  final String message;

  @override
  String toString() => 'AssetPackContentException: $message';
}

class AssetPackContentEntry {
  const new({
    required this.id,
    required this.path,
    required this.sha256,
    required this.sizeBytes,
  });

  final String id;
  final String path;
  final String sha256;
  final int sizeBytes;
}

class AssetPackContentValidator {
  const new();

  Future<AssetPackManifest> validate({
    required Directory rootDirectory,
    required String expectedVersion,
  }) async {
    try {
      final manifestJson = await readAssetPackManifestJson(
        rootDirectory: rootDirectory,
      );
      final entries = parseAssetPackContentEntries(manifestJson);
      final manifest = AssetPackManifest.fromJson(manifestJson);
      if (manifest.packVersion != expectedVersion) {
        throw AssetPackContentException('Asset Pack のバージョンが配信情報と一致しません。');
      }
      await verifyAssetPackContentFiles(
        rootDirectory: rootDirectory,
        entries: entries,
      );
      await verifyNoUndeclaredAssetPackFiles(
        rootDirectory: rootDirectory,
        entries: entries,
      );
      return manifest;
    } on AssetPackContentException {
      rethrow;
    } on Object catch (error) {
      throw AssetPackContentException('Asset Pack の内容を検証できませんでした: $error');
    }
  }
}

Future<Map<String, dynamic>> readAssetPackManifestJson({
  required Directory rootDirectory,
}) async {
  final manifestFile = File(p.join(rootDirectory.path, 'manifest.json'));
  if (!manifestFile.existsSync()) {
    throw const AssetPackContentException('manifest.json がありません。');
  }
  final decoded = jsonDecode(await manifestFile.readAsString());
  if (decoded is! Map<String, dynamic>) {
    throw const AssetPackContentException('manifest.json のルートがオブジェクトではありません。');
  }
  return decoded;
}

List<AssetPackContentEntry> parseAssetPackContentEntries(
  Map<String, dynamic> manifestJson,
) {
  final assets = manifestJson['assets'];
  if (assets is! List || assets.isEmpty) {
    throw const AssetPackContentException('manifest.json の assets が不正です。');
  }

  final ids = <String>{};
  final paths = <String>{};
  final entries = <AssetPackContentEntry>[];
  for (var index = 0; index < assets.length; index++) {
    final value = assets[index];
    if (value is! Map<String, dynamic>) {
      throw AssetPackContentException('assets[$index] が不正です。');
    }
    final entry = parseAssetPackContentEntry(value, index: index);
    if (!ids.add(entry.id) || !paths.add(entry.path)) {
      throw AssetPackContentException(
        'manifest.json に重複した ID またはパスがあります: ${entry.path}',
      );
    }
    entries.add(entry);
  }
  return entries;
}

AssetPackContentEntry parseAssetPackContentEntry(
  Map<String, dynamic> json, {
  required int index,
}) {
  final id = requireAssetPackContentString(json, key: 'id', index: index);
  final path = requireAssetPackContentString(json, key: 'path', index: index);
  final contentSha256 = requireAssetPackContentString(
    json,
    key: 'sha256',
    index: index,
  );
  final sizeBytes = json['size_bytes'];
  final shaPattern = RegExp(r'^[0-9a-f]{64}$');
  if (!isSafeAssetPackContentPath(path) ||
      !shaPattern.hasMatch(contentSha256) ||
      sizeBytes is! int ||
      sizeBytes < 0) {
    throw AssetPackContentException('assets[$index] の検証情報が不正です。');
  }
  return AssetPackContentEntry(
    id: id,
    path: path,
    sha256: contentSha256,
    sizeBytes: sizeBytes,
  );
}

String requireAssetPackContentString(
  Map<String, dynamic> json, {
  required String key,
  required int index,
}) {
  final value = json[key];
  if (value is! String || value.isEmpty) {
    throw AssetPackContentException('assets[$index].$key が不正です。');
  }
  return value;
}

bool isSafeAssetPackContentPath(String path) {
  if (path.startsWith('/') ||
      path.contains(r'\') ||
      RegExp(r'^[A-Za-z]:').hasMatch(path)) {
    return false;
  }
  final segments = path.split('/');
  return segments.isNotEmpty &&
      segments.every(
        (segment) => segment.isNotEmpty && segment != '.' && segment != '..',
      );
}

Future<void> verifyAssetPackContentFiles({
  required Directory rootDirectory,
  required List<AssetPackContentEntry> entries,
}) async {
  for (final entry in entries) {
    final file = File(p.join(rootDirectory.path, entry.path));
    if (!file.existsSync() || await file.length() != entry.sizeBytes) {
      throw AssetPackContentException(
        'Asset Pack のファイルサイズが一致しません: ${entry.path}',
      );
    }
    final digest = await sha256.bind(file.openRead()).first;
    if (digest.toString() != entry.sha256) {
      throw AssetPackContentException('Asset Pack のハッシュが一致しません: ${entry.path}');
    }
  }
}

Future<void> verifyNoUndeclaredAssetPackFiles({
  required Directory rootDirectory,
  required List<AssetPackContentEntry> entries,
}) async {
  final declaredPaths = {
    'manifest.json',
    ...entries.map((entry) => entry.path),
  };
  await for (final entity in rootDirectory.list(recursive: true)) {
    if (entity is! File) {
      continue;
    }
    final relativePath = p.relative(entity.path, from: rootDirectory.path);
    if (!declaredPaths.contains(relativePath)) {
      throw AssetPackContentException(
        'Asset Pack に未宣言のファイルがあります: $relativePath',
      );
    }
  }
}
