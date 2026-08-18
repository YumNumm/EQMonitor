import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_not_ready_exception.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_storage_root_resolver.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bundled_asset_pack_repository.g.dart';

/// `tool/asset_pack/stage_from_r2.sh --target bundled` が `app/assets/platform/`
/// へ配置し、`pubspec.yaml` の `flutter.assets` で同梱される Pack の key prefix。
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

/// アプリに同梱した Asset Pack を、実ファイルとしてアプリ専用ディレクトリへ
/// 展開する。
///
/// Android の APK 内 asset には file path が無く、iOS でも Flutter asset は
/// `flutter_assets` 配下に key 名で置かれるため、manifest 記載の相対 path
/// (`map/all.pmtiles` 等) でそのまま読める形へ一度展開する必要がある。
///
/// 展開先は pack version ごとに分ける。完成品は staging ディレクトリからの
/// rename でしか出現しないので、途中で中断しても半端な Pack が読まれること
/// はない。同梱 Pack が壊れている場合は [AssetPackNotReadyException] を投げ、
/// 偽データへフォールバックしない。
class BundledAssetPackRepository {
  new({
    required AssetBundle bundle,
    required ResolveAssetPackStorageRoot resolveStorageRoot,
  }) : _bundle = bundle,
       _resolveStorageRoot = resolveStorageRoot;

  final AssetBundle _bundle;
  final ResolveAssetPackStorageRoot _resolveStorageRoot;

  /// 起動直後に複数の feature が同時に同梱 Pack を要求しても、展開を一度に
  /// 束ねるための in-flight future。失敗した場合は次の呼び出しで再試行できる
  /// ようクリアする。
  Future<String>? _inFlight;

  /// 展開済みの同梱 Pack ルートの絶対パスを返す。
  ///
  /// 同梱 Pack が使えない理由は、ストレージ障害も含めてすべて
  /// [AssetPackNotReadyException] に寄せる。呼び出し側はこの一種類だけを見て
  /// 「Pack が読めない」と判断できる。
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
      // 基盤地図 PMTiles は数十MB あるため、書き出し後は AssetBundle 側の
      // キャッシュを都度手放してピークメモリを抑える。
      _bundle.evict(key);
    }
  }

  /// アプリ更新で同梱 version が変わったあと、古い展開結果を残さない。
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
