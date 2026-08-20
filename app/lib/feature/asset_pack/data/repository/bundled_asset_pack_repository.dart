import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_not_ready_exception.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_storage_root_resolver.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bundled_asset_pack_repository.g.dart';

const _bundledAssetKeyPrefix = 'assets/platform/';

final _packVersionPattern = RegExp(r'^\d+\.\d+\.\d+$');

@Riverpod(keepAlive: true)
BundledAssetPackRepository bundledAssetPackRepository(Ref ref) =>
    BundledAssetPackRepository(
      bundle: rootBundle,
      resolveStorageRoot: ref
          .watch(assetPackStorageRootResolverProvider)
          .resolve,
    );

class BundledAssetPackRepository({
  required final AssetBundle _bundle,
  required final ResolveAssetPackStorageRoot _resolveStorageRoot,
}) {
  Future<String>? _inFlight;

  /// 展開済みの同梱 Pack ルートの絶対パスを返す
  Future<String> resolveRoot() {
    if (_inFlight case final inFlight?) {
      return inFlight;
    }
    final extraction = extractBundledPack().onError<Object>((
      error,
      stackTrace,
    ) {
      _inFlight = null;
      if (error is AssetPackNotReadyException) {
        Error.throwWithStackTrace(error, stackTrace);
      }
      throw AssetPackNotReadyException(
        'アプリに同梱された Asset Pack を用意できませんでした: $error',
      );
    });
    _inFlight = extraction;
    return extraction;
  }

  Future<String> extractBundledPack() async {
    final assetKeys = await listBundledAssetKeys();
    final packVersion = await readBundledPackVersion();
    final storageRoot = await _resolveStorageRoot();
    final bundledRoot = Directory(p.join(storageRoot.path, 'bundled'));
    final destination = Directory(p.join(bundledRoot.path, packVersion));
    if (File(p.join(destination.path, 'manifest.json')).existsSync()) {
      return destination.path;
    }

    await bundledRoot.create(recursive: true);
    final staging = await bundledRoot.createTemp('.staging-$packVersion-');
    try {
      for (final key in assetKeys) {
        await writeBundledAsset(
          key: key,
          file: File(
            p.join(staging.path, key.substring(_bundledAssetKeyPrefix.length)),
          ),
        );
      }
      if (destination.existsSync()) {
        await destination.delete(recursive: true);
      }
      await staging.rename(destination.path);
    } on Object catch (error) {
      if (staging.existsSync()) {
        await staging.delete(recursive: true);
      }
      throw AssetPackNotReadyException(
        'アプリに同梱された Asset Pack を展開できませんでした: $error',
      );
    }
    await removeOtherBundledVersions(
      bundledRoot: bundledRoot,
      keepVersion: packVersion,
    );
    return destination.path;
  }

  /// 同梱 Pack を構成する asset key の一覧。
  ///
  /// `.gitkeep` のような隠しファイルは Pack の内容ではないため除外する。
  Future<List<String>> listBundledAssetKeys() async {
    final assetManifest = await AssetManifest.loadFromAssetBundle(_bundle);
    final keys = assetManifest
        .listAssets()
        .where(
          (key) =>
              key.startsWith(_bundledAssetKeyPrefix) &&
              !p.basename(key).startsWith('.'),
        )
        .toList();
    if (!keys.contains('${_bundledAssetKeyPrefix}manifest.json')) {
      throw const AssetPackNotReadyException(
        'アプリに同梱された Asset Pack が見つかりません。',
      );
    }
    return keys;
  }

  Future<String> readBundledPackVersion() async {
    final Object? decoded;
    try {
      decoded = jsonDecode(
        await _bundle.loadString('${_bundledAssetKeyPrefix}manifest.json'),
      );
    } on Object catch (error) {
      throw AssetPackNotReadyException(
        'アプリに同梱された Asset Pack の manifest.json を読み込めませんでした: $error',
      );
    }
    final packVersion = decoded is Map<String, dynamic>
        ? decoded['pack_version']
        : null;
    if (packVersion is! String || !_packVersionPattern.hasMatch(packVersion)) {
      throw const AssetPackNotReadyException(
        'アプリに同梱された Asset Pack の pack_version が不正です。',
      );
    }
    return packVersion;
  }

  Future<void> writeBundledAsset({
    required String key,
    required File file,
  }) async {
    await file.parent.create(recursive: true);
    final data = await _bundle.load(key);
    try {
      await file.writeAsBytes(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
        flush: true,
      );
    } finally {
      _bundle.evict(key);
    }
  }

  Future<void> removeOtherBundledVersions({
    required Directory bundledRoot,
    required String keepVersion,
  }) async {
    await for (final entity in bundledRoot.list()) {
      if (entity is Directory && p.basename(entity.path) != keepVersion) {
        await entity.delete(recursive: true);
      }
    }
  }
}
